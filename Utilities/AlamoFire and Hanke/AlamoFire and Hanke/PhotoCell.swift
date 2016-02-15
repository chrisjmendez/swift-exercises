//
//  PhotoCell.swift
//  AlamoFire and Hanke
//
//  Created by Chris on 2/14/16.
//  Copyright © 2016 Chris Mendez. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var url:String?{
        didSet{
            print(url)
        }
    }
    
}
