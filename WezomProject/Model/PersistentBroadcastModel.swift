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

class PersistentBroadcastModel: NSObject, APIPersistentDataDelegate {
    
    var persBroadModelDelegate:PBModelDelegate?
    var apiVideoManager = APIPersistentManager()
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kPersistentBroadcastID: String = "id"
    internal let kPersistentBroadcastTitle: String = "snippet.title"
    internal let kPersistentBroadcastDescription: String = "snippet.description"
    internal let kPersistentBroadcastBoundStreamId: String = "contentDetails.boundStreamId"
    internal let kBoundStreamLastUpdateTimeMs: String = "contentDetails.boundStreamLastUpdateTimeMs"
    internal let kPersistentStreamID: String = "id"
    internal let kPersistentStreamTitle: String = "snippet.title"
    internal let kPersistentStreamDescription: String = "snippet.description"
    internal let kPersistentStreamKEY: String = "cdn.ingestionInfo.streamName"
    internal let kPersistentStreamIngestionAddress: String = "cdn.ingestionInfo.ingestionAddress"
    internal let kPersistentStreamBackupIngestionAddress: String = "cdn.ingestionInfo.backupIngestionAddress"
    internal let kPersistentStreamResolution: String = "cdn.resolution"
    internal let kPersistentStreamFrameRate: String = "cdn.frameRate"
    
    // MARK: Properties
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
    
    override init() {
        super.init()
        
        self.apiVideoManager.videoDataDelegat = self
        
        self.apiVideoManager.getPersistentBroadcast()
    }
    
    func persistentBroadcastReady(jsonArray: NSArray) {
        //parse json
        self.persistentBroadcastID = jsonArray[0].valueForKeyPath(kPersistentBroadcastID) as? String ?? "0"
        self.persistentBroadcastTitle = jsonArray[0].valueForKeyPath(kPersistentBroadcastTitle) as! String
        self.persistentBroadcastDescription = jsonArray[0].valueForKeyPath(kPersistentBroadcastDescription) as! String
        self.persistentBroadcastBoundStreamId = jsonArray[0].valueForKeyPath(kPersistentBroadcastBoundStreamId) as! String
        self.boundStreamLastUpdateTimeMs = jsonArray[0].valueForKeyPath(kBoundStreamLastUpdateTimeMs) as! String
        self.apiVideoManager.getPersistentStream(persistentBroadcastBoundStreamId)
    }
    
    func persistentStreamReady(jsonArray: NSArray) {

        //parse json
        self.persistentStreamID = jsonArray[0].valueForKeyPath(kPersistentStreamID) as? String ?? "0"
        self.persistentStreamTitle = jsonArray[0].valueForKeyPath(kPersistentStreamTitle) as! String
        self.persistentStreamDescription = jsonArray[0].valueForKeyPath(kPersistentStreamDescription) as! String
        self.persistentStreamKEY = jsonArray[0].valueForKeyPath(kPersistentStreamKEY) as! String
        self.persistentStreamIngestionAddress = jsonArray[0].valueForKeyPath(kPersistentStreamIngestionAddress) as! String
        self.persistentStreamBackupIngestionAddress = jsonArray[0].valueForKeyPath(kPersistentStreamBackupIngestionAddress) as! String
        self.persistentStreamResolution = jsonArray[0].valueForKeyPath(kPersistentStreamResolution) as! String
        self.persistentStreamFrameRate = jsonArray[0].valueForKeyPath(kPersistentStreamFrameRate) as! String
        
        //Notify the delegate that the data is ready
        if self.persBroadModelDelegate != nil {
            self.persBroadModelDelegate!.persBroadDataReady()
        }
    }
}
