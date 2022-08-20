//
//  WebService.swift
//  CryptoCroSUI
//
//  Created by İhsan Elkatmış on 13.08.2022.
//

import Foundation

class Webservice {
    /*
    func downloadCurrencyAsync(url:URL) async throws -> [CryptoCurrency] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
    }
     */
    
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {
        
        try await withCheckedThrowingContinuation({ continuation in
            downloadCurrencies(url: url) { result in
                switch result {
                case.success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case.failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        
    }
    
    func downloadCurrencies(url : URL, complation : @escaping  (Result<[CryptoCurrency]?,DownloaderError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                complation(.failure(.badurl))
            }
            
            guard let data = data, error == nil else {
                return complation(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return complation(.failure(.dataParseError))
        }
            complation(.success(currencies))
    }.resume()
    }


enum DownloaderError : Error {
        case badurl
        case noData
        case dataParseError
}
}
