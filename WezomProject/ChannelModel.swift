//
//  ChannelModel.swift
//  WezomProject
//
//  Created by Vitya on 5/20/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import Alamofire

class ChannelModel: NSObject {
    let API_KEY = "AIzaSyDrQbrbBvukMlZVVnL_nFIBYM7h9_dy3Ig"

    func getInformationAboutChannel(){
        
        let URL = "https://www.googleapis.com/youtube/v3/channels"
        let headers = ["Authorization": "Bearer \(GIDSignIn.sharedInstance().currentUser.authentication.accessToken)"]
        
        Alamofire.request(.GET, URL, parameters: ["part" : "brandingSettings", "key":API_KEY,"mine":"true"], encoding: ParameterEncoding.URL, headers: headers).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value {
                
            }
        }
        
    }
    
}
