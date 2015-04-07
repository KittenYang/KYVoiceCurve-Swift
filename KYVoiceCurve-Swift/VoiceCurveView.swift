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
        
    }
    
    func fullPathAtCache(fileName:NSString)-> NSString{
        var pathArray : Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path: String = pathArray.objectAtIndex(0)
        let fm  = NSFileManager .defaultManager()
        if fm.fileExistsAtPath(path){
            
        }
    }


    //------present---------
    func present()->Void{
        
    }
    
}

