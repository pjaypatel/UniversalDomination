//
//  PlayerTests.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/30/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import XCTest
@testable import UniversalDomination

class PlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNameInit() {
        let player = Player(name: "Sandy")
        
        XCTAssertTrue(player.name == "Sandy")
    }
    
    func testScoreInit() {
        let player = Player(name: "Sandy")
        
        XCTAssertTrue(player.score == 0)
    }
    
    func testIsTurnInit() {
        let player = Player(name: "Sandy")
        
        XCTAssertFalse(player.isTurn)
    }
    
    func testAttackWithPlanetsWithSameOwner() {
        let attacker = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50)))
        let defender = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50)))
        let samplePlayer = Player(name: "Jay")
        attacker.owner = samplePlayer
        attacker.addTroops(value: 10)
        defender.owner = Player(name: "Jay")
        defender.addTroops(value: 5)
        var attackFunction = 0
        attacker.owner?.attack(attacker: attacker, defender: defender, whatToDo: &attackFunction)
        attackFunction = 1
        attacker.owner?.attack(attacker: attacker, defender: defender, whatToDo: &attackFunction)
        XCTAssertTrue(attacker.owner?.score == 0)
    }
    
    func testAttack() {
        let attacker = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))) // sample button creation
        let defender = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50)))
        let samplePlayer = Player(name: "Jay")
        attacker.owner = samplePlayer
        attacker.addTroops(value: 10)
        defender.owner = Player(name: "RandomPlayer")
        defender.addTroops(value: 5)
        var attackFunction = 0
        attacker.owner?.attack(attacker: attacker, defender: defender, whatToDo: &attackFunction)
        attackFunction = 1
        attacker.owner?.attack(attacker: attacker, defender: defender, whatToDo: &attackFunction) //tried 1 time

        if(attacker.owner?.score != 1) { // if failed first time, second time should definitely work
            attacker.owner?.attack(attacker: attacker, defender: defender, whatToDo: &attackFunction)
        }
        XCTAssertTrue(attacker.owner?.score == 1)
    }
    
    func testFortify() {
        let randomPlanet = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))) // sample button creation
        let randomPlayer = Player(name: "Jay")
        var numberOfTroopsAvailableToAdd = 1
        randomPlayer.fortify(player: randomPlayer, planet: randomPlanet, numTroops: &numberOfTroopsAvailableToAdd)
        
        XCTAssertTrue(randomPlanet.getTroops() == 1 && numberOfTroopsAvailableToAdd == 0 && randomPlanet.owner?.name == randomPlayer.name)
    }
    
    func testReinforceAdd() {
        let randomPlanet = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))) // sample button creation
        let randomPlayer = Player(name: "Jay")
        var numberOfTroopsAvailableToAdd = 1
        let isAddingTroops = true
        randomPlayer.reinforce(planet: randomPlanet, numTroops: &numberOfTroopsAvailableToAdd, addBool: isAddingTroops)
        XCTAssertTrue(randomPlanet.getTroops() == 1)
    }
    
    func testReinforceRemove() {
        let randomPlanet = Planet(bttn: UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))) // sample button creation
        randomPlanet.addTroops(value: 1)
        let randomPlayer = Player(name: "Jay")
        randomPlanet.owner = randomPlayer
        var numberOfTroopsAvailableToAdd = 0
        let isAddingTroops = false
        randomPlayer.reinforce(planet: randomPlanet, numTroops: &numberOfTroopsAvailableToAdd, addBool: isAddingTroops)
        XCTAssertTrue(randomPlanet.getTroops() == 0)
    }
}
