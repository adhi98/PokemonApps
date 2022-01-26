//
//  PokemonTableViewCell.swift
//  PokemonApps
//
//  Created by Muhammad Adhi on 26/01/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var IMPokemon: UIImageView!
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
