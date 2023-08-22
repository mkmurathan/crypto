//
//  WebService.swift
//  Cripto
//
//  Created by Murathan karagöz on 22.08.2023.
//

import Foundation



class Webservice {
    
    enum CryptoError : Error {
        case serverError
        case parsingError
    }
    
    
    
    func downloadCurrencies(url : URL, completion : @escaping (Result<[crypto],CryptoError>) -> ()   )   {
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.serverError))
                
            }else if let data = data {
            
                let cryptoList = try? JSONDecoder().decode([crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                    
                } else {
                
                    completion(.failure(.parsingError))
                }
                
            }
            
        }.resume()
    }
    
    
    
    
}




