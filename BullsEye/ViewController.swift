//
//  ViewController.swift
//  BullsEye
//
//  Created by Matt Reilly on 12/24/14.
//  Copyright (c) 2014 Fountain and Fairchild LLC. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
                trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable =
                trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewGame() {
        currentValue = 50
        targetValue = 0
        score = 0
        round = 0
        startNewRound()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference

        if difference == 0 {
            points += 100
        } else if difference == 1 {
            points += 50
        }
        
        score += points
        
        let message = "You scored \(points) points!"
        
        var title: String
        
        if difference == 0 {
            title = "Perfecto!"
        } else if difference < 5 {
            title = "Ooooh! So close!"
        } else if difference < 10 {
            title = "Okay, not terrible."
        } else {
            title = "That actually is terrible."
        }
        
        let alert = UIAlertController(title: title, message: message,
            preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default,
            handler: { action in
                            self.startNewRound()
                            self.updateLabels()
                     })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }

}
