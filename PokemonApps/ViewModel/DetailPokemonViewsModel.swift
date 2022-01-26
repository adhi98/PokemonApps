//
//  DetailPokemonViewsModel.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import Foundation

class DetailPokemonViewsModel: NSObject {
    
    private var apiService : APIService!
    
    //binding Data
    private(set) var pokemonDetail: DetailPokemon!{
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
    }
    
    func callFuncToGetDetailPokemon(param: String) {
        self.apiService.apiGetDetailPokemon(data: param) { (pokemonDetail) in
            self.pokemonDetail = pokemonDetail
        }
    }
    
}
