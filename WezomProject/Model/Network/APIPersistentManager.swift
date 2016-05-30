//
//  APIVideoManager.swift
//  WezomProject
//
//  Created by Vitya on 5/29/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol APIPersistentDataDelegate {
    func persistentBroadcastReady(jsonArray: NSArray)
    func persistentStreamReady(jsonArray: NSArray)
}

class APIPersistentManager: NSObject {
    
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    let BROADCAST_VIDEO_URL = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
    let STREAM_VIDEO_URL = "https://www.googleapis.com/youtube/v3/liveStreams"
    let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
    
    var videoDataDelegat: APIPersistentDataDelegate?

    func getPersistentBroadcast(){
    
        Alamofire.request(.GET, BROADCAST_VIDEO_URL, parameters: ["part" : "snippet, contentDetails", "key":API_KEY,"broadcastType":"persistent","mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
                let persBroabcast = JSON["items"] as! NSArray
                
                //Notify the delegate that the data is ready
                if self.videoDataDelegat != nil {
                    self.videoDataDelegat!.persistentBroadcastReady(persBroabcast)
                }

            }
        }
    }
    
    func getPersistentStream(persistentBroadcastBoundStreamId: String) {
        
        Alamofire.request(.GET, STREAM_VIDEO_URL, parameters: ["part" : "snippet, cdn", "key":API_KEY,"id":persistentBroadcastBoundStreamId], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                print(JSON)
                
                let persStream = JSON["items"] as! NSArray
                
                //Notify the delegate that the data is ready
                if self.videoDataDelegat != nil {
                    self.videoDataDelegat!.persistentStreamReady(persStream)
                }
            }
        }
    }
    
}
