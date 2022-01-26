//
//  Pokemon.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 25/01/22.
//

import Foundation

struct Pokemon: Decodable {
    let count: Int
    let next: String
    let results : [Results]
}

struct Results: Decodable {
    let name: String
    let url: String
}
