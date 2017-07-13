//
//  Player.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/29/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import UIKit

class Player
{
    var name: String
    var score: Int
    var isTurn: Bool
    var image: UIImage
    
    
    init(name: String)
    {
        self.name = name
        score = 0
        isTurn = false
        image = UIImage(named: "alien1")! //just initializing with some image
 
    }

}
