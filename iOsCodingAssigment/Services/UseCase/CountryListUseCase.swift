//
//  CountryListUseCase.swift
//  iOsCodingAssigment
//
//  Created by Gregori Farias  on 19/3/24.
//
import Foundation
import Combine

protocol CountryUseCaseProtocol {
    func getCountries(completion: @escaping ([Country]?, NetworkError?) -> Void)
}

final class CountryUseCase: CountryUseCaseProtocol {
    func getCountries(completion: @escaping ([Country]?, NetworkError?) -> Void) {
        guard let url = URL(string: "\(EndPoints.url.rawValue)") else {
            completion(nil, .malformedURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(nil, .other)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                completion(nil, .errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Country].self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, .decoding)
            }
        }
        task.resume()
    }
}
