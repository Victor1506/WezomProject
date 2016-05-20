//
//  InsertBroadcastsViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/19/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class InsertBroadcastsViewController: UIViewController {

    @IBOutlet weak var videoStatusTextField: UITextField!
    @IBOutlet weak var videoTitleTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var videoDescriptionTextView: UITextView!
    var model:VideoModel = VideoModel()
    let datePickerView:UIDatePicker = UIDatePicker()
    var whotTextField = ""
    let startTimer = "startTimer"
    let endTimer = "endTimer"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTimeTextEdit(sender: UITextField) {
        showDatePicker(sender)
        whotTextField = startTimer
    }
    
    @IBAction func endTimeTextEdit(sender: UITextField) {
        showDatePicker(sender)
        whotTextField = endTimer
    }
    
    @IBAction func okButton(sender: UIButton) {
        
        if videoStatusTextField.text == "" || videoTitleTextField.text == "" || startTimeTextField.text == "" || endTimeTextField.text == "" {
            createAlert("error", message: "Fill in all fields")
        } else{
            if videoStatusTextField.text == "public" || videoStatusTextField.text == "private" || videoStatusTextField.text == "unlisted" {
        model.setBroadcastsInformation(videoTitleTextField.text!, startTime: startTimeTextField.text!, endTime: endTimeTextField.text!, description: videoDescriptionTextView.text, status: videoStatusTextField.text!)
        createAlert("message", message: "broadcast wos added")
            } else {
                createAlert("error", message: "Valid values for status are: public, private, unlisted")
            }
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.locale = NSLocale(localeIdentifier: "el_GR")
//        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "el_GR")
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        
        switch whotTextField {
        case startTimer:
            startTimeTextField.text = dateFormatter.stringFromDate(sender.date)
        case endTimer:
             endTimeTextField.text = dateFormatter.stringFromDate(sender.date)
        default:
           print("nothing set")
        }
        
    }

    func showDatePicker(sender: UITextField){
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func createAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
//    func getDateFormattedISO8601(strDate: String) -> String{
//        let dateFormatter = NSDateFormatter()
//        let date = dateFormatter.dateFromString(strDate)
//        dateFormatter.locale = NSLocale(localeIdentifier: "el_GR")
//        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
//        return dateFormatter.stringFromDate(date!)
//    }


}
