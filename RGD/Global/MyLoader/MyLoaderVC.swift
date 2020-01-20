//
//  MyLoaderVC.swift
//  GreenSport
//
//  Created by SapratigsMACMini on 05/12/19.
//  Copyright © 2019 SapratigsMACMini. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftGifOrigin
import AVFoundation

class MyLoaderVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: -
    
    @IBOutlet weak var vwBG: MyView!
    @IBOutlet weak var imgVW: UIImageView!
    @IBOutlet weak var btnDismis: MyButton!

    
    var completionHandler : ((Any)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.setGIF()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setGIF() {
        
        let animatedImage = UIImage.gif(name: "TempGif2")
        //        let imageView = UIImageView(...)
        self.imgVW.animationImages = animatedImage?.images
        self.imgVW.animationDuration = (animatedImage?.duration)!*0.8// / 1.5
        self.imgVW.startAnimating()
        print(self.imgVW.animationDuration)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+self.imgVW.animationDuration+0.2) {
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    @IBAction func btnTapped(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.completionHandler?("")
        }
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
