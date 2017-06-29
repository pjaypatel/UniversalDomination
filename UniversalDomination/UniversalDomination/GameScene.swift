//
//  GameScene.swift
//  UniversalDomination
//
//  Created by Pranay Jay Patel on 6/1/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    // get the background image
    let background = SKSpriteNode(imageNamed: "space1")
    
    // an empty array of planets
    var planets = [Planet]()
    
    override func didMove(to view: SKView)
    {
        
        // setting up the background image
        background.scale(to: CGSize.init(width: frame.size.width, height: frame.size.height))
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
        
        
    }

    
}


