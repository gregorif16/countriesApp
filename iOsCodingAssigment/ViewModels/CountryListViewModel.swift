//
//  CountryListViewModel.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias on 19/3/24.
//

import Foundation
import Combine

final class CountryListViewModel {
    
    let countryUseCase: CountryUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var countries: [Country] = []
    var filteredCountries: [Country] = []
    
    init(countryUseCase: CountryUseCaseProtocol = CountryUseCase()) {
        self.countryUseCase = countryUseCase
    }
    
    func loadCountries() {
        countryUseCase.getCountries { [weak self] countries, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching countries: \(error)")
            } else if let countries = countries {
                self.countries = countries
                self.filteredCountries = countries
            }
        }
    }
    
    func filterCountries(by searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.capital.lowercased().contains(searchText.lowercased())}
        }
    }
}
