//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Avaneesh Pathak on 17/12/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let last: Float
    
    var lastString: String {
        return String(format: "%.2f", last)
    }
    
}
