//
//  ViewController.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 25/01/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var pokemonViewsModel: PokemonViewsModel!
    var dataPokemon = [Results]()
    
    let db = DBHelper()
    
    var dataSelected = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPrepare()
        callToViewModelForUIUpdate()
    }
    
    
    func tableViewPrepare(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokeCell")
    }
    
    func callToViewModelForUIUpdate(){
        self.pokemonViewsModel = PokemonViewsModel()
        pokemonViewsModel.callFuncToGetPokemonData()
        self.pokemonViewsModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        let dataTable = self.pokemonViewsModel.pokemonData.results
        dataPokemon = dataTable
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let numImages = indexPath.row + 1
        let urlImages = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as! PokemonTableViewCell
        cell.lblName.text = dataPokemon[indexPath.row].name
        cell.IMPokemon.kf.indicatorType = .activity
        cell.IMPokemon.kf.setImage(with: URL(string: "\(urlImages)\(numImages).png"), placeholder: nil, options: nil)
        
        return cell
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row + 1
        dataSelected = selectedRow
        performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailSegue"){
            let destinationDetailPokemon = segue.destination as! DetailViewController
            let name = dataPokemon[tableView.indexPathForSelectedRow!.row].name
            let url = dataPokemon[tableView.indexPathForSelectedRow!.row].url
            let urlImages = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(dataSelected).png"
            
            destinationDetailPokemon.nameData = name
            destinationDetailPokemon.urlData = url
            destinationDetailPokemon.imgData = urlImages
        }else {
            
        }
        
        
        

    }
    
    
}

