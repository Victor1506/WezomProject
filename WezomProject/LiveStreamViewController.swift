//
//  LiveStreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/24/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import lf
import AVFoundation


class LiveStreamViewController: UIViewController, VCSessionDelegate{
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var connectButton: UIButton!
    var rtmpStream: RTMPStream!
    var rtmpConnection: RTMPConnection!
    
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1280, height: 720), frameRate: 30, bitrate: 1000000, useInterfaceOrientation: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // createLiveStream()
        
        preview.addSubview(session.previewView)
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
            session.startRtmpSessionWithURL("rtmp://a.rtmp.youtube.com/live2", andStreamKey: "wku9-c9qf-8sjk-ccwc")
        default:
            session.endRtmpSession()
            break
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

    func createLiveStream(){
        var rtmpConnection:RTMPConnection = RTMPConnection()
        var rtmpStream = RTMPStream(rtmpConnection: rtmpConnection)
        //rtmpStream.view.frame = CGRect(x: 0, y: 0, width: 400, height: 272)
        rtmpStream.view.frame = self.preview.bounds
        rtmpStream.view.videoGravity = AVLayerVideoGravityResizeAspectFill
        rtmpStream.attachAudio(AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio))
        rtmpStream.attachCamera(AVMixer.deviceWithPosition(.Back))
        rtmpStream.videoSettings = [
            "width": 640, // video output width
            "height": 360, // video output height
        ]
        
        self.preview.addSubview(rtmpStream.view)
        rtmpConnection.connect("rtmp://a.rtmp.youtube.com/live2")
        rtmpStream.publish("wku9-c9qf-8sjk-ccwc")
    }

}

