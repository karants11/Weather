//
//  FavouriteTableViewController.swift
//  Weather
//
//  Created by Karan T Rai on 14/06/21.
//

import UIKit

class FavouriteTableViewController: UIViewController {
    
    @IBOutlet weak var cityWeatherList: UITableView!
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityWeatherList.delegate = self
        cityWeatherList.dataSource = self
        
        self.view.backgroundColor = UIColor.backgroungColor()
        self.cityWeatherList.backgroundColor = UIColor.clear
//        self.cityWeatherList.separatorStyle = .singleLine
        //self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        //self.navigationController?.title = "Favourite"
        self.cityWeatherList.separatorStyle = .none
        self.cityWeatherList.rowHeight = 80
        
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

        return homeViewModel.favCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as? favouriteCell {
            cell.backgroundColor = .clear
            cell.favButton.isSelected = true
            
            let city = homeViewModel.fetchFavouriteCity(atIndex: indexPath.row)
            
            cell.cityName.text = city.cityName
            cell.currentTemperature.text = String(Int(city.temperature))
            cell.weatherCondition.text = city.weatherDescription[0]
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
}

