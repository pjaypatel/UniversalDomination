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
    var players = [Player]()
    var playerNames: [String] = ["name", "name", "name", "name"]
    var numTroops = 0
    var addBool = true
    @IBOutlet var PlanetButtons: [UIButton]!
    @IBOutlet weak var Dice: UIImageView!
    @IBOutlet weak var troopCountLabel: UILabel!
    
    @IBOutlet weak var Dice2: UIImageView!
    
   
    
    @IBAction func Attack_Clicked(_ sender: UIButton) {
        Dice.isHidden = false
        Dice2.isHidden = false
        
        
        
    }
    @IBAction func EndAction(_ sender: UIButton) {
        Dice.isHidden = true
        Dice2.isHidden = true
    }
    

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
        
        // add the planets
        for index in 1...numberOfPlanets
        {
            planets.append(Planet(bttn: PlanetButtons[index-1]))
        }
        
        // add the players
        for index in 0...3
        {
            players.append(Player(name: playerNames[index]))
        }
        
        game()

    }
    
    func game()
    {
        // initial round of fortify at the begining of a game
        for index in 0...3
        {
            players[index].isTurn = true
            // start the timer here
            players[index].fortify()
            // end the timer here
            players[index].isTurn = false
        }
        
        // repeat for a number of times
        for index in 0...3
        {
            players[index].isTurn = true
            
            // start the timer here
            players[index].fortify()
            // end the timer here
            
            // start the timer here
            players[index].attack()
            // end the timer here
            
            // start the timer here
            players[index].reinforce()
            // end the timer here
            
            players[index].isTurn = false
        }
        
        endGame()
    }
    
    func endGame()
    {
        // announce winner, end the game, and return to main menu
    }
    
    
    @IBAction func buttonClicked(_ sender: Any)
    {
        let button = sender as AnyObject
        
        if (numTroops > 0 && addBool) {
            planets[button.tag].addTroops(value: 1)
            button.setTitle(String(planets[button.tag].getTroops()), for: UIControlState.normal)
            numTroops -= 1
            troopCountLabel.text = String(numTroops)
        }
        else if (planets[button.tag].troops > 0 && !addBool) {
            planets[button.tag].removeTroops(value: 1)
            button.setTitle(String(planets[button.tag].getTroops()), for: UIControlState.normal)
            numTroops += 1
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


    //Dice.isHidden = true
    
    @IBAction func DiceRoll(_ sender: UIButton) {
        
    
        
        let Number = arc4random_uniform(5) + 1
        Dice.image = UIImage(named: "Dice\(Number)")
       // Dice2.image = UIImage(named: "Dice2\(Number)")
        troopCountLabel.text = String(Number)
        let when = DispatchTime.now() + 1// change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when){
            let totalTroops = Number
            self.numTroops = Int(totalTroops)
            self.troopCountLabel.text = String(totalTroops)
        }
    }
    @IBAction func reinforceClicked(_ sender: UIButton) {
        //addButton.isHidden = false
        //removeButton.isHidden = false
    }
    @IBAction func reinforceAddTroops(_ sender: UIButton){
        addBool = true
    }
    
    @IBAction func reinforceRemoveTroops(_ sender: UIButton) {
        addBool = false
    }
}