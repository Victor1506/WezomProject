//
//  PersistentBroadcastViewModel.swift
//  WezomProject
//
//  Created by Vitya on 5/27/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

protocol PBViewModelDelegate {
    func broadcastViewModelDataReady()
}

class PersistentBroadcastViewModel: NSObject, PBModelDelegate, VCSessionDelegate {

    let persBroadModel = PersistentBroadcastModel()
    var pBroadViewModelDelegate: PBViewModelDelegate?
    var session = VCSimpleSession(videoSize: CGSize(width:  1280, height: 720), frameRate: 30, bitrate: 500000, useInterfaceOrientation: false)
    
    var persistentBroadcastID = ""
    var persistentBroadcastTitle = ""
    var persistentBroadcastDescription = ""
    var persistentBroadcastBoundStreamId = ""
    var boundStreamLastUpdateTimeMs = ""
    var persistentStreamID = ""
    var persistentStreamTitle = ""
    var persistentStreamDescription = ""
    var persistentStreamKEY = ""
    var persistentStreamIngestionAddress = ""
    var persistentStreamBackupIngestionAddress = ""
    var persistentStreamResolution = ""
    var persistentStreamFrameRate = ""
    
    override init() {
        super.init()
        
        self.persBroadModel.persBroadModelDelegate = self
        //get defoult stream information
        self.persBroadModel.getPersistentBroadcast()
        
        //session setting
        session.delegate = self
    }
    
    func persBroadDataReady(){
         persistentBroadcastID = persBroadModel.persistentBroadcastID
         persistentBroadcastTitle = persBroadModel.persistentBroadcastTitle
         persistentBroadcastDescription = persBroadModel.persistentBroadcastDescription
         persistentBroadcastBoundStreamId = persBroadModel.persistentBroadcastBoundStreamId
         boundStreamLastUpdateTimeMs = persBroadModel.boundStreamLastUpdateTimeMs
         persistentStreamID = persBroadModel.persistentStreamID
         persistentStreamTitle = persBroadModel.persistentStreamTitle
         persistentStreamDescription = persBroadModel.persistentStreamDescription
         persistentStreamKEY = persBroadModel.persistentStreamKEY
         persistentStreamIngestionAddress = persBroadModel.persistentStreamIngestionAddress
         persistentStreamBackupIngestionAddress = persBroadModel.persistentStreamBackupIngestionAddress
         persistentStreamResolution = persBroadModel.persistentStreamResolution
         persistentStreamFrameRate = persBroadModel.persistentStreamFrameRate
        
        //Notify the delegate that the data is ready
        if self.pBroadViewModelDelegate != nil {
            self.pBroadViewModelDelegate!.broadcastViewModelDataReady()
        }
    }
    
    func startVideoSession(){
        session.startRtmpSessionWithURL(self.persistentStreamIngestionAddress, andStreamKey: self.persistentStreamKEY)
    }
    
    func stopVideoSession(){
        session.endRtmpSession()
    }
    
    func microOff(){
        session.micGain = 0.000001
    }
    
    func microOn(){
        session.micGain = 1
    }
    
    func setSessionPreviewAsView(view: UIView){
        session.previewView.frame = view.bounds
    }
    
    func setSessionPreview(view: CGRect){
        session.previewView.frame = view
    }
    
    func sessionCameraFront(){
        session.cameraState = VCCameraState.Front
    }
    
    func sessionCameraBack(){
        session.cameraState = VCCameraState.Back
    }
    
    func setBitrate(bitrate : Int32){
        session.bitrate = bitrate
    }
    
    func connectionStatusChanged(sessionState: VCSessionState) {
//        switch session.rtmpSessionState {
//        case .Starting:
//            let image = UIImage(named: "Start.png")! as UIImage
//            connectButton.setImage(image, forState: .Normal)
//        case .Started:
//            let image = UIImage(named: "Stop.png")! as UIImage
//            connectButton.setImage(image, forState: .Normal)
//            
//        default:
//            let image = UIImage(named: "Start.png")! as UIImage
//            connectButton.setImage(image, forState: .Normal)
//        }
    }
}
