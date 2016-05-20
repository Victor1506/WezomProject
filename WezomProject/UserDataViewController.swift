//
//  UserDataViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/12/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController, GIDSignInUIDelegate{

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    var videoViewController: VideoViewController!
    var videos:[Video] = [Video]()
    var model:VideoModel = VideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        //set user data
        setUserData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.videoViewController.model.getBroadcustVideoList()
    }
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        signOut()
    }
    
    @IBAction func refreshButton(sender: AnyObject) {
        
        //Fire off request to get videos
        self.videoViewController.model.getBroadcustVideoList()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let reference = segue.destinationViewController as? VideoViewController
            where segue.identifier == "goToVideoView" {
            
            self.videoViewController = reference
        }
    }
    
    func setUserData(){
        userEmailLabel.text = GIDSignIn.sharedInstance().currentUser.profile.email
        userNameLabel.text = GIDSignIn.sharedInstance().currentUser.profile.name
        
        if let url = GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(100) {
            if let data = NSData(contentsOfURL: url) {
                userImageView.image = UIImage(data: data)
            }        
        }
    }
       
    func showAlertMessage(){
        let alert = UIAlertController(title: "error", message: "You need to enable live streaming in your YouTube profile", preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.signOut()
        }
        
        // Add the actions
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func signOut(){
        GIDSignIn.sharedInstance().signOut()
        
        let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        let signInPageNav = UINavigationController(rootViewController: signInPage)
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = signInPageNav
    }

}
