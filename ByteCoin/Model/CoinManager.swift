//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
        
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
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, coin: coin)
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
//            let id = decodedData.weather[0].id
//            let name = decodedData.name
//            let temp = decodedData.main.temp
            let last = decodedData.last
            
            let coin = CoinModel(last: last)
//            print(weather.getConditionName(weatherID: id))
            print(coin.last)
            return coin
        } catch {
            print(error)
            return nil
        }
        
    }

}
