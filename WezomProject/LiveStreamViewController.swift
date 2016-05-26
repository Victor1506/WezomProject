//
//  LiveStreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/24/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import AVFoundation


class LiveStreamViewController: UIViewController, VCSessionDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var bitrateButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    var bitratePickerArr = ["240p", "360p", "480p", "720p", "1080p"]
    var bitratePickerView: UIPickerView = UIPickerView()
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1920, height: 1080), frameRate: 30, bitrate: 1000, useInterfaceOrientation: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add components in main view
        preview.addSubview(session.previewView)
        addButtonsOnView()
        preview.addSubview(bitratePickerView)
        
        //session setting
        session.previewView.frame = preview.bounds
        session.delegate = self
        
        //create custom Picker View
        bitratePickerView.hidden = true
        bitratePickerView.delegate = self
        bitratePickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        session.delegate = nil;
    }
    
    @IBAction func startSessionButton(sender: AnyObject) {
        switch session.rtmpSessionState {
        case .None, .PreviewStarted, .Ended, .Error:
            session.startRtmpSessionWithURL("rtmp://a.rtmp.youtube.com/live2", andStreamKey: "4f31-2xeb-c7dj-8x26")
        default:
            session.endRtmpSession()
            break
        }
    }
    
    @IBAction func cameraChangeButton(sender: AnyObject) {
        switch (session.cameraState) {
        case VCCameraState.Front:
            session.cameraState = VCCameraState.Back
            break
        case VCCameraState.Back:
            session.cameraState = VCCameraState.Front
            break
        default:
            break
        }
    }
    
    @IBAction func bitrateChangeButton(sender: AnyObject) {
       bitratePickerView.hidden = false
        print("set bitrate")
        //session.bitrate
    }
    
    @IBAction func audioMuteButton(sender: AnyObject) {
        switch (session.micGain) {
        case 0.000001:
            session.micGain = 1
            let image = UIImage(named: "Microphone-On.png")! as UIImage
            audioButton.setImage(image, forState: .Normal)
        default:
            session.micGain = 0.000001
            let image = UIImage(named: "Microphone-Off.png")! as UIImage
            audioButton.setImage(image, forState: .Normal)
        }
    }
    
    func connectionStatusChanged(sessionState: VCSessionState) {
        switch session.rtmpSessionState {
        case .Starting:
            let image = UIImage(named: "Start.png")! as UIImage
            connectButton.setImage(image, forState: .Normal)
        case .Started:
            let image = UIImage(named: "Stop.png")! as UIImage
            connectButton.setImage(image, forState: .Normal)
            
        default:
            let image = UIImage(named: "Start.png")! as UIImage
            connectButton.setImage(image, forState: .Normal)
        }
    }
    
    func addButtonsOnView(){
//        preview.addSubview(cameraButton)
//        preview.addSubview(connectButton)
//        preview.addSubview(bitrateButton)
      //  preview.addSubview(audioButton)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bitratePickerArr.count;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bitrateButton.setTitle(bitratePickerArr[row], forState: .Normal)
        setBitrate(bitratePickerArr[row])
        pickerView.hidden = true
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: bitratePickerArr[row], attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
        return attributedString
    }
    
    func setBitrate(videoResolution: String){
        switch videoResolution {
        case "1080p":
             session.bitrate = 5000
        case "720p":
            session.bitrate = 3900
        case "480p":
             session.bitrate = 1900
        case "360p":
             session.bitrate = 900
        case "240p":
             session.bitrate = 600
        default:
            print("incorrect resolution")
        }
    }
}

