//
//  FavouriteTableViewController.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

class FavouriteTableViewController: UIViewController {
    
    @IBOutlet weak var cityWeatherList: UITableView!
    
    @IBOutlet weak var tableTitle: tavleViewTitleLable!
    
    @IBOutlet weak var emptyImage: UIImageView!
    
    @IBOutlet weak var totalNumberOfFavourites: CoustomLabels!
    
    @IBOutlet weak var removeAllContentButton: clearBackgroundWhiteFontButton!
    
    var homeViewModel = HomeViewModel()
    var tableTitleVar = ""
    var currentPage: SegueIdentifiers = .favourites
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityWeatherList.delegate = self
        cityWeatherList.dataSource = self
        
        self.view.backgroundColor = UIColor.backgroungColor()
        self.cityWeatherList.backgroundColor = UIColor.clear

        self.cityWeatherList.separatorStyle = .none
        self.cityWeatherList.rowHeight = 80
        
        self.tableTitle.text = tableTitleVar
            
        self.cityWeatherList.reloadData()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    @IBAction func removeAllFavourites(_ sender: Any) {
        
        if currentPage == .favourites {
            self.homeViewModel.favourites.removeAll()
            self.cityWeatherList.reloadData()
        }else {
            self.homeViewModel.recentSearches.removeAll()
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
        
        self.cityWeatherList.reloadData()
    }
    

}

extension FavouriteTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // called whenever any cell is clicked
        // indexPath gives (coloumn, row) of the cell being clicked
        
        print("tapped Me at \(indexPath.row)")
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
                self.emptyImage.isHidden = false
                self.totalNumberOfFavourites.isHidden = true
                self.removeAllContentButton.isHidden = true
            }
            return homeViewModel.favCount
        }else {
            if homeViewModel.recentSearchCount == 0 {
                self.emptyImage.image = UIImage.emptyTableViewImage()
                self.emptyImage.isHidden = false
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
    
}

