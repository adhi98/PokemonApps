//
//  DetailViewController.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import UIKit
import Kingfisher
import Toaster

class DetailViewController: UIViewController {
        
    @IBOutlet weak var titlePokemon: UILabel!
    @IBOutlet weak var titleWeight: UILabel!
    @IBOutlet weak var titleBaseExperience: UILabel!
    @IBOutlet weak var tableViewAbilities: UITableView!
    @IBOutlet weak var IMPokemon: UIImageView!
    
    
    private var detailPokemonViewModel:DetailPokemonViewsModel!
    var dataAbilities = [Abilities]()
    
    let db = DBHelper()
    
    var nameData:String?
    var urlData:String?
    var imgData:String?
    
    var catchPokemon = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPrepare()
        callToViewModelForUIUpdate()
        getDataImage()
    }
    
    func getDataImage(){
        IMPokemon.kf.indicatorType = .activity
        IMPokemon.kf.setImage(with: URL(string: imgData!), placeholder: nil, options: nil)
        
    }
    
    func tableViewPrepare(){
        tableViewAbilities.dataSource = self

    }
    
    func callToViewModelForUIUpdate(){
        self.detailPokemonViewModel = DetailPokemonViewsModel()
        detailPokemonViewModel.callFuncToGetDetailPokemon(param: urlData!)
        self.detailPokemonViewModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        let dataTable = self.detailPokemonViewModel.pokemonDetail.abilities
        
        dataAbilities = dataTable
        DispatchQueue.main.async {
            self.tableViewAbilities.reloadData()
            self.titleWeight.text = "Weight \(String(self.detailPokemonViewModel.pokemonDetail.weight))"
            self.titleBaseExperience.text = "Experience \(String(self.detailPokemonViewModel.pokemonDetail.base_experience))"
            self.titlePokemon.text = "Pokemon Name : \(self.nameData!)"
        }
    }
    
    
    @IBAction func CatchPokemonAction(_ sender: UIBarButtonItem) {
        let randomInt = Int.random(in: 0..<100)
        
        
        //if status false go head else button has been pressed
        // if the number is even == catch pokemon and give the name
        //else the number is odd pokemon failed to catch
        
        if(catchPokemon == false){
            if(randomInt % 2 == 0){
                presentAlertController()
            }else {
                Toast(text: "Failed TO Catch Pokemon").show()
            }
            catchPokemon = true
        }else {
            Toast(text: "Sorry You Have To Try Again in Menu").show()
        }
        
        
    }
    
    func presentAlertController(){
        let alertController = UIAlertController(title: "Pokemon NickName", message: nil, preferredStyle: .alert)
        
        //UITextField
        alertController.addTextField { textField in
            textField.placeholder = "Add Item"
        }
        
        //button save and cancel
        let saveBtn = UIAlertAction(title: "Save", style: .default) { UIAlertAction in
            guard let textFields = alertController.textFields else {
                return
            }
            if textFields[0].text != ""{
                
                if let text = textFields[0].text{
                    
                    self.db.insert(name: self.nameData!, nickname: text)
                }
//                self.itemList = self.db.read()
//                self.tabelViewItem.reloadData()
                Toast(text: "successfully insert data").show()
            }else {
                
                Toast(text: "Item is empty").show()
            }
        }
        alertController.addAction(saveBtn)
        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive) { UIAlertAction in
            
        }
        alertController.addAction(cancelBtn)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAbilities.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "abilitiesCell", for: indexPath)
        cell.textLabel?.text = dataAbilities[indexPath.row].ability.name
        return cell
    }

}
