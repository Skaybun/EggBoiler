//
//  ViewController.swift
//  EggBoiler
//
//  Created by Ali KINU on 23.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    var countDownSeconds = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        countDownSeconds = totalTime
        progressBar.progress = 0.0
        secondsPassed = -1
        titleLabel.text = hardness
        updateTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
            if totalTime == eggTimes["Soft"] {
                if countDownSeconds == 0 {
                    titleLabel.text = "DONE!"
                }else {
                    titleLabel.text = "Ready in \(String(countDownSeconds)) second"
                }
                countDownSeconds -= 1
            }
            if secondsPassed == totalTime {
                timer.invalidate()
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
    }
    
}
