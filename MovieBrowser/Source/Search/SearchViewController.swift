//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
//import XCTest

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var querySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var searchResult: SearchResults!
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        debugPrint("inside searchBarTextDidEndEditing: \(searchBar.text ?? "")")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        debugPrint("inside shouldChangeTextIn")
        return true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("inside searchBarSearchButtonClicked")
        let apiNetworkManager = Network()
        
        apiNetworkManager.getSearchResults(queryString: searchBar.text ?? "") { data, response, error in
            let decoder = JSONDecoder()
            let str = String(data: data!, encoding: String.Encoding.utf8) ?? ""
            debugPrint("\(str)")
            
            do {
                if data != nil {
                    let decodedData = try decoder.decode(SearchResults.self, from: data!)
                    self.searchResult = decodedData
                } else {
                    debugPrint("data not found")
                }
            } catch {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchResult = nil
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( self.searchResult != nil && self.searchResult?.results != nil ) {
            return (self.searchResult?.results?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.searchResult != nil {
                let models = self.searchResult?.results as! [MovieModel]
                    if ( models != nil && indexPath.row < models.count ) {
                        let model = models[indexPath.row] as! MovieModel
                        if model != nil {
                            let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailView", bundle: .main)
                            movieDetailVC.movieModel = model
                            self.navigationController?.pushViewController(movieDetailVC, animated: true)
                        }
                    }
            }
        }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell

        if self.searchResult != nil {
            let models = self.searchResult?.results as! [MovieModel]
                if ( models != nil && indexPath.row < models.count ) {
                    let model = models[indexPath.row] as! MovieModel
                    if model != nil {                                                
                        let str = String(format: "%.2f", model.popularity!) ?? "" // 3.14
                        cell.titleLabel?.text = model.title
                        cell.releaseDateLabel?.text = model.release_date
                        cell.popularityLabel?.text = str
                    }
                }
            
            return cell
        }
        return UITableViewCell()
    }
}
