//
//  ViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/11/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var SignInButton: GIDSignInButton!
    var videos:[Video] = [Video]()
    var model:VideoModel = VideoModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendYoutubeScopes()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
      //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
        
        print("sing in presented")
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        print("sign in dismessed")
    }
    
    func appendYoutubeScopes(){
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/youtube")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/youtube.upload")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/youtube.force-ssl")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/youtube.readonly")
    }
    
}

