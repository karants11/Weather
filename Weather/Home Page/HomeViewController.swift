//
//  HomeViewController.swift
//  Weather
//
//  Created by Karan T Rai on 10/06/21.
//

import UIKit
import CoreLocation


class HomeViewController: UIViewController, WeatherDataProtocol {

    let homeViewModel = HomeViewModel()
    
    var isDataReady: Bool = false
    
    
    @IBOutlet weak var favouriteButton: ToggleButton!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var dayDateTime: UILabel!
    
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet weak var weatherDiscriptionImage: UIImageView!
    
    @IBOutlet weak var currentTemperature: UILabel!
    
    @IBOutlet weak var weatherDiscription: UILabel!
    
    @IBOutlet weak var weatherDiscriptionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.backgroungColor()

        self.navigationController?.navigationBar.isHidden = true
        //self.navigationController?.navigationBar.backgroundColor = .clear
        
        weatherDiscriptionCollectionView.contentSize.width = 185
        
        self.homeViewModel.delegate = self

        let city = "Mangaluru"
        homeViewModel.fetchWeather(ofCityName: city)
        

        
    }
    
    @IBAction func hamburgerMenu(_ sender: Any) {
        
        menuView.isHidden = false
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let pvc = storyboard.instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
//            pvc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            self.present(pvc, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func celeciusToFarenheit(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // display °C of temperature
            DispatchQueue.main.async {
                self.currentTemperature.text = String(Int(self.homeViewModel.homeCityReport.temperature))
            }
        }else if sender.selectedSegmentIndex == 1 {
            // convert °C to °F using (0°C × 9/5) + 32 = 32°F equation and print
            DispatchQueue.main.async {
                self.currentTemperature.text = String(Int(self.homeViewModel.homeCityReport.temperature) * 9/5 + 32)
            }
        }
    }
    @IBAction func homeButton(_ sender: Any) {
        self.menuView.isHidden = true
    }
    
    
    @IBAction func favouriteButton(_ sender: Any) {

    }
    
    @IBAction func recentSearch(_ sender: Any) {
        
    }
    
    @IBAction func favourite(_ sender: ToggleButton) {
        
        if sender.isSelected {
            self.homeViewModel.addCurrentCityToFavourite()
        }else {
            self.homeViewModel.removeFromFavourite()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{

        if identifier == "RecentSearch" {
            
        }
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? FavouriteTableViewController {
            if segue.identifier == segueIdentifiers.recentSearch.rawValue {
                
                destinationViewController.navigationController?.title = tableViewTitle.recentSearch.rawValue
                destinationViewController.homeViewModel = self.homeViewModel

            }else if segue.identifier == segueIdentifiers.favourites.rawValue {
                
                destinationViewController.navigationController?.title = tableViewTitle.favourites.rawValue
                destinationViewController.homeViewModel = self.homeViewModel
            }
        }
        
        if let destinationViewController = segue.destination as? SearchPageViewController {
            
            destinationViewController.homeViewModel = self.homeViewModel
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.menuView {
            self.menuView.isHidden = true
        }
    }
    
    func weatherReportRecieved() {
        // update the home page and the favourites
        
        print("weather Report recieved")

        DispatchQueue.main.async {
            let currentCity = self.homeViewModel.homeCityReport
                
            self.place.text = currentCity.cityName
            self.currentTemperature.text = String(Int(currentCity.temperature))
            self.weatherDiscription.text = currentCity.weatherDescription[0]
            self.dayDateTime.text = Date.currentDateAndTime()
            
            if self.homeViewModel.isFavourite(cityName: currentCity.cityName) {
                self.favouriteButton.isSelected = true
            }else {
                self.favouriteButton.isSelected = true
            }
            
            self.isDataReady = true
            self.weatherDiscriptionCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isDataReady {
            return 0
        }else {
            return 4
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherConditionCell", for: indexPath) as? WeatherConditionCell {
            
            DispatchQueue.main.async {
                cell.heading.text = weatherDiscriptionArray[indexPath.row]
                cell.data.text = self.homeViewModel.homeCityWeatherDetail(atIndex: indexPath.row)
                if let image =  weatherDiscriptionImageArray[indexPath.row] {
                    cell.image.image = image
                }
            }
           
            return cell
        }else {
            return UICollectionViewCell()
        } 
    }

}
