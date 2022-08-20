//
//  CryptoCurrency.swift
//  CryptoCroSUI
//
//  Created by İhsan Elkatmış on 13.08.2022.
//

import Foundation

struct CryptoCurrency : Hashable, Decodable, Identifiable {
    
    let id = UUID()
    let currency : String
    let price : String
    
    private enum CodingKeys : String, CodingKey {
        
        case currency = "currency"
        case price = "price"
    }
    
}
