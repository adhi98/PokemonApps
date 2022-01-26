//
//  MyPokemonTableViewCell.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import UIKit

class MyPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
