//
//  SearchPageViewController.swift
//  Weather
//
//  Created by Karan T Rai on 15/06/21.
//

import UIKit

class SearchPageViewController:UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var homeViewModel = HomeViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchResultTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchResultTable.delegate = self
        self.searchResultTable.dataSource = self
        
        self.searchResultTable.reloadData()
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        
        homeViewModel.fetchWeather(ofCityName: city)
        homeViewModel.addRecentSearch()
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.recentSearchCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as? RecentSearchCell {
            let weatherReport = homeViewModel.fetchRecentSearchCity(atIndex: indexPath.row)
            cell.cityName.text = weatherReport.cityName
            self.searchResultTable.reloadData()
        }
        
        return UITableViewCell()
    }
    
}
