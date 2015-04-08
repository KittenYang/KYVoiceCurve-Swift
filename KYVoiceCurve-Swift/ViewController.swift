//
//  ViewController.swift
//  KYVoiceCurve-Swift
//
//  Created by Kitten Yang on 4/7/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var longGes : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress")
        longGes.minimumPressDuration = 0.8

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

