//
//  CryptoTableViewCell.swift
//  Cripto
//
//  Created by Murathan karagöz on 22.08.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    public var item: crypto! {
        
        didSet {
            self.nameLabel.text = item.currency
            self.price.text = item.price
        }
        
    }
    
    
    
    
    
}
