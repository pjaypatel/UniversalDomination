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

class GameViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        // configure the view
        let skView = view as! SKView
        

        skView.isMultipleTouchEnabled = false
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        
        // create and configure the scene
        scene.scaleMode = .aspectFill
        
        
        // present the scene
        skView.presentScene(scene)
 


    }
    

    override var shouldAutorotate: Bool {
        return true
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscapeLeft
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func DiceRoll(_ sender: UIButton) {
        
        
    }
    
}
