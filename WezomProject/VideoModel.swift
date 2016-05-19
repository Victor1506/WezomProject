//
//  VideoModel.swift
//  WezomProject
//
//  Created by Vitya on 5/12/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    let UPLOADS_PLAYLIST_ID = "PLMRqhzcHGw1aLoz4pM_Mg2TewmJcMg9ua"
    
    var videoArray = [Video]()
    
    var delegate:VideoModelDelegate?
    
    func getBroadcustVideoList(){
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        let broadcustVideoUrl = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
        Alamofire.request(.GET, broadcustVideoUrl, parameters: ["part" : "snippet", "key":API_KEY,"mine":"true","maxResults":"50"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                print(JSON)
                for video in JSON["items"] as! NSArray  {
                
                    //Create video object off the JSON response
                    let videoObj = Video()
                    videoObj.videoId = video.valueForKeyPath("id") as! String
                    videoObj.videoTitle = video.valueForKeyPath("snippet.title") as! String
                    videoObj.videoDescription = video.valueForKeyPath("snippet.description") as! String
                    videoObj.videoThumbnailUrl = video.valueForKeyPath("snippet.thumbnails.medium.url") as! String
                    self.videoArray.append(videoObj)

                }
                
                //Notify the delegate that the data is ready
                if self.delegate != nil {
                    self.delegate!.dataReady()
                }

            }
        }
    }
    
    func getInformationAboutChannel(){
        
        let URL = "https://www.googleapis.com/youtube/v3/channels"
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, URL, parameters: ["part" : "brandingSettings", "key":API_KEY,"mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
            }
        }
        
    }
    
    func setBroadcastsInformation(title: String, startTime: String, endTime: String, description: String, status: String){
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


