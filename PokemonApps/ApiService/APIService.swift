//
//  ApiService.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 25/01/22.
//

import Foundation
import Alamofire

class APIService : NSObject {
    
    private let sourcesURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //func get Data API
    func apiGetDataPokemon(completion: @escaping (Pokemon) -> ()){
        AF.request(sourcesURL).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(Pokemon.self, from: data)
                        completion(decodedData)
                    }catch {
                        print("error Decoder")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //func get Data DetailPokemon
    func apiGetDetailPokemon(data:String, completion: @escaping (DetailPokemon) -> ()) {
        
        AF.request(data).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(DetailPokemon.self, from: data)
                        print("decodedData \(decodedData.weight)")
                        completion(decodedData)
                    }catch {
                        print("error Decoder")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
}
