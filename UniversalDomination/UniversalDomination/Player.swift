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
            planet.owner = player
            planet.addTroops(value: 1)
            numTroops -= 1
        }
    }
    
    func attack(attacker: Planet, defender: Planet, whatToDo: inout Int)
    {
        if(whatToDo == 0) {
            myAttacker = attacker
        }
        else if (whatToDo == 1) {
            victim = defender
        }
        else if(whatToDo == 2) {
            makeAttack()
        }
    }
    
    func makeAttack() {
        if((myAttacker?.troops)! > (victim?.troops)!) {
            let attackerDice = arc4random_uniform(5) + arc4random_uniform(5) + 2
            let defenderDice = arc4random_uniform(5) + 1
            if(attackerDice > defenderDice) {
                victim?.removeTroops(value: (victim?.getTroops())!)
                victim?.addTroops(value: ((myAttacker?.troops)! / 2))
                myAttacker?.troops -= ((myAttacker?.troops)! / 2)
            }
            else if(defenderDice > attackerDice) {
                myAttacker?.removeTroops(value: (myAttacker?.getTroops())!)
                myAttacker?.addTroops(value: ((victim?.troops)! / 2))
                victim?.troops -= ((victim?.troops)! / 2)
            }
        }
    }
    
    func reinforce(planet: Planet, numTroops: inout Int, addBool: Bool)
    {
        if(numTroops > 0 && addBool) {
            planet.addTroops(value: 1)
            numTroops -= 1
        }
        else if (!addBool) {
            planet.removeTroops(value: 1)
            numTroops += 1
        }
    }

}
