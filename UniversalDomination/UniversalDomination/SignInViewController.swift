//
//  SignInViewController.swift
//  UniversalDomination
//
//  Created by Pranay Jay Patel on 6/28/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet var playerNames: [UITextField]!
    @IBOutlet weak var Player1AvatarChangerButton: UIButton!
    @IBOutlet weak var Player1AvatarImageView: UIImageView!
    @IBOutlet weak var Player2AvatarChangerButton: UIButton!
    @IBOutlet weak var Player2AvatarImageView: UIImageView!
    @IBOutlet weak var Player3AvatarChangerButton: UIButton!
    @IBOutlet weak var Player3AvatarImageView: UIImageView!
    @IBOutlet weak var Player4AvatarChangerButton: UIButton!
    @IBOutlet weak var Player4AvatarImageView: UIImageView!
    
    var counter1 = 0;
    var counter2 = 1;
    var counter3 = 2;
    var counter4 = 3;
    
    
    let image1 : UIImage = UIImage(named: "alien1")!
    let image2 : UIImage = UIImage(named: "alien2")!
    let image3 : UIImage = UIImage(named: "alien3")!
    let image4 : UIImage = UIImage(named: "alien4")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Player1AvatarImageView.image = image1
        view.addSubview(Player1AvatarImageView)

        Player2AvatarImageView.image = image2
        view.addSubview(Player2AvatarImageView)
        
        Player3AvatarImageView.image = image3
        view.addSubview(Player3AvatarImageView)
        
        Player4AvatarImageView.image = image4
        view.addSubview(Player4AvatarImageView)
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Player1AvatarClick(_ sender: Any) {
        counter1 = (counter1 + 1) % 4
        Player1AvatarImageView.image = UIImage(named: "alien\(counter1+1)")!
    }
    
    @IBAction func Player2AvatarClick(_ sender: Any) {
        counter2 = (counter2 + 1) % 4
        Player2AvatarImageView.image = UIImage(named: "alien\(counter2+1)")!
    }
    
    @IBAction func Player3AvatarClick(_ sender: Any) {
        counter3 = (counter3 + 1) % 4
        Player3AvatarImageView.image = UIImage(named: "alien\(counter3+1)")!
    }
    
    @IBAction func Player4AvatarClick(_ sender: Any) {
        counter4 = (counter4 + 1) % 4
        Player4AvatarImageView.image = UIImage(named: "alien\(counter4+1)")!
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Game"
        {
            // pass data to next view
            if let destination = segue.destination as? GameViewController
            {
                destination.imageList[0] = counter1 + 1
                destination.imageList[1] = counter2 + 1
                destination.imageList[2] = counter3 + 1
                destination.imageList[3] = counter4 + 1
                for index in 0...3
                {
                    destination.playerNames[index] = playerNames[index].text!
                }
            }
            
        }
    }
 

}
