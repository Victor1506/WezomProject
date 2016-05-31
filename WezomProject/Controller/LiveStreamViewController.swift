//
//  LiveStreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/24/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import AVFoundation
import RxCocoa
import RxSwift


class LiveStreamViewController: UIViewController, PBViewModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var bitrateButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    let startImage = UIImage(named: "Start.png")! as UIImage
    let stopImage = UIImage(named: "Stop.png")! as UIImage
    
    var persBroadViewModel = PersistentBroadcastViewModel()
    let disposeBag = DisposeBag()
    
    var bitratePickerArr = ["240p", "360p", "480p", "720p", "1080p"]
    var bitratePickerView = UIPickerView()
    var connectingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add components in main view
        preview.addSubview(persBroadViewModel.getSessionPreview())
        addButtonsOnView()
        preview.addSubview(bitratePickerView)
        
        //session setting
        persBroadViewModel.setSessionPreview(preview.bounds)
        
        //create custom Picker View
        bitratePickerView.hidden = true
        bitratePickerView.delegate = self
        bitratePickerView.dataSource = self

        //check session state
        persBroadViewModel.curentSessionState.subscribeNext { sessionStatus in
            switch sessionStatus {
            case VCSessionState.Starting:
                self.connectButton.setImage(self.stopImage, forState: .Normal)
                self.connectingIndicatorView.startAnimating()
            case VCSessionState.Started:
                self.connectButton.setImage(self.stopImage, forState: .Normal)
                self.connectingIndicatorView.stopAnimating()
            case VCSessionState.Ended:
                self.connectButton.setImage(self.startImage, forState: .Normal)
            case VCSessionState.Error:
                self.connectingIndicatorView.stopAnimating()
            default:
                print("satus error")
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(false)
        persBroadViewModel.stopVideoSession()
        persBroadViewModel.deinitSession()
    }
    
     deinit {
        persBroadViewModel.deinitSession()
    }
    
    @IBAction func startSessionButton(sender: AnyObject) {
        switch persBroadViewModel.sessionState() {
        case .None, .PreviewStarted, .Ended, .Error:
            persBroadViewModel.startVideoSession()
            bitrateButton.hidden = true
        case .Started, .Starting:
            persBroadViewModel.stopVideoSession()
            persBroadViewModel.deinitSession()
        }
    }
    
    @IBAction func cameraChangeButton(sender: AnyObject) {
        switch (persBroadViewModel.sessionCameraState()) {
        case VCCameraState.Front:
            persBroadViewModel.sessionCameraBack()
            break
        case VCCameraState.Back:
            persBroadViewModel.sessionCameraFront()
            break
        }
    }
    
    @IBAction func bitrateChangeButton(sender: AnyObject) {
       bitratePickerView.hidden = false
        print("set bitrate")
        //session.bitrate
    }
    
    @IBAction func audioMuteButton(sender: AnyObject) {
        switch (persBroadViewModel.sessionMicroGain()) {
        case 0.000001:
            persBroadViewModel.microOn()
            let image = UIImage(named: "Microphone-On.png")! as UIImage
            audioButton.setImage(image, forState: .Normal)
        default:
            persBroadViewModel.microOff()
            let image = UIImage(named: "Microphone-Off.png")! as UIImage
            audioButton.setImage(image, forState: .Normal)
        }
    }
    
    func addButtonsOnView(){
        preview.addSubview(cameraButton)
        preview.addSubview(connectButton)
        preview.addSubview(bitrateButton)
        preview.addSubview(audioButton)
        preview.addSubview(connectingIndicatorView)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bitratePickerArr.count;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bitrateButton.setTitle(bitratePickerArr[row], forState: .Normal)
        
        //set video resolution
        persBroadViewModel.setResolution(bitratePickerArr[row])
        pickerView.hidden = true
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: bitratePickerArr[row], attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
        return attributedString
    }
    
    func broadcastViewModelDataReady(){
        
    }
}

