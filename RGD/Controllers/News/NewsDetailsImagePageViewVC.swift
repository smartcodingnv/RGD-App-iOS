//
//  NewsDetailsImagePageViewVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 03/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import YouTubePlayer

class NewsDetailsImagePageViewVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!

    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
//    var objImage : ClassVacationMyDataGalleryMedia!
    var objImage : ClassNewsListMedia!
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        
        DispatchQueue.main.async {
            self.imgBG.setIMageWithURL(strURL: self.objImage.imageName!, contentType: .scaleAspectFill)
            if self.objImage.imgType == "V" {
                self.videoPlayer.loadVideoID(self.objImage.videoName.youtubeID!)
                self.videoPlayer.delegate = self
                self.videoPlayer.isHidden = false
                //            self.setUpData()
            }
            else {
                self.videoPlayer.isHidden = true
                self.imgBG.addTap(flag: true)
            }
        }
        
    }
    
    // ------------------------------------------------------
    
    func setUpData() {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    @IBAction func btnTapped(_ sender: UIButton) {
    }
    
    // ------------------------------------------------------
    
    // MARK: - Delegate
    
    // ------------------------------------------------------
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // ------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // ------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // ------------------------------------------------------
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // ------------------------------------------------------
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
extension NewsDetailsImagePageViewVC : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print(videoPlayer)
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(videoPlayer)
        print(playerState)
        if playerState == .Unstarted {
            let myVideoURL = URL(string: self.objImage.imageName)!
            UIApplication.shared.open(myVideoURL, options: [:]) { (flag) in
                self.videoPlayer.loadVideoID(self.objImage.videoName.youtubeID!)
            }
        }
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        print(videoPlayer)
        print(playbackQuality)
    }
}
