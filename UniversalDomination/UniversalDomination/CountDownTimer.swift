//
//  CountDownTimer.swift
//  UniversalDomination
//
//  Created by Uyen Nguyen on 6/22/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController, CountdownTimerDelegate {
    
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    let countdownTimer = CountdownTimer()
    var countdownTimerDidStart = false
    
    // Test, for dev
    let selectedSecs = 10
    
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame:CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: UIFontWeightLight)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Done!"
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer.delegate = self
        countdownTimer.setTimer(hours: 0, minutes: 0, seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        
        
        view.addSubview(messageLabel)
        
        var constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        
        messageLabel.isHidden = true
        counterView.isHidden = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - Delegates
    
    func countdownTime(time: (hours: String, minutes: String, seconds: String)) {
        hours.text = time.hours
        minutes.text = time.minutes
        seconds.text = time.seconds
    }
    
    
    func countdownTimerDone() {
        
        counterView.isHidden = true
        messageLabel.isHidden = false
        seconds.text = String(selectedSecs)
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print("countdownTimerDone")
    }
    
    
    
    
    //MARK: - Actions
    
    @IBAction func startTimer(_ sender: UIButton) {
        
        messageLabel.isHidden = true
        counterView.isHidden = false
        
        stopBtn.isEnabled = true
        stopBtn.alpha = 1.0
        
        if !countdownTimerDidStart{
            countdownTimer.start()
            progressBar.start()
            countdownTimerDidStart = true
            startBtn.setTitle("PAUSE",for: .normal)
            
        }else{
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startBtn.setTitle("RESUME",for: .normal)
        }
    }
    
    
    @IBAction func stopTimer(_ sender: UIButton) {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopBtn.isEnabled = false
        stopBtn.alpha = 0.5
        startBtn.setTitle("START",for: .normal)
    }
    
    
    
    
    
}
