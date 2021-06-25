//
//  FavouriteTableViewController.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

protocol FavouriteCheckProtocol: AnyObject {
    func isHomePageContentFavourite()
    func reloadHomePageData()
}

class FavouriteTableViewController: UIViewController {
    
    weak var delegate: FavouriteCheckProtocol?
        
    @IBOutlet weak var cityWeatherList: UITableView!
    
    @IBOutlet weak var tableTitle: tavleViewTitleLable!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var emptyImage: UIImageView!
    
    @IBOutlet weak var totalNumberOfFavourites: CoustomLabels!
    
    @IBOutlet weak var removeAllContentButton: clearBackgroundWhiteFontButton!
    
    @IBOutlet weak var emptyIndicatorText: whiteTextLableFont18!
    
    var homeViewModel = HomeViewModel()
    var tableTitleVar = ""
    var currentPage: SegueIdentifiers = .favourites
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityWeatherList.delegate = self
        self.cityWeatherList.dataSource = self
        self.searchBar.delegate = self
        
        self.searchBar.isHidden = true
        self.view.backgroundColor = UIColor.backgroungColor()
        self.cityWeatherList.backgroundColor = UIColor.clear

        self.cityWeatherList.separatorStyle = .none
        self.cityWeatherList.rowHeight = 80
        
        self.tableTitle.text = tableTitleVar
        
        if currentPage == .favourites {
            self.totalNumberOfFavourites.text = String.favouriteListDisplay(favCount: self.homeViewModel.favCount)
            
        }else if currentPage == .recentSearch {
            self.totalNumberOfFavourites.text = String.recentListDisplay()
        }
        
        self.cityWeatherList.reloadData()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.delegate?.isHomePageContentFavourite()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func removeAllFavourites(_ sender: Any) {
        
        if currentPage == .favourites {
            
            let alert = UIAlertController(title: removeAllFavoritesAlertTitle, message: removeAllFavouritesAlertMessage, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default) { action in
                self.homeViewModel.clearFavourites()
                self.cityWeatherList.reloadData()
            })
            self.present(alert, animated: true)
            
        }else {
            self.homeViewModel.clearRecentSearch()
            self.cityWeatherList.reloadData()
        }

    }
    
    @IBAction func favouriteButton(_ sender: ToggleButton) {
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UITableViewCell else {
            //print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = cityWeatherList.indexPath(for: cell) else {
            //print("failed to get index path for cell containing button")
            return
        }
        
        if currentPage == .favourites {
            if sender.isSelected {
                // will not execute
                self.homeViewModel.addCurrentCityToFavourite()
            }else {
                
                self.homeViewModel.removeCityFromFavourite(atIndex: indexPath.row)
            }
        }else {
            if sender.isSelected {
                
                self.homeViewModel.addRecentToFavourite(ofIndex: indexPath.row)
            }else {
                
                self.homeViewModel.removeCityFromFavourite(atIndex: indexPath.row)
            }
        }
        if currentPage == .favourites {
            self.totalNumberOfFavourites.text = String.favouriteListDisplay(favCount: self.homeViewModel.favCount)
        }else if currentPage == .recentSearch {
            self.totalNumberOfFavourites.text = String.recentListDisplay()
        }
        self.cityWeatherList.reloadData()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        self.tableTitle.isHidden = !self.tableTitle.isHidden
        self.searchBar.isHidden = !self.searchBar.isHidden
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        self.searchBar.isHidden = true
        self.tableTitle.isHidden = false
        
    }
    
    

}

extension FavouriteTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // called whenever any cell is clicked
        // indexPath gives (coloumn, row) of the cell being clicked
        if currentPage == .favourites {
            self.homeViewModel.homeCityReport = self.homeViewModel.fetchFavouriteCity(atIndex: indexPath.row)
        }else if currentPage == .recentSearch {
            self.homeViewModel.homeCityReport = self.homeViewModel.fetchRecentSearchCity(atIndex: indexPath.row)
        }
        
        self.delegate?.isHomePageContentFavourite()
        self.delegate?.reloadHomePageData()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
}
    
extension FavouriteTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if currentPage == .favourites {
            if homeViewModel.favCount == 0 {
                self.emptyImage.image = UIImage.emptyTableViewImage()
                self.emptyIndicatorText.text = String.noFavourites()
                self.emptyImage.isHidden = false
                self.emptyIndicatorText.isHidden = false
                self.totalNumberOfFavourites.isHidden = true
                self.removeAllContentButton.isHidden = true
            }
            return homeViewModel.favCount
        }else {
            if homeViewModel.recentSearchCount == 0 {
                self.emptyImage.image = UIImage.emptyTableViewImage()
                self.emptyIndicatorText.text = String.noRecentSearch()
                self.emptyImage.isHidden = false
                self.emptyIndicatorText.isHidden = false
                self.totalNumberOfFavourites.isHidden = true
                self.removeAllContentButton.isHidden = true
            }
            return homeViewModel.recentSearchCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentPage == .favourites {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? favouriteCell {
                cell.backgroundColor = .clear
                    
                let city = homeViewModel.fetchFavouriteCity(atIndex: indexPath.row)
                
                cell.cityName.text = city.cityName
                cell.currentTemperature.text = String(Int(city.temperature))
                cell.weatherCondition.text = city.weatherDescription[0]
                cell.weatherImage.image = UIImage.weatherDescribing(weatherCondition: city.weatherDescription[0])
                cell.favButton.isSelected = true
                
                return cell
            }else {
                return UITableViewCell()
            }
        
        }else if currentPage == .recentSearch {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? favouriteCell {
                cell.backgroundColor = .clear
                
                let city = homeViewModel.fetchRecentSearchCity(atIndex: indexPath.row)
                
                cell.cityName.text = city.cityName
                cell.currentTemperature.text = String(Int(city.temperature))
                cell.weatherCondition.text = city.weatherDescription[0]
                cell.weatherImage.image = UIImage.weatherDescribing(weatherCondition: city.weatherDescription[0])
                
                if homeViewModel.isFavourite(cityName: city.cityName) {
                    cell.favButton.isSelected = true
                }else {
                    cell.favButton.isSelected = false
                }
                
                return cell
            }else {
                return UITableViewCell()
            }
        }
        

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if currentPage == .favourites {
                self.homeViewModel.removeCityFromFavourite(atIndex: indexPath.row)
            }else if currentPage == .recentSearch {
                self.homeViewModel.recentSearches.remove(at: indexPath.row)
            }
            cityWeatherList.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FavouriteTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch currentPage {
            case .favourites: do {
                self.homeViewModel.favourites.removeAll()

                if searchText == "" {
                    
                    self.homeViewModel.retriveFavourites()
                    self.emptyImage.isHidden = true
                    self.emptyIndicatorText.isHidden = true
                    
                    
                }else {
                    self.totalNumberOfFavourites.isHidden = false
                    self.removeAllContentButton.isHidden = false
                    
                    for favourite in self.homeViewModel.favCopy {
                        if favourite.lowercased().contains(searchText.lowercased()) {
                            self.homeViewModel.favourites.append(favourite)
                        }
                    }
                }
                self.cityWeatherList.reloadData()
            }
            
            case .recentSearch: do {
                self.homeViewModel.recentSearches.removeAll()

                if searchText == "" {
                    self.homeViewModel.retrieveRecentSearch()
                    self.emptyImage.isHidden = true
                    self.emptyIndicatorText.isHidden = true
                    
                }else {
                    self.totalNumberOfFavourites.isHidden = false
                    self.removeAllContentButton.isHidden = false
                    
                    for recentSearch in self.homeViewModel.recentSearchCopy {
                        if recentSearch.lowercased().contains(searchText.lowercased()) {
                            self.homeViewModel.recentSearches.append(recentSearch)
                        }
                    }
                }
                self.cityWeatherList.reloadData()
            }
            
        }
    }
}

