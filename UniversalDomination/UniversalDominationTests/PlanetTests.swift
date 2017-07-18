//
//  PlanetTests.swift
//  UniversalDomination
//
//  Created by Sandy Demian on 6/30/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import XCTest
@testable import UniversalDomination

class PlanetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTroopsInit() {
        let button = UIButton()
        let planet = Planet(bttn: button)
        
        XCTAssertTrue(planet.troops == 0)
    }
    
    func testOwnerInit() {
        let button = UIButton()
        let planet = Planet(bttn: button)
        
        XCTAssertTrue(planet.owner == nil)
    }

    func testButtonInit() {
        let button = UIButton()
        let planet = Planet(bttn: button)
        
        XCTAssertTrue(planet.planetButton == button)
    }
    
    func testAddTroops() {
        let button = UIButton()
        let planet = Planet(bttn: button)
        
        planet.addTroops(value: 1)
        XCTAssertTrue(planet.troops == 1)
        
        planet.addTroops(value: 3)
        XCTAssertTrue(planet.troops == 4)
        
        planet.addTroops(value: 0)
        XCTAssertTrue(planet.troops == 4)
    }
    
    func testRemoveTroops() {
        let button = UIButton()
        let planet = Planet(bttn: button)
        planet.troops = 8
        
        planet.removeTroops(value: 1)
        XCTAssertTrue(planet.troops == 7)
        
        planet.removeTroops(value: 3)
        XCTAssertTrue(planet.troops == 4)
        
        planet.removeTroops(value: 0)
        XCTAssertTrue(planet.troops == 4)
    }

    
}
