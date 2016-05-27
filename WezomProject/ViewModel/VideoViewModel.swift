//
//  VideoViewModel.swift
//  WezomProject
//
//  Created by Vitya on 5/23/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import AlamofireImage

protocol VideoViewModelDelegate {
    func videoViewModelDataReady()
}

class VideoViewModel: NSObject, VideoModelDelegate {
    
    var videoArray = [Video]()
    let videoModel = VideoModel()
    var videoViewModelDelegate: VideoViewModelDelegate?
    
    // constant for caching video
    let photoCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )
    
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
    
    func deleteBroadcastByID(id:String){
        videoModel.deleteBroadcastById(id)
    }
    
    func cacheImage(image: Image, urlString: String) {
        photoCache.addImage(image, withIdentifier: urlString)
    }
    
    func cachedImage(urlString: String) -> Image? {
        return photoCache.imageWithIdentifier(urlString)
    }
    
    func loadImageToView(imageView:UIImageView, url: NSURL){
        if let image = cachedImage(String(url)) {
            imageView.image = image
        } else {
            downloadImage(imageView, url: url)
        }
    }
    
    func downloadImage(imageView:UIImageView, url:NSURL){
        
        if let data = NSData(contentsOfURL: url){
            let image = UIImage(data: data)
            cacheImage(image!, urlString: String(url))
            imageView.image = image
        }
    }
    
    func setBroadcastInformation(title:String, startTime: String, endTime: String, description: String, status: String){
      videoModel.sendBroadcastInformation(title, startTime: startTime, endTime: endTime, description: description, status: status)
    }
    
}
