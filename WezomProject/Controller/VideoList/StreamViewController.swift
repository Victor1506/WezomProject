//
//  StreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/13/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController {

    @IBOutlet weak var videoTitleTextView: UITextView!
    @IBOutlet weak var videoDescriptionTextView: UITextView!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoWebView: UIWebView!
   
    var selectedVideo:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
//  self.videoWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
//        videoWebView.autoresizingMask =
    }

    override func viewDidAppear(animated: Bool) {
        if let vid = self.selectedVideo {
            
            self.videoTitleTextView.text = vid.videoTitle
            self.videoDescriptionTextView.text = vid.videoDescription
            
            let width = self.view.frame.size.width
            let height = width/320*180
            self.webViewHeightConstraint.constant = height
            
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(height) + "\" width=\"" + String(width) + "\" src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            self.videoWebView.loadHTMLString(videoEmbedString, baseURL: nil)
        }
    }

}
