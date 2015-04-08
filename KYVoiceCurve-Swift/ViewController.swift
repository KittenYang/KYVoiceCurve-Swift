//
//  ViewController.swift
//  KYVoiceCurve-Swift
//
//  Created by Kitten Yang on 4/7/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var longPressBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var longGes : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        longGes.minimumPressDuration = 0.8
        self.longPressBt.addGestureRecognizer(longGes)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func longPress(longGes:UILongPressGestureRecognizer){
        if longGes.state == UIGestureRecognizerState.Began{
            
            var path = NSBundle.mainBundle().pathForResource("record", ofType: "mp3")
            var url = NSURL.fileURLWithPath(path!)
            var audioPlayer = AVAudioPlayer()
            audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
            audioPlayer.play()
            
            var voiceCurveView : VoiceCurveView = VoiceCurveView(frame: self.view.frame, sv: self.view)
            voiceCurveView.present()
            
        }
    }


}










