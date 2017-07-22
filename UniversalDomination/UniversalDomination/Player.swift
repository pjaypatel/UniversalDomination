//
//  Player.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/29/17.
//  Copyright © 2017 Group1. All rights reserved.
//
import Foundation

class Player
{
    var name: String
    var score: Int
    var isTurn: Bool
    var victim: Planet?
    var myAttacker: Planet?
    
    init(name: String)
    {
        self.name = name
        score = 0
        isTurn = false
    }
    
    func fortify(player: Player, planet: Planet, numTroops: inout Int)
    {
        if(numTroops > 0 && (planet.owner == nil || planet.owner!.name == self.name)) {
            score += (planet.owner == nil ? 1:0)
            planet.owner = self
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
                
            }
            else if(defenderDice > attackerDice) {
                score -= 1
                victim?.owner?.score += 1
                myAttacker?.removeTroops(value: (myAttacker?.getTroops())!)
                myAttacker?.addTroops(value: ((victim?.troops)! / 2))
                victim?.removeTroops(value: (victim?.troops)! / 2)
                myAttacker?.owner = victim?.owner
                
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
                
            }
            else if(defenderDice > attackerDice) {
                self.score -= 1
                victim?.owner?.score += 1
                myAttacker?.removeTroops(value: (myAttacker?.getTroops())!)
                myAttacker?.addTroops(value: ((victim?.troops)! / 2))
                victim?.removeTroops(value: (victim?.troops)! / 2)
                myAttacker?.owner = victim?.owner
                
            }
            
        }
    }
    
    func reinforce(planet: Planet, numTroops: inout Int, addBool: Bool)
    {
        if(numTroops > 0 && addBool) {
            if(planet.getTroops() == 0) {
                planet.owner = self
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

}
