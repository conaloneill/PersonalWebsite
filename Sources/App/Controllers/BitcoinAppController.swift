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
    
    func bitcoinPrice(_ req: Request) throws -> EventLoopFuture<BitcoinPrice> {

        req.client.get("https://blockchain.info/tobtc?currency=EUR&value=1").flatMapThrowing { res in
            if let price = res.body?.getString(at: res.body!.readerIndex, length: res.body!.readableBytes, encoding: String.Encoding.utf8) {
                let bitcoinPrice = BitcoinPrice(price: price)
                return bitcoinPrice
            }
            return BitcoinPrice(price: "Error!")
        }
    }
    
    func bitcoinCurrencies(_ req: Request) throws -> EventLoopFuture<Currencies> {
        
        req.client.get("https://blockchain.info/ticker").flatMapThrowing { res in
            let currencies = try res.content.decode([String: BitcoinConvertedDetail].self)
            return currencies
        }
    }
    
    
    typealias Currencies = [String: BitcoinConvertedDetail]
    
    struct BitcoinConvertedDetail: Content {
        let the15M, last, buy, sell: Double
        let symbol: String
        
        enum CodingKeys: String, CodingKey {
            case the15M = "15m"
            case last, buy, sell, symbol
        }
    }
}
