//
//  VoiceCurveView.swift
//  KYVoiceCurve-Swift
//
//  Created by Kitten Yang on 4/7/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceCurveView: UIView {

    var SUPERVIEW : UIView
    var recordSettings =
    [
        AVFormatIDKey : kAudioFormatLinearPCM,
        AVEncoderBitRateKey:16,
        AVEncoderAudioQualityKey : AVAudioQuality.Max,
        AVSampleRateKey : 8000.0,
        AVNumberOfChannelsKey : 1,
    ]
    var recoder : AVAudioRecorder
    
    
    init(frame: CGRect,sv:UIView) {
        
        SUPERVIEW = sv
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() ->Void{
        
    }
    
    func setAudioProperties() ->Void{
        if self.recoder.recording {
            return
        }
        let audioSession = AVAudioSession .sharedInstance()
//        let err = NSError()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        var url = NSURL .fileURLWithPath(self.fullPathAtCache("record.wav"))
        var existedData = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMapped, error: nil)
        if existedData != nil {
            let fm = NSFileManager .defaultManager()
            fm .removeItemAtPath("ddd", error: nil)
        }
        
        self.recoder = AVAudioRecorder(URL: url, settings:recordSettings, error: nil)
        
    }
    
    func fullPathAtCache(fileName:NSString)-> NSString{
        var pathArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        var path = pathArray.objectAtIndex(0) as String
        let fm  = NSFileManager .defaultManager()
        if fm.fileExistsAtPath(path) != true {
            if fm .createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil) != true {
                println("create dir path = \(path)")
            }
        }
        return path .stringByAppendingPathComponent(fileName)
    }


    //------present---------
    func present()->Void{
        
    }
    
}

