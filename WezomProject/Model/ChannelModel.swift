//
//  ChannelModel.swift
//  WezomProject
//
//  Created by Vitya on 5/20/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import Alamofire

protocol ChannelModelDelegate {
    func channelDataReady()
}

class ChannelModel: NSObject {
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    var channelDelegate:ChannelModelDelegate?
    
    var channelId = ""
    var channelTitle = ""
    var channelDescription = ""
    var channelImageUrl = ""
    var channelBannerUrl = ""
    var channelPublishedAt = ""
    
    func getInformationAboutChannel(){
        
        let URL = "https://www.googleapis.com/youtube/v3/channels"
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, URL, parameters: ["part" : "snippet,brandingSettings", "key":API_KEY,"mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {

                 let channel = JSON["items"] as! NSArray
                
                
                self.channelId = channel[0].valueForKeyPath("id") as! String
                self.channelTitle = channel[0].valueForKeyPath("snippet.title") as! String
                self.channelDescription = channel[0].valueForKeyPath("snippet.description") as! String
                self.channelImageUrl = channel[0].valueForKeyPath("snippet.thumbnails.medium.url") as! String
                self.channelBannerUrl = channel[0].valueForKeyPath("brandingSettings.image.bannerImageUrl") as! String
                self.channelPublishedAt = channel[0].valueForKeyPath("snippet.publishedAt") as! String
            
              
                //Notify the delegate that the data is ready
                if self.channelDelegate != nil {
                    self.channelDelegate!.channelDataReady()
                }
            }
        }
        
    }
}


