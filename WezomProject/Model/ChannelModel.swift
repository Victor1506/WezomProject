//
//  ChannelModel.swift
//  WezomProject
//
//  Created by Vitya on 5/20/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import Alamofire

protocol ChannelModelDelegate {
    func channelDataReady()
}

class ChannelModel: NSObject, ChannelDataDelegate {
    
    var channelDelegate:ChannelModelDelegate?
    var network = Network()
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kChannelId: String = "id"
    internal let kChannelTitle: String = "snippet.title"
    internal let kChannelDescription: String = "snippet.description"
    internal let kChannelImageUrl: String = "snippet.thumbnails.medium.url"
    internal let kChannelBannerUrl: String = "brandingSettings.image.bannerImageUrl"
    internal let kChannelPublishedAt: String = "snippet.publishedAt"
    
    // MARK: Properties
    var channelId = ""
    var channelTitle = ""
    var channelDescription = ""
    var channelImageUrl = ""
    var channelBannerUrl = ""
    var channelPublishedAt = ""
    
    override init() {
        super.init()
        
        self.network.channelDataDelegate = self
        
        //MARK: Send a request to retrieve data
        network.getInformationAboutChannel()
    }
    
    //MARK: parse json when data ready
    func channelDataReady(jsonAray: NSArray) {
        self.channelId = jsonAray[0].valueForKeyPath(kChannelId) as? String ?? "0"
        self.channelTitle = jsonAray[0].valueForKeyPath(kChannelTitle) as! String
        self.channelDescription = jsonAray[0].valueForKeyPath(kChannelDescription) as! String
        self.channelImageUrl = jsonAray[0].valueForKeyPath(kChannelImageUrl) as! String
        self.channelBannerUrl = jsonAray[0].valueForKeyPath(kChannelBannerUrl) as! String
        self.channelPublishedAt = jsonAray[0].valueForKeyPath(kChannelPublishedAt) as! String
        
        print("data ready \(channelTitle)")
        if self.channelDelegate != nil {
            self.channelDelegate!.channelDataReady()
        }
    }
}


