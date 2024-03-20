//
//  CountryListViewController.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 19/3/24.
//

import UIKit
import Combine
import CombineCocoa

    class CountryListViewController: UIViewController {
        
       
        @IBOutlet weak var searchbar: UISearchBar!
        @IBOutlet weak var countryList: UITableView!
        
        var viewModel: CountryListViewModel
            private var cancellables = Set<AnyCancellable>()
            
            init(viewModel: CountryListViewModel) {
                self.viewModel = viewModel
                super.init(nibName: nil, bundle: nil)
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                // Deactivate navigation backwards
                navigationController?.isNavigationBarHidden = true
                navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                
                // Eliminate the background of the searchbar
                searchbar.backgroundImage = UIImage()
                
                // Activation of search bar
                searchbar.delegate = self
                
                let nib = UINib(nibName: "TableViewCell", bundle: nil)
                countryList.register(nib, forCellReuseIdentifier: "CountryCell")
                
                countryList.dataSource = self
                countryList.delegate = self
                
                viewModel.$countries
                            .sink { [weak self] _ in
                                DispatchQueue.main.async {
                                    self?.countryList.reloadData()
                                }
                            }
                            .store(in: &cancellables)
                        
                        viewModel.loadCountries()
                    
            }
            
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                navigationController?.setNavigationBarHidden(true, animated: animated)
            }
            
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                navigationController?.setNavigationBarHidden(false, animated: animated)
            }
        }

        extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return viewModel.filteredCountries.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! TableViewCell
                let country = viewModel.filteredCountries[indexPath.row]
                
                cell.countryRegionLabel.text = "\(country.name), \(country.region)"
                cell.codeLabel.text = country.code
                cell.capitalLabel.text = country.capital
                
                return cell
            }
        }

        extension CountryListViewController: UISearchBarDelegate {
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                viewModel.filterCountries(by: searchText)
                countryList.reloadData()
            }
        }
