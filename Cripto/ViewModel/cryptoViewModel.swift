//
//  cryptoViewModel.swift
//  Cripto
//
//  Created by Murathan karagöz on 22.08.2023.
//

import Foundation
import RxSwift
import RxCocoa


class CryptoViewModel {
    
    let cryptos : PublishSubject<[crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    
    
    func RequestData() {
        
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            
            
            
            switch result {
           
            case.success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case.failure(let error):
                switch error {
                    
                case .parsingError:
                    self.error.onNext("parsing error")
                    
                case.serverError:
                    self.error.onNext("server error")
                    
                }
            }
            
        }
        
        
    }
    
    
}


