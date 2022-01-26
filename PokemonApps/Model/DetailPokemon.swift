//
//  DetailPokemon.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import Foundation

struct DetailPokemon:Decodable{
    let weight: Int
    let base_experience: Int
    let abilities: [Abilities]
}

struct Abilities:Decodable{
    let ability: Ability
}

struct Ability:Decodable {
    let name: String
    let url: String
}


