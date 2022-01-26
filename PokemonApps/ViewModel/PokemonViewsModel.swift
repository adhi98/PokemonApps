//
//  PokemonViewsModel.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 25/01/22.
//

import Foundation

class PokemonViewsModel : NSObject {
    
    private var apiService : APIService!
    
    //binding Data
    private(set) var pokemonData: Pokemon!{
        didSet{
            self.bindNewsViewModelToController()
        }
    }
    
    //property viewmodel to call in Controller
    var bindNewsViewModelToController : (() -> ()) = {
        
    }
    
    
    override init() {
        super.init()
        self.apiService = APIService()
//        callFuncToGetNewsData()
    }
    
    func callFuncToGetPokemonData() {
        self.apiService.apiGetDataPokemon { (pokemonData) in
            self.pokemonData = pokemonData
        }
    }
    
    
    
    
}
