//
//  VideoModel.swift
//  WezomProject
//
//  Created by Vitya on 5/12/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol VideoModelDelegate {
    func videoDataReady()
}

class VideoModel: NSObject, APIVideoDataDelegate {
    
    var videoArray = [Video]()
    
    var videoModelDelegate:VideoModelDelegate?
    var apiVideoManager = APIVideoManager()
    
    override init() {
        super.init()
        
        self.apiVideoManager.videoDataDelegate = self
        
        //MARK: Send a request to retrieve data
        self.apiVideoManager.getBroadcustVideoList()
    }
    
    func videoDataReady(jsonArray: AnyObject) {
        self.videoArray.removeAll()
        
        for video in jsonArray["items"] as! NSArray  {
        
        //Create video object off the JSON response
        let videoObj = Video()
        videoObj.videoId = video.valueForKeyPath("id") as? String ?? "0"
        videoObj.videoTitle = video.valueForKeyPath("snippet.title") as! String
        videoObj.videoDescription = video.valueForKeyPath("snippet.description") as! String
        videoObj.videoThumbnailUrl = video.valueForKeyPath("snippet.thumbnails.medium.url") as! String
        self.videoArray.append(videoObj)
        }
        
        //Notify the delegate that the data is ready
        if self.videoModelDelegate != nil {
            self.videoModelDelegate!.videoDataReady()
        }
    }
    
}


