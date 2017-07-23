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
    var victim: Planet?
    var myAttacker: Planet?
    var tag: Int
    
    init(name: String, tag: Int)
    {
        self.name = name
        self.tag = tag
        score = 0
        isTurn = false
    }
    
    func fortify(tag: Int, player: Player, planet: Planet, numTroops: inout Int)
    {
        if(numTroops > 0 && (planet.owner == nil || planet.owner!.name == self.name)) {
            score += (planet.owner == nil ? 1:0)
            planet.owner = self
            changePic(planet: planet, player: tag)
            planet.addTroops(value: 1)
            numTroops -= 1
        }
    }
    
    func attack(attacker: Planet, defender: Planet, whatToDo: inout Int)
    {
        if((attacker.owner == nil  && whatToDo == 0) || (defender.owner == nil && whatToDo == 1)) {
            return
        }
        if(whatToDo == 0 && attacker.owner?.name == self.name) {
            myAttacker = attacker
            whatToDo = (whatToDo + 1) % 2
        }
        else if (whatToDo == 1 && defender.owner?.name != self.name) {
            victim = defender
            makeAttack()
            whatToDo = (whatToDo + 1) % 2
        }
    }
    
    func makeAttack() {
        if((myAttacker?.getTroops())! > (victim?.getTroops())!) {
            let attackerDice = arc4random_uniform(5) + arc4random_uniform(5) + 2
            let defenderDice = arc4random_uniform(5) + 1
            if(attackerDice > defenderDice) {
                self.score += 1
                victim?.owner?.score -= 1
                victim?.removeTroops(value: (victim?.getTroops())!)
                victim?.addTroops(value: ((myAttacker?.troops)! / 2))
                myAttacker?.removeTroops(value: (myAttacker?.troops)! / 2)
                victim?.owner = self
                changePic(planet: victim!, player: self.tag)
                
            }
            else if(defenderDice > attackerDice) {
                score -= 1
                victim?.owner?.score += 1
                myAttacker?.removeTroops(value: (myAttacker?.getTroops())!)
                myAttacker?.addTroops(value: ((victim?.troops)! / 2))
                victim?.removeTroops(value: (victim?.troops)! / 2)
                myAttacker?.owner = victim?.owner
                changePic(planet: myAttacker!, player: (victim?.owner?.tag)!)
                
            }
            
        }
        else {
            let attackerDice = arc4random_uniform(5) + 1
            let defenderDice = arc4random_uniform(5) + arc4random_uniform(5) + 2
            if(attackerDice > defenderDice) {
                self.score += 1
                victim?.owner?.score -= 1
                victim?.removeTroops(value: (victim?.getTroops())!)
                victim?.addTroops(value: ((myAttacker?.troops)! / 2))
                myAttacker?.removeTroops(value: (myAttacker?.troops)! / 2)
                victim?.owner = self
                changePic(planet: victim!, player: self.tag)
            }
            else if(defenderDice > attackerDice) {
                self.score -= 1
                victim?.owner?.score += 1
                myAttacker?.removeTroops(value: (myAttacker?.getTroops())!)
                myAttacker?.addTroops(value: ((victim?.troops)! / 2))
                victim?.removeTroops(value: (victim?.troops)! / 2)
                myAttacker?.owner = victim?.owner
                changePic(planet: myAttacker!, player: (victim?.owner?.tag)!)
                
            }
            
        }
    }
    
    func reinforce(planet: Planet, numTroops: inout Int, addBool: Bool)
    {
        if(numTroops > 0 && addBool) {
            if(planet.getTroops() == 0) {
                planet.owner = self
                changePic(planet: planet, player: self.tag)
            }
            planet.addTroops(value: 1)
            numTroops -= 1
            
        }
        else if (planet.owner?.name == self.name && !addBool && planet.troops > 0) {
            planet.removeTroops(value: 1)
            numTroops += 1
            score -= (planet.getTroops() == 0 ? 1:0)
        }
    }
    
    func changePic(planet: Planet, player: Int){
        
        let tag = planet.planetButton.tag
        
        // Changing the planet image for player 1 (Blue)
        if player == 0 {
            
            if tag == 0 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P1blue"), for: .normal)
            }
            else if tag == 1 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P2blue"), for: .normal)
            }
            else if tag == 2 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P3blue"), for: .normal)
            }
            else if tag == 3 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P4blue"), for: .normal)
            }
            else if tag == 4 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P5blue"), for: .normal)
            }
            else if tag == 5 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P6blue"), for: .normal)
            }
            else if tag == 6 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P7blue"), for: .normal)
            }
            else if tag == 7 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P8blue"), for: .normal)
            }
            else if tag == 8 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P9blue"), for: .normal)
            }
            else if tag == 9 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P10blue"), for: .normal)
            }
            
        }
        // Changing the planet image for player 2 (red)
        else if player == 1 {
            
            if tag == 0 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P1red"), for: .normal)
            }
            else if tag == 1 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P2red"), for: .normal)
            }
            else if tag == 2 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P3red"), for: .normal)
            }
            else if tag == 3 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P4red"), for: .normal)
            }
            else if tag == 4 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P5red"), for: .normal)
            }
            else if tag == 5 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P6red"), for: .normal)
            }
            else if tag == 6 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P7red"), for: .normal)
            }
            else if tag == 7 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P8red"), for: .normal)
            }
            else if tag == 8 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P9red"), for: .normal)
            }
            else if tag == 9 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P10red"), for: .normal)
            }
            
        }
        // Changing the planet image for player 3 (green)
        else if player == 2 {
        
            if tag == 0 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P1green"), for: .normal)
            }
            else if tag == 1 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P2green"), for: .normal)
            }
            else if tag == 2 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P3green"), for: .normal)
            }
            else if tag == 3 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P4green"), for: .normal)
            }
            else if tag == 4 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P5green"), for: .normal)
            }
            else if tag == 5 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P6green"), for: .normal)
            }
            else if tag == 6 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P7green"), for: .normal)
            }
            else if tag == 7 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P8green"), for: .normal)
            }
            else if tag == 8 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P9green"), for: .normal)
            }
            else if tag == 9 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P10green"), for: .normal)
            }
            
        }
        // Changing the planet image for player 4 (orange)
        else if player == 3 {
            
            if tag == 0 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P1orange"), for: .normal)
            }
            else if tag == 1 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P2orange"), for: .normal)
            }
            else if tag == 2 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P3orange"), for: .normal)
            }
            else if tag == 3 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P4orange"), for: .normal)
            }
            else if tag == 4 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P5orange"), for: .normal)
            }
            else if tag == 5 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P6orange"), for: .normal)
            }
            else if tag == 6 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P7orange"), for: .normal)
            }
            else if tag == 7 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P8orange"), for: .normal)
            }
            else if tag == 8 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P9orange"), for: .normal)
            }
            else if tag == 9 {
                planet.planetButton.setBackgroundImage(UIImage(named: "P10orange"), for: .normal)
            }

        }

    }
    

}
