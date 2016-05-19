//
//  InsertBroadcastsViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/19/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class InsertBroadcastsViewController: UIViewController {

    @IBOutlet weak var videoTitleTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var videoDescriptionTextView: UITextView!
    var model:VideoModel = VideoModel()
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
        model.setBroadcastsInformation(videoTitleTextField.text!, startTime: startTimeTextField.text!, endTime: endTimeTextField.text!, description: videoDescriptionTextView.text, status: "public")
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
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
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
