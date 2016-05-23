//
//  Channel.swift
//  WezomProject
//
//  Created by Vitya on 5/20/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

protocol ChannelViewModelDelegate {
    func channelViewModelDataReady()
}

class ChannelViewModel: NSObject, ChannelModelDelegate {
   
    let channelModel = ChannelModel()
    var channelViewModelDelegate: ChannelViewModelDelegate?
    
    var channelId: String = ""
    var channelTitle:String = ""
    var channelDescription:String = ""
    var channelImageUrl: String = ""
    var channelBannerUrl: String = ""
    var channelPublishedAt:String = ""
    
    override init() {
        super.init()
        
        self.channelModel.channelDelegate = self
        
        //geting information about channel
        self.channelModel.getInformationAboutChannel()
    }
    
    func channelDataReady() {
        
        //set information from model
        channelId = channelModel.channelId
        channelTitle = channelModel.channelTitle
        channelDescription = channelModel.channelDescription
        channelImageUrl = channelModel.channelImageUrl
        channelBannerUrl = channelModel.channelBannerUrl
        channelPublishedAt = channelModel.channelPublishedAt
        
        //Notify the delegate that the data is ready
        if self.channelViewModelDelegate != nil {
            self.channelViewModelDelegate!.channelViewModelDataReady()
        }
    }
    
    func downloadImageBannerToView(imageView: UIImageView){
        let bannerUrl = NSURL(string: channelBannerUrl)
        if let bannerData = NSData(contentsOfURL: bannerUrl!){
            imageView.image = UIImage(data: bannerData)
            print("channel banner url - \(channelBannerUrl)")
        }
    }
}
