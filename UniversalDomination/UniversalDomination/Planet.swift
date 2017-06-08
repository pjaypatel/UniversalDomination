//
//  Planet.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/7/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import SpriteKit

class Planet: SKSpriteNode
{
    // how many troops on the planet
    var troops: Int = 0
    
    
    
    init(im: String, xy: CGPoint, s: CGSize)
    {
        // call the superclass init()
        super.init(texture: nil, color: UIColor.brown, size: CGSize.init(width: 4, height: 4))
        
        // set the icon for the planet
        let icon = SKSpriteNode(imageNamed: im)
        icon.scale(to: s)
        icon.position = xy
        addChild(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
