//
//  UIImage+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 1/12/19.
//  Copyright © 2019 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit
import SimpleImageViewer
import AlamofireImage

extension UIImageView {

    func addTap(flag : Bool) {
        if flag == true {
            self.addTapGestureRecognizer(action: zoomImage)
        }
    }
    
    func zoomImage(){
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self
        }
        let imageViewerController = ImageViewerController(configuration: configuration)
        
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(imageViewerController, animated: true, completion: nil)
        
    }
    
}
extension UIImageView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    //Functions for image picker
    
    
    
    //-----------------------------------------------------------------------------------
    
    
}

extension UIImageView
{
    func makeBlurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func setIMageWithURL(strURL : String, contentType : UIImageView.ContentMode = .scaleToFill) {
        self.image = UIImage(named: "IMGBGLogo")
        self.contentMode = .scaleAspectFill
        if let url = URL(string: strURL) {
            self.af_setImage(withURL: url)
            self.contentMode = contentType
        }
    }
    
    func setProfileImageWithURL(strURL : String) {
        self.image = UIImage(named: "IMGBGLogo")
        self.contentMode = .scaleAspectFit
        if let url = URL(string: strURL) {
            self.af_setImage(withURL: url)
            self.contentMode = .scaleAspectFill
        }
        //        self.af_setImage(withURL: URL(string: strURL)!)
    }
    
}

class MyLogoImage: UIImageView {
    open override func awakeFromNib() {
        self.clipsToBounds = true
        self.image = UIImage()
    }
}
