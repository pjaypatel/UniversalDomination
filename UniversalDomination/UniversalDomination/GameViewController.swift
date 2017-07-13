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
    var player = [Player]()
    var index = 0
    
    @IBOutlet var PlanetButtons: [UIButton]!
    @IBOutlet weak var Dice: UIImageView!
    @IBOutlet weak var troopCountLabel: UILabel!
    

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerScore: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        
        if (player.count > 0) {
            playerImage.image = player[0].image
            playerName.text = player[0].name
            playerScore.text = String(player[0].score)
        }
        
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
        
        
    }
    
    @IBAction func playerChangeButton(_ sender: Any) {
        if (index == player.count-1) {
                index = -1
        }
        playerImage.image = player[index+1].image
        playerName.text = player[index+1].name
        playerScore.text = String(player[index+1].score)
        index = index + 1

//        for index in 0...player.count-1{
//            var num = index
//            if (player[num].image.isEqual(playerImage.image)){
////            if (player[num].image == playerImage.image){
//                if (num == player.count-1) {
//                    num = -1
//                }
//                playerImage.image = player[num+1].image
//                playerName.text = player[num+1].name
//                playerScore.text = String(player[num+1].score)
//            }
//        }
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
    
    var seconds = 60
    var timer = Timer()
    var timerIsOn = false
    
    @IBAction func startButton(_ sender: Any) {
        if timerIsOn == false {
            seconds = 60
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn = true
        }
        
    }
   
    @IBAction func endButton(_ sender: Any) {
        timer.invalidate()
        seconds = 0
        countDownTimer.text = "\(seconds)"
        timerIsOn = false
    }

    func updateTimer() {
        seconds -= 1
        countDownTimer.text = "\(seconds)"
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
