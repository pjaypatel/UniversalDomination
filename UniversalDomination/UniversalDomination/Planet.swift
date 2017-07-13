//
//  Planet.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/7/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import Foundation
import SpriteKit

class Planet
{
    var troops: Int = 0
    var owner: Player?
    var planetButton: UIButton
    
    
    init(bttn: UIButton)
    {
        troops = 0
        planetButton = bttn
        planetButton.setTitle(String(troops), for: UIControlState.normal)
    }
    
    
    public func addTroops(value: Int)
    {
        troops += value
        planetButton.setTitle(String(troops), for: UIControlState.normal)
    }
    
    public func removeTroops(value: Int)
    {
        troops -= value
        planetButton.setTitle(String(troops), for: UIControlState.normal)
    }
    
    public func getTroops() -> Int
    {
        return troops
    }
    
    
}
