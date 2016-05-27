//
//  LiveStreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/24/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import AVFoundation


class LiveStreamViewController: UIViewController, PBViewModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var bitrateButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    
    var persBroadViewModel = PersistentBroadcastViewModel()
    
    var bitratePickerArr = ["240p", "360p", "480p", "720p", "1080p"]
    var bitratePickerView: UIPickerView = UIPickerView()
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        persBroadViewModel.deinitSession()
    }
    
    @IBAction func startSessionButton(sender: AnyObject) {
        switch persBroadViewModel.sessionState() {
        case .None, .PreviewStarted, .Ended, .Error:
            persBroadViewModel.startVideoSession()
        default:
            persBroadViewModel.stopVideoSession()
            break
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
            persBroadViewModel.setBitrate(5000)
        case "720p":
            persBroadViewModel.setBitrate(3900)
        case "480p":
            persBroadViewModel.setBitrate(1900)
        case "360p":
            persBroadViewModel.setBitrate(900)
        case "240p":
            persBroadViewModel.setBitrate(600)
        default:
            print("incorrect resolution")
        }
    }
    
    func broadcastViewModelDataReady(){
        
    }
}

