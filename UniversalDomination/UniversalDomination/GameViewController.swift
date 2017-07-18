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
    var numTroops = 0
    @IBOutlet var PlanetButtons: [UIButton]!
    @IBOutlet weak var Dice: UIImageView!
    @IBOutlet weak var troopCountLabel: UILabel!
    


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
            planets.append(Planet(bttn: PlanetButtons[index-1]))
        }
        
        if seconds == 0 {
            timerIsOn = false
        }
        
    }
    
    
    @IBAction func buttonClicked(_ sender: Any)
    {
        let button = sender as AnyObject
        if (numTroops > 0) {
            planets[button.tag].addTroops(value: 1)
            button.setTitle(String(planets[button.tag].getTroops()), for: UIControlState.normal)
            numTroops -= 1
            troopCountLabel.text = String(numTroops)
        }
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
    

    @IBOutlet weak internal var countDownTimer: UILabel!
    
    var seconds = 20
    var timer = Timer()
    var timerIsOn = false
    

    @IBAction func fortifyTime(_ sender: UIButton) {
        // start timer once the fortify button is clicked on.
        if timerIsOn == false {
            seconds = 20
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    @IBAction func attackTime(_ sender: UIButton) {
        if timerIsOn == true {
            timer.invalidate()
        }
        // restart time
            seconds = 20
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }
   
    @IBAction func reinforceTime(_ sender: UIButton) {
        if timerIsOn == true {
            timer.invalidate()
        }
        
        // restart time
        seconds = 20
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }
 
    
   // @IBAction func endButton(_ sender: Any) {
        //timer.invalidate()
        //seconds = 0
       // countDownTimer.text = "\(seconds)"
       // timerIsOn = false
  //  }

    func updateTimer() {
        seconds -= 1
        countDownTimer.text = "\(seconds)"
        
        if seconds == 0 {
                timer.invalidate()
                timerIsOn = false
        }
    }

    @IBAction func DiceRoll(_ sender: UIButton) {
        let Number = arc4random_uniform(5) + 1
        Dice.image = UIImage(named: "Dice\(Number)")
        troopCountLabel.text = String(Number)
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when){
            let Number2 = arc4random_uniform(5) + 1
            self.Dice.image = UIImage(named: "Dice\(Number2)")
            let totalTroops = Number + Number2
            self.numTroops = Int(totalTroops)
            self.troopCountLabel.text = String(totalTroops)
        }
    }
    
}
