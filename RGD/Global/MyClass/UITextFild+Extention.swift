//
//  UITextFild+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/12/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit


class MyTextFild: UITextField {
    @IBInspectable var placeHolderType: Int = 0{
        didSet{
            var strPlaceHolder = ""
            if self.placeholder == nil {
                strPlaceHolder = ""
            }else{
                strPlaceHolder = self.placeholder!
            }
            self.setPlaceHolder(strPlaceHolder, fontName: fonts.FagoNoRegularFont, fontSize: 15*kscaleFactor, color: colors.ColorDarkGray_767676)
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var textColorType: Int = 0 {
        didSet{
            
            switch textColorType {
            case 0:
                //                UIColor.clear
                break
                
            case 1:
                self.setTextColor(color: colors.ColorTheamGreen1_02652E)
                break
            case 2:
                self.setTextColor(color: colors.ColorTheamGreen2_76C043)
                break
            case 3:
                self.setTextColor(color: colors.ColorTheamGreen3_B9DB9B)
                break
                
            case 11:
                self.setTextColor(color: colors.ColorTheamWhit1_FFFFFF)
                break
                
            case 21:
                self.setTextColor(color: colors.ColorBlack_000000)
                break
                
            case 22:
                self.setTextColor(color: colors.ColorDarkGray_767676)
                break
                
             
            default:
                break
            }
            
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var textFont : Int = 0 {
        didSet{
            switch textFont {
            case 0:
                self.txtTextFont(strFont: (self.font?.fontName)!)
                break
                
            case 1:
                self.txtTextFont(strFont: fonts.FagoNoBoldFont)
                break
                
            case 2:
                self.txtTextFont(strFont: fonts.FagoNoMediumFont)
                break
                
            case 3:
                self.txtTextFont(strFont: fonts.FagoNoRegularFont)
                break
                
            default:
                break
            }
        }
    }
    
    
    // ------------------------------------------------------
    
    @IBInspectable var textFontSize : Int = 0 {
        didSet{
            
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var textFontSizeAspect : Bool = false {
        didSet{
            if textFontSizeAspect == false {
                
                self.txtFontSize(size: (self.font?.pointSize)!)
            }else{
                self.txtFontSize(size: CGFloat(textFontSize)*kscaleFactor)
            }
        }
    }
    
}

// ------------------------------------------------------

// MARK: - === Extention : MyTextFild ===

extension MyTextFild {
    
    func setPlaceHolder(_ strPlaceHolder : String, fontName : String, fontSize : CGFloat, color : UIColor) {
        
        let attributDir : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont(name: fontName, size: fontSize)!, NSAttributedString.Key.foregroundColor : color]
        
        let attrStr : NSAttributedString = NSAttributedString(string: strPlaceHolder, attributes: attributDir as [NSAttributedString.Key : Any])
        self.attributedPlaceholder = attrStr
 
    }
    
    // ------------------------------------------------------
    
    func setTextColor(color : UIColor) {
        self.textColor = color
    }
    
    // ------------------------------------------------------
    
    func txtTextFont(strFont : String) {
        self.font = UIFont(name: strFont, size: (self.font?.pointSize)!)
    }
    
    // ------------------------------------------------------
    
    func txtFontSize(size: CGFloat) {
        self.font = UIFont(name: (self.font?.fontName)!, size: size)
    }
    
    // ------------------------------------------------------
    
    
}

