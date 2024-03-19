//
//  CountryListViewController.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 19/3/24.
//

import UIKit


    class CountryListViewController: UIViewController {
        
       
        @IBOutlet weak var searchbar: UISearchBar!
        @IBOutlet weak var countryList: UITableView!
        
        var viewModel: CountryListViewModel
        
        init(viewModel: CountryListViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Deactivate navegation backwards
            navigationController?.isNavigationBarHidden = true
                navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            
            //To eleminate the background of the searchbar
            searchbar.backgroundImage = UIImage()
            
            //Activation of searcbar
            searchbar.delegate = self
            
            let nib = UINib(nibName: "TableViewCell", bundle: nil)
            countryList.register(nib, forCellReuseIdentifier: "CountryCell")
            
           
            countryList.dataSource = self
            countryList.delegate = self
            
           
            viewModel.loadCountries {
                DispatchQueue.main.async {
                    self.countryList.reloadData()
                }
            }
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
            if !searchBarIsEmpty() {
                        return viewModel.filteredCountries.count
                    } else {

                        return viewModel.countries.count
                    }
        }
        
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! TableViewCell
            var country: Country
            
            // Use filteredCountries if searchText is not empty
            if !searchBarIsEmpty() {
                country = viewModel.filteredCountries[indexPath.row]
            } else {
                country = viewModel.countries[indexPath.row]
            }
            
            
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
        
        func searchBarIsEmpty() -> Bool {

                return searchbar.text?.isEmpty ?? true
            }
    }
