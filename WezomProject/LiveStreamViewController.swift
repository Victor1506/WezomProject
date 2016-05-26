//
//  LiveStreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/24/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import AVFoundation


class LiveStreamViewController: UIViewController, VCSessionDelegate{
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var bitrateButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1280, height: 720), frameRate: 30, bitrate: 1000000, useInterfaceOrientation: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preview.addSubview(session.previewView)
        addButtonsOnView()
        session.previewView.frame = preview.bounds
        session.delegate = self
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
            cameraButton.setTitle("front", forState: .Normal)
            break
        case VCCameraState.Back:
            session.cameraState = VCCameraState.Front
            cameraButton.setTitle("back", forState: .Normal)
            break
        default:
            break
        }
    }
    
    @IBAction func bitrateChangeButton(sender: AnyObject) {
        
    }
    
    @IBAction func audioMuteButton(sender: AnyObject) {
        switch (session.micGain) {
        case 0.000001:
            session.micGain = 1
        default:
            session.micGain = 0.000001
        }
    }
    
    
    func connectionStatusChanged(sessionState: VCSessionState) {
        switch session.rtmpSessionState {
        case .Starting:
            connectButton.setTitle("Connecting", forState: .Normal)
            
        case .Started:
            connectButton.setTitle("Disconnect", forState: .Normal)
            
        default:
            connectButton.setTitle("Connect", forState: .Normal)
        }
    }
    
    func addButtonsOnView(){
        preview.addSubview(cameraButton)
        preview.addSubview(connectButton)
        preview.addSubview(bitrateButton)
        preview.addSubview(audioButton)
    }


}

