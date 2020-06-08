//
//  CollectionViewCell.swift
//  AR try 0.1
//
//  Created by denys pashkov on 20/11/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit

class MemeCell: UICollectionViewCell {
    
    @IBOutlet weak var memeFrame: UIImageView!
    var memeAllocated : Meme? = nil
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeName: UILabel!
    @IBOutlet weak var memeHint: UILabel!
    @IBOutlet weak var staticHintText: UILabel!
    
}
