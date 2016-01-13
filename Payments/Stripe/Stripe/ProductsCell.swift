//
//  ProductsCell.swift
//  Stripe
//
//  Created by Tommy Trojan on 1/13/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class ProductsCell: UITableViewCell {

    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBAction func onBuy(sender: AnyObject) {
        let item = foodType.text!
        
        NSNotificationCenter.defaultCenter().postNotificationName("goToView", object: nil, userInfo: ["item": item])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
