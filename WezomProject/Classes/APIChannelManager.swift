//
//  Network.swift
//  WezomProject
//
//  Created by Vitya on 5/11/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol APIChannelDataDelegate {
    func channelDataReady(jsonArray: NSArray)
}

class APIChannelManager: NSObject {
    
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    let CHANNEL_URL = "https://www.googleapis.com/youtube/v3/channels"

    var channelDataDelegate:APIChannelDataDelegate?
    
    
    func getInformationAboutChannel(){
        
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, CHANNEL_URL, parameters: ["part" : "snippet,brandingSettings", "key":API_KEY,"mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
                let channel = JSON["items"] as! NSArray
                
                //Notify the delegate that the data is ready
                if self.channelDataDelegate != nil {
                    self.channelDataDelegate!.channelDataReady(channel)
                }
                
            } else if response.result.isFailure {
                print(response.result.error)
            }
        }
        
    }
    
    
}