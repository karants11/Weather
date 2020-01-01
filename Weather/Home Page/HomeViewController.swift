//
//  HomeViewController.swift
//  Weather
//
//  Created by Karan T Rai on 10/06/21.
//

import UIKit
import CoreLocation


class HomeViewController: UIViewController, WeatherDataProtocol, CLLocationManagerDelegate {

    let homeViewModel = HomeViewModel()
    let locationManager = CLLocationManager()

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
        
        self.weatherDiscriptionCollectionView.contentSize.width = 185
        
        self.homeViewModel.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let currentCoordinate: Coordinates = Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        self.homeViewModel.fetchWeather(coordinates: currentCoordinate)
    }
    
    @IBAction func hamburgerMenu(_ sender: Any) {
        menuView.isHidden = false
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
        
        if sender.isSelected == true {
            self.homeViewModel.addCurrentCityToFavourite()
        }else {
            self.homeViewModel.removeFromFavourite()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? FavouriteTableViewController {
            destinationViewController.delegate = self
            if segue.identifier == SegueIdentifiers.recentSearch.rawValue {
                self.menuView.isHidden = true
                destinationViewController.tableTitleVar = TableViewTitle.recentSearch.rawValue
                destinationViewController.currentPage = .recentSearch
                destinationViewController.homeViewModel = self.homeViewModel
                

            }else if segue.identifier == SegueIdentifiers.favourites.rawValue {
                self.menuView.isHidden = true
                destinationViewController.tableTitleVar = TableViewTitle.favourites.rawValue
                destinationViewController.currentPage = .favourites
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
            self.weatherDiscriptionImage.image = UIImage.weatherDescribing(weatherCondition: currentCity.weatherDescription[0])
            
            if self.homeViewModel.isFavourite(cityName: currentCity.cityName) {
                self.favouriteButton.isSelected = true
            }else {
                self.favouriteButton.isSelected = false
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

extension HomeViewController: FavouriteCheckProtocol {
    func isHomePageContentFavourite() {
        if !self.homeViewModel.isFavourite(cityName: self.homeViewModel.homeCityReport.cityName) {
            self.favouriteButton.isSelected = false
        }
    }
    
    
}
