//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
        
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // 1. create a URL
        if let url = URL(string: urlString) {  //to check if url is not empty
            
            // 2. create a URLSession
            let session = URLSession(configuration: .default) //performs the networking
            
            // 3. give session a task
            let task = session.dataTask(with: url) { (data, response, error) in //closure
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    

}
