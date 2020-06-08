//
//  MemeStruct.swift
//  AR try 0.1
//
//  Created by denys pashkov on 17/11/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//

import UIKit

struct Meme : Codable {

    var imageName : String /// name of the meme image
    var description : String /// description of meme
    var name : String /// name of meme
    var hint: String /// hint on where to find the meme
    var found: Bool = false /// boolean weather it was found or not
}

