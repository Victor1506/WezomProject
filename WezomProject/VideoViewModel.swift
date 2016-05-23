//
//  VideoViewModel.swift
//  WezomProject
//
//  Created by Vitya on 5/23/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

protocol VideoViewModelDelegate {
    func videoViewModelDataReady()
}

class VideoViewModel: NSObject, VideoModelDelegate {
    
    var videoId:String = ""
    var videoTitle:String = ""
    var videoDescription:String = ""
    var videoThumbnailUrl: String = ""
    var videoArray = [Video]()
    
    let videoModel = VideoModel()
    var videoViewModelDelegate: VideoViewModelDelegate?
    
    override init() {
        super.init()

        //set delegate
        self.videoModel.delegate = self
        //get information about broadcasts
        self.videoModel.getBroadcustVideoList()
    }
    
    func videoDataReady() {
        self.videoArray = self.videoModel.videoArray
        print("array count \(videoArray.count)")
        if self.videoViewModelDelegate != nil {
            self.videoViewModelDelegate!.videoViewModelDataReady()
        }
    }
    
    func refresh(){
        videoModel.getBroadcustVideoList()
    }
    
}
