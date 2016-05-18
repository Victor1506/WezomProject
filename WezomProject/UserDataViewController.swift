//
//  UserDataViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/12/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class UserDataViewController: UIViewController, GIDSignInUIDelegate, VideoModelDelegate{

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    var videos:[Video] = [Video]()
    var model:VideoModel = VideoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.model.delegate = self
        
        //set user data
        setUserData()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // VideoModel Delegate methods
    func dataReady() {
        //access the video object
        self.videos = self.model.videoArray
        
    }
    
    @IBAction func signOutButtonTapped(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        
        let signInPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        let signInPageNav = UINavigationController(rootViewController: signInPage)
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = signInPageNav
        
    }

    @IBAction func getChannelInf(sender: AnyObject) {
        print("")
        print("")
        print("")
        print("")
        print("")
       // model.getInformationAboutChannel()
      model.setBroadcastsInformation()
    }
    
    func setUserData(){
        userEmailLabel.text = GIDSignIn.sharedInstance().currentUser.profile.email
        userNameLabel.text = GIDSignIn.sharedInstance().currentUser.profile.name
        let url = GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(100)
      //  let data = NSData(contentsOfURL: url!)
        print(url)
        //   titleUserImageView.image = UIImage(data: data!)
        
        if let url = GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(100) {
            if let data = NSData(contentsOfURL: url) {
                userImageView.image = UIImage(data: data)
            }        
        }
    }
    
    @IBAction func insertBroadcust(sender: AnyObject) {
       model.setBroadcastsInformation()
        //model.getInformationAboutChannel()
        
    }
      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
