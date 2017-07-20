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
    var currentPlayer = 3
    var planets = [Planet]()
    var players = [Player]()
    var imageList:[Int] = [0,1,2,3]
    var playerNames: [String] = ["name", "name", "name", "name"]
    var numTroops = 0
    var addBool = true
    @IBOutlet var PlanetButtons: [UIButton]!
    @IBOutlet weak var Dice: UIImageView!
    @IBOutlet weak var troopCountLabel: UILabel!
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var Action: UIImageView!
    
    @IBOutlet var TurnShadow: [UIImageView]!
    
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
            if playerNames[index].isEmpty {
                playerNames[index] = "Player\(index + 1):"
            }
            players.append(Player(name: playerNames[index]))
        }
        
        for i in TurnShadow
        {
            i.isHidden = true
        }
        
        player1Name.text = playerNames[0]
        player1Score.text = String(players[0].score)
        player1Image.image = UIImage(named: "alien\(imageList[0])")!
        
        player2Name.text = playerNames[1]
        player2Score.text = String(players[1].score)
        player2Image.image = UIImage(named: "alien\(imageList[1])")!

        player3Name.text = playerNames[2]
        player3Score.text = String(players[2].score)
        player3Image.image = UIImage(named: "alien\(imageList[2])")!

        player4Name.text = playerNames[3]
        player4Score.text = String(players[3].score)
        player4Image.image = UIImage(named: "alien\(imageList[3])")!

    }
    
    // timer to control the turns
    var GameTimer = Timer()
    
    // 0 == fortify, 1 == attack, 2 == reinforce
    // maybe use this to know which action should be happening when a planet is clicked
    var currentAction = 0
    
    override func viewDidAppear(_ animated: Bool) {
        
        // I can't find a better way of controlling the turns, we need to stop this after the initial round of fortify
        GameTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(GameViewController.fortify), userInfo: nil, repeats: true)
        
    }

    
    func fortify(){
        
        startButton() // <--- starts the timer for a turn
        
        if currentPlayer == 3
        {
            TurnShadow[currentPlayer].isHidden = true
            players[currentPlayer].isTurn = false
            currentPlayer = 0
        }
        else {
            TurnShadow[currentPlayer].isHidden = true
            players[currentPlayer].isTurn = false
            currentPlayer += 1
        }
        
        TurnShadow[currentPlayer].isHidden = false
        players[currentPlayer].isTurn = true
        
        
        for i in planets
        {
            if i.owner == nil
            {
                // i.planetButton. <<-- do something with the planets without owners
            }
        }
        
        //print("turn") <<-- I was using this for debug
        
    }
    
  
    func endGame()
    {
        // announce winner, end the game, and return to main menu
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        
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
    
    var seconds = 30
    var timer = Timer()
    var timerIsOn = false
    
    func startButton()
    {
        //if timerIsOn == false {
            seconds = 30
            timerIsOn = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
        //}
        
    }
   
    func endButton() {
        seconds = 0
        countDownTimer.text = "\(seconds)"
        timerIsOn = false
        timer.invalidate()
    }

    func updateTimer() {
        
        //print(seconds) <-- I was using this for debug
        
        // stops the timer from going negative
        if timerIsOn == true {
            seconds -= 1
            countDownTimer.text = "\(seconds)"
        }
        
        if seconds == 0 {
            endButton()
        }
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
    
    // this ends the visible timer but doesn't change the turn
    @IBAction func doneClicked(_ sender: Any) {
        endButton()
    }
}
