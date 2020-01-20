//
//  UIView+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/12/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit



class MyView: UIView {
    
    
    // ------------------------------------------------------
    
    // MARK: - Awake From Nib
    
    
    override func awakeFromNib() {
        if circleRound == true {
            DispatchQueue.main.async {
                
                self.layer.cornerRadius = self.layer.frame.height / 2
                self.layer.masksToBounds = true
//                    self.cornerRadius > 0
                self.clipsToBounds = true
            }
        }else {
            
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Circle Round
    
    @IBInspectable var circleRound: Bool = false {
        didSet {
            if circleRound == true {
                layer.cornerRadius = layer.frame.height / 2
                layer.masksToBounds = true
//                    cornerRadius > 0//self.frame.height > 0
                self.clipsToBounds = true
            }
        }
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Corner Radius
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            self.clipsToBounds = true
        }
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Border Color
    
    
    @IBInspectable var borderColor: Int = 0 {
        didSet {
            
            switch borderColor {
            case 0:
                //                UIColor.clear
                self.viewBorderColor(UIColor.clear)
                break
                
            case 1:
                self.viewBorderColor(colors.ColorTheamGreen1_02652E)
                break
            case 2 :
                self.viewBorderColor(colors.ColorTheamGreen2_76C043)
                break
            case 3:
                self.viewBorderColor(colors.ColorTheamGreen3_B9DB9B)
                break
                
            case 11:
                self.viewBorderColor(colors.ColorTheamWhit1_FFFFFF)
                break
                
            case 21:
                self.viewBorderColor(colors.ColorBlack_000000)
                break
                
            case 22:
                self.viewBorderColor(colors.ColorDarkGray_767676)
                break
                
            default:
                break
            }
            
            
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Border Width
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.viewBorderWidth(borderWidth)
        }
    }
    

    
    // ------------------------------------------------------
    
    // MARK: - BackGround Color
    
    
    @IBInspectable var bgColor: Int = 0 {
        didSet {
            
            switch bgColor {
            case 0:
                //                UIColor.clear
                break
                
            case 1:
                self.backgroundColor = colors.ColorTheamGreen1_02652E
                break
            case 2 :
                self.backgroundColor = colors.ColorTheamGreen2_76C043
                break
            case 3 :
                self.backgroundColor = colors.ColorTheamGreen3_B9DB9B
                break
                
            case 11:
                self.backgroundColor = colors.ColorTheamWhit1_FFFFFF
                break
                
            case 21:
                self.backgroundColor = colors.ColorBlack_000000
                break
            case 22:
                self.backgroundColor = colors.ColorDarkGray_767676
                break
            
            default:
                break
            }
        }
    }
    
    // ------------------------------------------------------
    
    
    @IBInspectable var shadowColor : Int = 0 {
        didSet{
            if enableShadow != true{
                return
            }
            switch shadowColor {
            case 0:
                //                UIColor.clear
                break
                
            case 1:
                self.viewShadowColor(colors.ColorTheamGreen1_02652E)
                break
            case 2 :
                self.viewShadowColor(colors.ColorTheamGreen2_76C043)
                break
            case 3 :
                self.viewShadowColor(colors.ColorTheamGreen3_B9DB9B)
                break
                
            case 11:
                self.viewShadowColor(colors.ColorTheamWhit1_FFFFFF)
                break
                
            case 21:
                self.viewShadowColor(colors.ColorBlack_000000)
                break
            case 22:
                self.viewShadowColor(colors.ColorDarkGray_767676)
                break
                
            default:
                break
            }
        }
    }
    
    // ------------------------------------------------------
    
    
    @IBInspectable var shadowOffSet : CGSize = CGSize(width: 0, height: 0) {
        didSet{
            if enableShadow == true{
                self.viewShadowOffSet(shadowOffSet)
            }
        }
    }
    
    // ------------------------------------------------------
    
    
    @IBInspectable var shadowRadius : CGFloat = 0 {
        didSet{
            if enableShadow == true{
                
                self.viewShadowRadius(shadowRadius)
                
            }
        }
    }
    
    // ------------------------------------------------------
    
    
    @IBInspectable var shadowOpacity : Float = 0 {
        didSet{
            if enableShadow == true{
                
                self.viewShadowOpacity(shadowOpacity)
            }
        }
    }
    
    
    // ------------------------------------------------------
    
    
    @IBInspectable var enableShadow : Bool = false{
        didSet{
            if enableShadow == true{
                self.giveShadow(color: MyColor.black, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 5, scale: true)
            }
        }
    }
}



// ------------------------------------------------------

// MARK: - === Extention : MyView ===

extension MyView {
    
    
    //------------------------------------------------------
    
    //MARK:- ---------- Apply Corner Radius And Order Method ----------
    
    func ApplyCornerRadiusAndBorderToView(_ cornerRadius : CGFloat? , borderColor : UIColor?, borderWidth : CGFloat?) {
        
        self.layer.cornerRadius = cornerRadius!
        self.layer.borderColor = borderColor!.cgColor
        self.layer.borderWidth = borderWidth!
        
    }
    
    //------------------------------------------------------
    
    //MARK:- ---------- Apply Sadow Method ----------
    
    func ApplyShadowToView(_ shadowOffset : CGSize? , shadowColor : UIColor?, shadowOpacity : Float? , shadowRadius : CGFloat?)
    {
        
        self.layer.shadowOffset = shadowOffset!
        self.layer.shadowColor = shadowColor!.cgColor
        self.layer.shadowOpacity = shadowOpacity!
        self.layer.shadowRadius = shadowRadius!
        
        
        //        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        /*
         outerView.clipsToBounds = false
         outerView.layer.shadowColor = UIColor.black.cgColor
         outerView.layer.shadowOpacity = 1
         outerView.layer.shadowOffset = CGSize.zero
         outerView.layer.shadowRadius = 10
         outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
         
         */
        
    }
    
    
    
    func dropShadow(color: UIColor = UIColor.black , offset : CGSize = CGSize(width: -1, height: 1)) {
        
        // shadow
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset//CGSize(width: -1, height: 1)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 3.0
        
    }
    
    func removeShadow()
    {
        self.layer.shadowOpacity = 0.0
    }
    
    func viewCornerRadius(_ cornerRadius : CGFloat?) {
        self.layer.cornerRadius = cornerRadius!
    }
    
    // ------------------------------------------------------
    
    func viewBorderColor(_ borderColor : UIColor?) {
        self.layer.borderColor = borderColor!.cgColor
    }
    
    // ------------------------------------------------------
    
    func viewBorderWidth(_ borderWidth : CGFloat?) {
        self.layer.borderWidth = borderWidth!
    }
    
    // ------------------------------------------------------
    
    func viewShadowOffSet(_ shadowOffset : CGSize?) {
        self.layer.shadowOffset = shadowOffset!//CGSize(width: 0, height: 0)
    }
    
    // ------------------------------------------------------
    
    func viewShadowColor(_ shadowColor : UIColor?) {
        self.layer.shadowColor = shadowColor!.cgColor//colors.ColorTheamBlack3_707070.cgColor
    }
    
    // ------------------------------------------------------
    
    func viewShadowOpacity(_ shadowOpacity : Float?) {
        self.layer.shadowOpacity = shadowOpacity!//5
    }
    
    // ------------------------------------------------------
    
    func viewShadowRadius(_ shadowRadius : CGFloat?) {
        self.layer.shadowRadius = shadowRadius!//5
    }
    
    
    /*
     // OUTPUT 1
     func giveShadow(scale: Bool = true) {
     layer.masksToBounds = false
     layer.shadowColor = MyColor.red.cgColor
     layer.shadowOpacity = 0.5
     layer.shadowOffset = CGSize(width: -1, height: 1)
     layer.shadowRadius = 1
     
     layer.shadowPath = UIBezierPath(rect: bounds).cgPath
     layer.shouldRasterize = true
     layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
     */
    
    // OUTPUT 2
    func giveShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        //        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        //        layer.shouldRasterize = true
        //        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
}



// ------------------------------------------------------

// MARK: - === Extention :  ===

extension UIView {
    //------------------------------------------------------
    
    //MARK:- ---------- Set Currunt First Responder Method ----------
    
    
    func curruntFirstResponder() -> UIResponder? {
        
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder  = view.curruntFirstResponder() {
                return responder
            }
        }
        return nil;
    }
}





