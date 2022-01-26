//
//  MyPockemonViewController.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import UIKit
import Toaster

class MyPockemonViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let db = DBHelper()
    var itemList = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList = db.read()
        preparetableView()
        Toast(text: "Swipe Left To Delete MyPokemon").show()
    }
    
    func preparetableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MyPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "myPokemon")
    }

}

extension MyPockemonViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPokemon", for: indexPath) as! MyPokemonTableViewCell
        cell.lblName.text = "Pokemon Name : \(itemList[indexPath.row].name)"
        cell.lblNickname.text = "Pokemon Nickname : \(itemList[indexPath.row].nickname)"
        return cell
    }
    
}

extension MyPockemonViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Write action code for the trash
               let TrashAction = UIContextualAction(style: .normal, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                   
                   //delete data id
                   let listId = self.itemList[indexPath.row].id
                   self.db.delete(id: listId)
                   self.itemList = self.db.read()
                   tableView.reloadData()
                   success(true)
               })
               TrashAction.backgroundColor = .red


               return UISwipeActionsConfiguration(actions: [TrashAction])
    }
}
