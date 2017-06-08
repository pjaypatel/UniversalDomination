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
        
        // try creating a planet
        planets.append(Planet(im: "P1", xy: CGPoint.init(x: 200, y: 200), s: CGSize.init(width: 80, height: 80)))
        planets.append(Planet(im: "P2", xy: CGPoint.init(x: 200, y: 250), s: CGSize.init(width: 70, height: 70)))
        planets.append(Planet(im:"P3", xy: CGPoint.init(x: 200, y: 250), s: CGSize.init(width:70, height:70)))
        

        for i in planets {
            addChild(i)
        }
        
        
    }

    
}


