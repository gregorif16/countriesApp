//
//  CountryListViewModel.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 19/3/24.
//

import Foundation

final class CountryListViewModel {
    
    let countryUseCase: CountryUseCaseProtocol
    
    var countries: [Country] = []
    var filteredCountries: [Country] = [] //Variable for the search
    init(countryUseCase: CountryUseCaseProtocol = CountryUseCase()) {
        self.countryUseCase = countryUseCase
    }
    
    func loadCountries(completion: @escaping () -> Void) {
        countryUseCase.getCountries { [weak self] countries in
            self?.countries = countries
            completion()
            
        } onError: { error in
      
        }
    }
        
    
    func filterCountries(by searchText: String) {
            if searchText.isEmpty {
                filteredCountries = countries
            } else {
                filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) || countries.filter { $0.capital.lowercased().contains(searchText.lowercased())  }
            }
        }
}
