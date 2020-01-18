//
//  ViewController.swift
//  BullsEye
//
//  Created by Jesús Calleja Rodríguez on 02/01/2020.
//  Copyright © 2020 Jesús Calleja Rodríguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var currentRound = 0
    let bonus = 50
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var currentRoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(slider.value.rounded())
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
     
    @IBAction func resetGame() {
        score = 0
        currentRound = 0
        startNewRound()
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
    
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += bonus*2
        } else if difference == 1{
            points += bonus
            title = "You almost had it"
        } else if difference < 5 {
            title = "You almost had it"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close"
        }
        
        score += points
        
        let message = "You scored: \(points) points"
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = Int(slider.value.rounded())
    }

    func startNewRound(){
    currentRound += 1
    currentRoundLabel.text = String(currentRound)
    targetValue = Int.random(in: 1...100)
    //Reset slider
    currentValue = 50
    slider.value = Float(currentValue)
    targetValueLabel.text = String(targetValue)
    totalScoreLabel.text = String(score)
    }
}

