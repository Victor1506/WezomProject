//
//  StreamViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/13/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController {

    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoWebView: UIWebView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    var selectedVideo:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let vid = self.selectedVideo {
            
            self.videoTitleLabel.text = vid.videoTitle
            self.videoDescriptionLabel.text = vid.videoDescription
            
            let width = self.view.frame.size.width
            let height = width/320*180
            self.webViewHeightConstraint.constant = height
            
            let videoEmbedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(height) + "\" width=\"" + String(width) + "\" src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            self.videoWebView.loadHTMLString(videoEmbedString, baseURL: nil)
        }
    }

}
