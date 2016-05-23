//
//  VideoViewController.swift
//  WezomProject
//
//  Created by Vitya on 5/17/16.
//  Copyright © 2016 Vitya. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class VideoViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,VideoModelDelegate, VideoViewModelDelegate {
    

    @IBOutlet weak var videoCollectionView: UICollectionView!
    var videos:[Video] = [Video]()
    var videoViewModel = VideoViewModel()
    var model:VideoModel = VideoModel()
    var selectedVideo:Video?
    
    // constant for caching video
    let photoCache = AutoPurgingImageCache(
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoViewModel.videoViewModelDelegate = self
        
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
        if let url = NSURL(string: videos[indexPath.row].videoThumbnailUrl) {
            loadImageToView(cell.videoImage, url: url)
        }
      
        
        // create delete Button for collection cell
        cell.deleteButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton?.addTarget(self, action: "deleteVideo:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //take note of which video the user selected
        self.selectedVideo = self.videos[indexPath.row]
        
        //call the seque
        self.performSegueWithIdentifier("goToStreamView", sender: self)
    }
    
    // VideoModel Delegate methods
    func videoDataReady() {
        //access the video object
//        self.videos = self.model.videoArray
//        self.videoCollectionView.reloadData()
    }
    
    func videoViewModelDataReady() {
        self.videos = videoViewModel.videoArray
        self.videoCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //get a reference to the destination view controller
        let streamViewController = segue.destinationViewController as! StreamViewController
        
        //set the selected video property of the destination view controller
        streamViewController.selectedVideo = self.selectedVideo
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
    
    //delete video from Collection View and from YouTube
    func deleteVideo(sender:UIButton) {
        let i : Int = (sender.layer.valueForKey("index")) as! Int
        
        //delete video from youtube
        model.deleteBroadcastById(videos[i].videoId)
        
        //delete video from Collection View
        videos.removeAtIndex(i)
        
        self.videoCollectionView.reloadData()
    }
    

    
}
