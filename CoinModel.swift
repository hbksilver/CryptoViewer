//
//  CoinModel.swift
//  CryptoViewer
//
//  Created by hassan Baraka on 4/27/21.
//

import Foundation
struct CryptoDataContainer: Decodable {
    let status: String
    let data: CryptoData
}
struct CryptoData: Decodable {
    let coins: [Coin]
}
struct Coin: Decodable, Hashable {
    let name: String
    let price: String
}
