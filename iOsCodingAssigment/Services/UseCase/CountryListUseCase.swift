//
//  CountryListUseCase.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias  on 19/3/24.
//

import Foundation

protocol CountryUseCaseProtocol {
    func getCountries(onSuccess: @escaping ([Country]) -> Void, onError: @escaping (NetworkError) -> Void)
}

final class CountryUseCase: CountryUseCaseProtocol {
    func getCountries(onSuccess: @escaping ([Country]) -> Void, onError: @escaping (NetworkError) -> Void) {
            
        
            guard let url = URL(string: "\(EndPoints.url.rawValue)") else {
                onError(.malformedURL)
                return
            }
            
          
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
      
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    onError(.other)
                    return
                }
                guard let data = data else {
                    onError(.noData)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                    onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                    return
                }
              
                do {
                    let decodedData = try JSONDecoder().decode([Country].self, from: data)
                    onSuccess(decodedData)
                } catch {
                    onError(.decoding)
                }
            }
            task.resume()
        }
    }

