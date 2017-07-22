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
    var attackFlag = 0
    var addBool = false // this should be set to true, using false for debug
    
    @IBOutlet var PlanetButtons: [UIButton]!
    @IBOutlet weak var Dice: UIImageView!
    @IBOutlet weak var troopCountLabel: UILabel!
    @IBOutlet weak var Action: UIImageView!
    
    @IBOutlet weak var reinforceAddButton: UIButton!
    @IBOutlet weak var reinforceRemoveButton: UIButton!
    
    @IBOutlet var TurnShadow: [UIImageView]!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    //Player 1
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    
    //Player 2
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    //Player 3
    @IBOutlet weak var player3Image: UIImageView!
    @IBOutlet weak var player3Name: UILabel!
    @IBOutlet weak var player3Score: UILabel!
    
    //Player 4
    @IBOutlet weak var player4Image: UIImageView!
    @IBOutlet weak var player4Name: UILabel!
    @IBOutlet weak var player4Score: UILabel!
    
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
        
        reinforceAddButton.isHidden = true
        reinforceRemoveButton.isHidden = true
        
    }
    
    // timer to control the turns
    var GameTimer = Timer()
    var ActionTimer = Timer()
    var initFort = true
    
    // 0 == fortify, 1 == attack, 2 == reinforce
    var currentAction = -1
    
    override func viewDidAppear(_ animated: Bool) {
        
        // I can't find a better way of controlling the turns, we need to stop this after the initial round of fortify
        GameTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(GameViewController.turn), userInfo: nil, repeats: true)
    }
    
    func initFortify() {
        
        startButton() // <--- starts the timer for a turn
        
        TurnShadow[currentPlayer].isHidden = true
        currentPlayer = (currentPlayer+1) % 4
        
        TurnShadow[currentPlayer].isHidden = false
        
        DiceRoll()
        
        if currentPlayer == 3 {
            initFort = false
        }
        
    }
    
    func turn() {
        
        if initFort == true {
            initFortify()
        }
        else {
            // fortify
            currentAction = (currentAction + 1) % 3

            if currentAction == 0 {
                addBool = true
                TurnShadow[currentPlayer].isHidden = true
                currentPlayer = (currentPlayer+1) % 4
                TurnShadow[currentPlayer].isHidden = false
                startButton()
                Action.image = UIImage(named: "Fortify")
                DiceRoll()
                print("fortify and currentAction = \(currentAction)")
                // do any other preparation for fortify
            }
            // attack
            else if currentAction == 1 {
                startButton()
                Action.image = UIImage(named: "Attack")
                print("attack and currentAction = \(currentAction)")
                // do any other preparation for attack
            }
            // reinforce
            else if currentAction == 2 {
                startButton()
                Action.image = UIImage(named: "Reinforce")
                reinforceAddButton.isHidden = false
                reinforceRemoveButton.isHidden = false
                print("reinforce and currentAction = \(currentAction)")
                // do any other preparation for reinforce
            }
//            currentAction = (currentAction + 1) % 3

        }
        numTroops = 0
    }
    
    
    //announce winner, end the game, and return to main menu
    
    @IBOutlet weak var EndGameView: UIView!
    @IBOutlet weak var WinnerLabel: UILabel!
    @IBOutlet weak var Return: UIButton!
    func endGame()
    {
        
        if player1Score.text! > player2Score.text! && player1Score.text! > player3Score.text! && player1Score.text! > player4Score.text! {
            EndGameView.isHidden = false
            WinnerLabel.text = "The winner is \(player1Name.text!)"
        }
        else if (player2Score.text! > player1Score.text! && player2Score.text! > player3Score.text! && player2Score.text! > player4Score.text!){
            EndGameView.isHidden = false
            WinnerLabel.text = "The winner is \(player2Name.text!)"
        }
            
        else if (player3Score.text! > player1Score.text! && player3Score.text! > player2Score.text! && player3Score.text! > player4Score.text!){
            EndGameView.isHidden = false
            WinnerLabel.text = "The winner is \(player3Name.text!)"
        }
            
        else if (player4Score.text! > player1Score.text! && player4Score.text! > player3Score.text! && player4Score.text! > player2Score.text!) {
            EndGameView.isHidden = false
            WinnerLabel.text = "The winner is \(player4Name.text!)"
        }
        
        
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        let button = sender as AnyObject
        
        if (currentAction == 0 || currentAction == -1) {
            attackFlag = 0
            print("fortifying")
            players[currentPlayer].fortify(player: players[currentPlayer], planet: planets[button.tag], numTroops: &numTroops)
        }
        else if (currentAction == 1) {
            print("attack commenced, player: \(currentPlayer + 1)")
            players[currentPlayer].attack(attacker: planets[button.tag], defender: planets[button.tag], whatToDo: &attackFlag)
        }
        else if (currentAction == 2) {
            attackFlag = 0
            print("reinforcing")
            players[currentPlayer].reinforce(planet: planets[button.tag], numTroops: &numTroops, addBool: addBool)
        }
        troopCountLabel.text = String(numTroops)
        player1Score.text! = String(players[0].score)
        player2Score.text! = String(players[1].score)
        player3Score.text! = String(players[2].score)
        player4Score.text! = String(players[3].score)
    }
    
    @IBAction func setAddBoolTrue(_ sender: UIButton) {
        addBool = true
    }
    
    @IBAction func setAddBoolFalse(_ sender: UIButton) {
        addBool = false
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
    
    var seconds = 15
    var timer = Timer()
    var timerIsOn = false
    
    func startButton()
    {
        //if timerIsOn == false {
        if(currentAction == 2) {
            reinforceRemoveButton.isHidden = false
            reinforceAddButton.isHidden = false
        }
        else {
            reinforceAddButton.isHidden = true
            reinforceRemoveButton.isHidden = true
        }
        seconds = 15
        timerIsOn = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.updateTimer), userInfo: nil, repeats: true)
        //}
        
    }
    
    func updateTimer() {
        
        print(seconds) //<-- I was using this for debug
        
        // stops the timer from going negative
        if timerIsOn == true {
            seconds -= 1
            countDownTimer.text = "\(seconds)"
        }
        
        if seconds == 0 {
            endButton()
        }
    }
    
    func endButton() {
        //seconds = 0
        countDownTimer.text = "\(seconds)"
        timerIsOn = false
        timer.invalidate()

    }
    
    func DiceRoll() {
        let Number = arc4random_uniform(5) + 1
        Dice.image = UIImage(named: "Dice\(Number)")
        troopCountLabel.text = String(Number)
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when){
            let Number2 = arc4random_uniform(5) + 1
            self.Dice.image = UIImage(named: "Dice\(Number2)")
            let totalTroops = Number + Number2
            self.numTroops = Int(totalTroops)
            self.troopCountLabel.text = String(totalTroops)
        }
    }
    
    // this ends the visible timer but doesn't change the turn
    @IBAction func doneClicked(_ sender: Any) {
        endButton()
    }
}
