//
//  InsertBroadcastsViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/19/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class InsertBroadcastsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var videoStatusTextField: UITextField!
    @IBOutlet weak var videoTitleTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var videoDescriptionTextView: UITextView!
    
    var videoViewModel = VideoViewModel()
    let datePickerView = UIDatePicker()
    
    var statusPickerArr = ["public", "private", "unlisted"]
    let statusPickerView = UIPickerView()
    
    //check press on text field
    var whotTextFieldSet = ""
    let startTimer = "startTimer"
    let endTimer = "endTimer"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //add custom picker view 
        self.view.addSubview(statusPickerView)
        
        //create custom Picker View
        statusPickerView.hidden = true
        statusPickerView.delegate = self
        statusPickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTimeTextEdit(sender: UITextField) {
        showDatePicker(sender)
        whotTextFieldSet = startTimer
    }
    
    @IBAction func endTimeTextEdit(sender: UITextField) {
        showDatePicker(sender)
        whotTextFieldSet = endTimer
    }
    
    @IBAction func statusTextEdit(sender: AnyObject) {
        statusPickerView.hidden = false
    }

    @IBAction func okButton(sender: UIButton) {
        
        if videoStatusTextField.text == "" || videoTitleTextField.text == "" || startTimeTextField.text == "" || endTimeTextField.text == "" {
            createAlert("error", message: "Fill in all fields")
        } else{
            if videoStatusTextField.text == "public" || videoStatusTextField.text == "private" || videoStatusTextField.text == "unlisted" {
        videoViewModel.setBroadcastInformation(videoTitleTextField.text!, startTime: startTimeTextField.text!, endTime: endTimeTextField.text!, description: videoDescriptionTextView.text, status: videoStatusTextField.text!)
        createAlert("message", message: "broadcast wos added")
            } else {
                createAlert("error", message: "Valid values for status are: public, private, unlisted")
            }
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        //set format for datePicker
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "el_GR")
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        
        //check whot fiald is set
        switch whotTextFieldSet {
        case startTimer:
            startTimeTextField.text = dateFormatter.stringFromDate(sender.date)
            print(dateFormatter.stringFromDate(sender.date))
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
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        statusPickerView.hidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusPickerArr.count;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        videoStatusTextField.text = statusPickerArr[row]
        statusPickerView.hidden = true
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: statusPickerArr[row], attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
        return attributedString
    }


}
