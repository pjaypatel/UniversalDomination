//
//  GameViewController.swift
//  UniversalDomination
//
//  Created by Pranay Jay Patel on 6/1/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

 class GameViewController: UIViewController
 {
    let numberOfPlanets = 10
    var planets = [Planet]()
    @IBOutlet var PlanetsButtons: [UIButton]!

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        
        // configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        
        for index in 1...numberOfPlanets
        {
            // add the planets and the button outlets
            planets.append(Planet(bttn: PlanetsButtons[index-1]))
        }


    }

    
    @IBAction func planetClicked(_ sender: Any)
    {
        guard let button = sender as? UIButton else
        {
            return
        }
        
        planets[button.tag].addTroops(value: 1)
        button.setTitle(String(planets[button.tag].getTroops()), for: UIControlState.normal)
    }
    
    
    override var shouldAutorotate: Bool
    {
        return true
    }

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscapeLeft
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
