//
//  VideoViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/17/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,VideoModelDelegate {
    

    @IBOutlet weak var videoCollectionView: UICollectionView!
   // var tableData: [String] = ["first","second","third"]
    var videos:[Video] = [Video]()
    var model:VideoModel = VideoModel()
    var selectedVideo:Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        
        //Fire off request to get videos
        model.getBroadcustVideoList()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: VodeoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! VodeoCollectionViewCell
        
        //add data in cell
        cell.backgroundColor = UIColor.whiteColor()
        cell.videoTitle.text = videos[indexPath.row].videoTitle
        cell.videoDescription.text = videos[indexPath.row].videoDescription
        
        
        //get and set image for imageView
        let url = NSURL(string: videos[indexPath.row].videoThumbnailUrl)
        if let data = NSData(contentsOfURL: url!) {
                cell.videoImage.image = UIImage(data: data)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //take note of which video the user selected
        self.selectedVideo = self.videos[indexPath.row]
        
        //call the seque
        self.performSegueWithIdentifier("goToStreamView", sender: self)
    }
    
    // VideoModel Delegate methods
    func dataReady() {
        //access the video object
        self.videos = self.model.videoArray
        
        self.videoCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get a reference to the destination view controller
        let streamViewController = segue.destinationViewController as! StreamViewController
        
        //set the selected video property of the destination view controller
        streamViewController.selectedVideo = self.selectedVideo
    }

}
