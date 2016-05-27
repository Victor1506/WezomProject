//
//  PersistentBroadcastModel.swift
//  WezomProject
//
//  Created by Vitya on 5/27/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol PBModelDelegate {
    func persBroadDataReady()
}

class PersistentBroadcastModel: NSObject {
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"
    let BROADCAST_VIDEO_URL = "https://www.googleapis.com/youtube/v3/liveBroadcasts"
    let STREAM_VIDEO_URL = "https://www.googleapis.com/youtube/v3/liveStreams"
    
    var persBroadModelDelegate:PBModelDelegate?
    
    var persistentBroadcastID = ""
    var persistentBroadcastTitle = ""
    var persistentBroadcastDescription = ""
    var persistentBroadcastBoundStreamId = ""
    var boundStreamLastUpdateTimeMs = ""
    var persistentStreamID = ""
    var persistentStreamTitle = ""
    var persistentStreamDescription = ""
    var persistentStreamKEY = ""
    var persistentStreamIngestionAddress = ""
    var persistentStreamBackupIngestionAddress = ""
    var persistentStreamResolution = ""
    var persistentStreamFrameRate = ""
    

    func getPersistentBroadcast(){
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, BROADCAST_VIDEO_URL, parameters: ["part" : "snippet, contentDetails", "key":API_KEY,"broadcastType":"persistent","mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
                let persBroabcast = JSON["items"] as! NSArray
                
                //parse json
                self.persistentBroadcastID = persBroabcast[0].valueForKeyPath("id") as? String ?? "0"
                self.persistentBroadcastTitle = persBroabcast[0].valueForKeyPath("snippet.title") as! String
                self.persistentBroadcastBoundStreamId = persBroabcast[0].valueForKeyPath("contentDetails.boundStreamId") as! String
                self.boundStreamLastUpdateTimeMs = persBroabcast[0].valueForKeyPath("contentDetails.boundStreamLastUpdateTimeMs") as! String
                self.persistentBroadcastDescription = persBroabcast[0].valueForKeyPath("snippet.description") as! String
                
                self.getPersistentStream()
            }
        }
    }
    
    func getPersistentStream() {
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, STREAM_VIDEO_URL, parameters: ["part" : "snippet, cdn", "key":API_KEY,"id":persistentBroadcastBoundStreamId], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                print(JSON)
                
                let persStream = JSON["items"] as! NSArray
                
                self.persistentStreamID = persStream[0].valueForKeyPath("id") as? String ?? "0"
                self.persistentStreamTitle = persStream[0].valueForKeyPath("snippet.title") as! String
                self.persistentStreamDescription = persStream[0].valueForKeyPath("snippet.description") as! String
                self.persistentStreamKEY = persStream[0].valueForKeyPath("cdn.ingestionInfo.streamName") as! String
                self.persistentStreamIngestionAddress = persStream[0].valueForKeyPath("cdn.ingestionInfo.ingestionAddress") as! String
                self.persistentStreamBackupIngestionAddress = persStream[0].valueForKeyPath("cdn.ingestionInfo.backupIngestionAddress") as! String
                self.persistentStreamResolution = persStream[0].valueForKeyPath("cdn.resolution") as! String
                self.persistentStreamFrameRate = persStream[0].valueForKeyPath("cdn.frameRate") as! String

                //Notify the delegate that the data is ready
                if self.persBroadModelDelegate != nil {
                    self.persBroadModelDelegate!.persBroadDataReady()
                }
            }
        }
    }
    
}
