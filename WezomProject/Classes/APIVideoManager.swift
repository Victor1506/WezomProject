//
//  APIVideoManager.swift
//  WezomProject
//
//  Created by Vitya on 5/29/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol APIVideoDataDelegate {
    func videoDataReady(jsonArray: AnyObject)
}

class APIVideoManager: NSObject {

    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    let BROADCAST_VIDEO_URL = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
    
    var videoDataDelegate:APIVideoDataDelegate?
    
    func getBroadcustVideoList(){
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, BROADCAST_VIDEO_URL, parameters: ["part" : "snippet", "key":API_KEY,"mine":"true","maxResults":"50"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
                //Notify the delegate that the data is ready
                if self.videoDataDelegate != nil {
                    self.videoDataDelegate!.videoDataReady(JSON)
                }
                
            }
        }
    }
    
    func deleteBroadcastById(id: String){
        
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.DELETE, BROADCAST_VIDEO_URL, parameters: ["id" : id, "key":API_KEY], encoding: ParameterEncoding.URL, headers: headers)
    }
    
    func sendBroadcastInformation(title: String, startTime: String, endTime: String, description: String, status: String){
        let URL = "https://www.googleapis.com/youtube/v3/liveBroadcasts?part=status%2C+snippet&key=\(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        let dictionarySnippet :Dictionary<String, AnyObject>  = [
            "title": title,
            "scheduledEndTime": endTime,
            "scheduledStartTime": startTime,
            "description" : description
        ]
        
        let dictionaryStatus :Dictionary<String,AnyObject> = [
            "privacyStatus": status
        ]
        
        let dictionaryParameters :Dictionary<String, AnyObject> = [
            "snippet" : dictionarySnippet,
            "status" : dictionaryStatus,
            // "contentDetails" : dictionaryContentDetails
        ]
        
        Alamofire.request(.POST, URL, parameters: dictionaryParameters, encoding: .JSON, headers: headers
            ).responseJSON{ (response) -> Void in
                
                if let JSON = response.result.value {
                    
                    print(JSON)
                    
                }
        }
        
    }
}
