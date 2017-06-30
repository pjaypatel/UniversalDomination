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
    
}
