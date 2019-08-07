//
//  BitcoinAppController.swift
//  App
//
//  Created by Conal O'Neill on 31/07/2019.
//

import Foundation
import Vapor


final class BitcoinAppController {
    
    struct BitcoinPrice: Content {
        var price: String
    }
    
    func bitcoinPrice(_ req: Request) throws -> Future<BitcoinPrice> {
        
        let client = try req.make(Client.self)
        let response = client.get("https://blockchain.info/tobtc?currency=EUR&value=1")
        let bitcoinPrice = response.flatMap(to: BitcoinPrice.self) { response in
            let price  = response.http.body.consumeData(on: req).map(to: BitcoinPrice.self) { bitcoinData in
                let string = String(data: bitcoinData, encoding: String.Encoding.utf8)
                return BitcoinPrice(price: string ?? "Error")
            }
            return price
        }
        return bitcoinPrice
    }
}
