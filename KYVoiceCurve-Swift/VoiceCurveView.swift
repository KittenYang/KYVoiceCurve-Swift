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
    
    let ScreenWidth  = UIScreen.mainScreen().bounds.size.width
    let ScreenHeight = UIScreen.mainScreen().bounds.size.height
 
    var recordSettings = [
        AVFormatIDKey: kAudioFormatLinearPCM,
        AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
        AVEncoderBitRateKey : 8000.0,
        AVNumberOfChannelsKey: 1,
        AVSampleRateKey : 16
    ]
    
    var SUPERVIEW : UIView!
    var recoder : AVAudioRecorder!
    var displayLink : CADisplayLink!
    
    var blurView : UIVisualEffectView!
    var layer1 : CAShapeLayer!
    var layer2 : CAShapeLayer!
    var layer3 : CAShapeLayer!
    var layer4 : CAShapeLayer!
    var layer5 : CAShapeLayer!
    
    
    init(frame: CGRect,sv:UIView) {
        
//        SUPERVIEW = sv
//        recoder = AVAudioRecorder()
//        displayLink = CADisplayLink()
//        blurView = UIVisualEffectView()
//        layer1 = CAShapeLayer()
//        layer2 = CAShapeLayer()
//        layer3 = CAShapeLayer()
//        layer4 = CAShapeLayer()
//        layer5 = CAShapeLayer()
        
        super.init()
        
        self.setUp()
        sv.addSubview(self)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setUp() ->Void{
        setAudioProperties()
        self.backgroundColor = UIColor.clearColor()
    
        self.blurView =  UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        self.blurView!.frame = self.frame
        var tapGes = UITapGestureRecognizer(target: self, action: "dismiss")
        self.blurView.addGestureRecognizer(tapGes)
        self.blurView.alpha = 0.0
        self.blurView.tag = 101
        
        self.addSubview(self.blurView)
        
        //layer1
        layer1 = CAShapeLayer()
        layer1.fillColor = UIColor.yellowColor().CGColor
        layer1.opacity = 0.7
        blurView.layer.addSublayer(layer1)
        
        //layer2
        layer2 = CAShapeLayer()
        layer2.fillColor = UIColor.magentaColor().CGColor
        layer2.opacity = 0.7
        blurView.layer.addSublayer(layer2)
        
        //layer3
        layer3 = CAShapeLayer()
        layer3.fillColor = UIColor.orangeColor().CGColor
        layer3.opacity = 0.7
        blurView.layer.addSublayer(layer3)
        
        //layer4
        layer4 = CAShapeLayer()
        layer4.fillColor = UIColor.redColor().CGColor
        layer4.opacity = 0.7
        blurView.layer.addSublayer(layer4)
        
        //layer5
        layer5 = CAShapeLayer()
        layer5.fillColor = UIColor(red: 0, green: 0.722, blue: 1, alpha: 1).CGColor
        layer5.opacity = 0.7
        blurView.layer.addSublayer(layer5)
        
        var listeningLabel = UILabel()
        listeningLabel.frame = CGRectMake(ScreenWidth/2 - 320/2, 100, 320, 30)
        listeningLabel.textAlignment = NSTextAlignment.Center
        listeningLabel.font = UIFont.systemFontOfSize(30.0)
        listeningLabel.textColor = UIColor.whiteColor()
        listeningLabel.text = "正在聆听..."
        self.blurView.addSubview(listeningLabel)

    }
    
    func setAudioProperties() ->Void{
        if self.recoder.recording {
            return
        }
        let audioSession = AVAudioSession .sharedInstance()
        let err = NSError()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        var url = NSURL .fileURLWithPath(self.fullPathAtCache("record.wav") as String)
        var existedData = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMapped, error: nil)
        if existedData != nil {
            let fm = NSFileManager .defaultManager()
            fm .removeItemAtPath("ddd", error: nil)
        }
        
        self.recoder = AVAudioRecorder(URL: url, settings:recordSettings as [NSObject : AnyObject], error: nil)
        self.recoder.meteringEnabled = true
        self.recoder.record()
        self.recoder.prepareToRecord()
        
        self.displayLink = CADisplayLink(target: self, selector: "drawRealTimeCurve")
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func fullPathAtCache(fileName:NSString)-> NSString{
        var pathArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        var path = pathArray.objectAtIndex(0) as! String
        let fm  = NSFileManager .defaultManager()
        if fm.fileExistsAtPath(path) != true {
            if fm .createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: nil) != true {
                println("create dir path = \(path)")
            }
        }
        return path .stringByAppendingPathComponent(fileName as String)
    }

    //------重绘函数-----
    func drawRealTimeCurve()->Void{
        self.recoder .updateMeters()
        println("volume:\(self.recoder.averagePowerForChannel(0))")
        
        var volume : CGFloat = CGFloat(self.recoder.averagePowerForChannel(0))
        var controlY1 = ScreenHeight - (volume+60)
        var controlY2 = ScreenHeight - ((volume+60)+10)*1.5;
        var controlY3 = ScreenHeight - ((volume+60)+15)*2.3;
        var controlY4 = ScreenHeight - ((volume+60)+12)*2;
        var controlY5 = ScreenHeight - ((volume+60)+5)*1.5;

        let p3_0 : CGFloat = (ScreenWidth/2-10-30)/2+30
        let p3_1 : CGFloat = (ScreenWidth-20-ScreenWidth*5/8)/2
        let p3_2 : CGFloat = ScreenWidth*5/8-20
        
        let p4_0 : CGFloat = ScreenWidth/2-20
        
        let p5_0 : CGFloat = ScreenWidth*5/8-20
        
        layer1.path = self.createBezierPathWithStartPoint(CGPointMake(30, ScreenHeight), endPoint: CGPointMake(ScreenWidth/2-10, ScreenHeight), controlPoint: CGPointMake((ScreenWidth/2-10-30)/2+30, controlY1)).CGPath
        
        layer2.path = self.createBezierPathWithStartPoint(CGPointMake(50, ScreenHeight), endPoint:CGPointMake(ScreenWidth*5/8, ScreenHeight), controlPoint: CGPointMake((ScreenWidth*5/8-50)/2+35,controlY2)).CGPath
        
        layer3.path = self.createBezierPathWithStartPoint(CGPointMake(p3_0, ScreenHeight), endPoint: CGPointMake(p3_1+p3_2, ScreenHeight) , controlPoint: CGPointMake((p3_1+p3_2-((ScreenWidth/2-10-30)/2+30))/2 + p3_0, controlY3)).CGPath
        
        layer4.path = self.createBezierPathWithStartPoint(CGPointMake(p4_0, ScreenHeight), endPoint: CGPointMake(ScreenWidth*7/8, ScreenHeight), controlPoint: CGPointMake((ScreenWidth*7/8-p4_0)/2+p4_0, controlY4)).CGPath
        
        layer5.path = self.createBezierPathWithStartPoint(CGPointMake(p5_0, ScreenHeight), endPoint: CGPointMake(ScreenWidth-20, ScreenHeight), controlPoint: CGPointMake((ScreenWidth-20-p5_0)/2+p5_0, controlY5)).CGPath
    }
    
    
    func createBezierPathWithStartPoint(startPoint : CGPoint,endPoint:CGPoint,controlPoint:CGPoint)->UIBezierPath{
        var BezierPath = UIBezierPath()
        BezierPath.moveToPoint(startPoint)
        BezierPath.addQuadCurveToPoint(endPoint, controlPoint: controlPoint)
        return BezierPath
    }

    //------present---------
    func present()->Void{
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .AllowUserInteraction | .BeginFromCurrentState, animations: { () -> Void in
            var bv : UIView  = self.SUPERVIEW.viewWithTag(101)!
            bv.alpha = 1.0
        }, completion: nil)
        
    }
    
    func dismiss()->Void{
        UIView.animateWithDuration(0.3, delay: 0.0, options: .AllowUserInteraction | .BeginFromCurrentState, animations: { () -> Void in
            var bv : UIView = self.SUPERVIEW.viewWithTag(101)!
            bv.alpha = 0.0
        }) { (finish) -> Void in
            self.removeFromSuperview()
            self.displayLink.invalidate()
//            self.displayLink = nil
        }
    }
}

