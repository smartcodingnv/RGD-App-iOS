//
//  UIButton+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/12/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import  UIKit

class MyButtonData: NSObject {
    var id = ""
    var title = ""
    var type = ""
}

class MyButton: UIButton {
    
    var objData = MyButtonData()
    
    @IBInspectable var btnTextColor : Int = 0 {
        didSet{
            switch btnTextColor {
            case 0:
                print("Default Color")
                break
            case 1:
                self.btnTextColor(color: colors.ColorTheamGreen1_02652E)
                break
            case 2:
                self.btnTextColor(color: colors.ColorTheamGreen2_76C043)
                break
            case 3:
                self.btnTextColor(color: colors.ColorTheamGreen3_B9DB9B)
                break
            
            case 11:
                self.btnTextColor(color: colors.ColorTheamWhit1_FFFFFF)
                break
                
            case 21:
                self.btnTextColor(color: colors.ColorBlack_000000)
                break
            case 22:
                self.btnTextColor(color: colors.ColorDarkGray_767676)
                break
                
            default:
                break
            }
        }
    }
    // ------------------------------------------------------
    
    
    @IBInspectable var lableFont : Int = 0 {
        didSet{
            switch lableFont {
            case 0:
                
                self.btnTextFont(strFont: (self.titleLabel?.font.fontName)!)
                break
                
            case 1:
                self.btnTextFont(strFont: fonts.FagoNoBoldFont)
                break
                
            case 2:
                self.btnTextFont(strFont: fonts.FagoNoMediumFont)
                break
                
            case 3:
                self.btnTextFont(strFont: fonts.FagoNoRegularFont)
                break
                            
            default:
                break
            }
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var btnFontSize : Int = 0 {
        didSet{
            
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var btnFontSizeAspect : Bool = false {
        didSet{
            /*
            if btnFontSizeAspect == false {
                self.btnTextFontSize(size: (self.titleLabel?.font.pointSize)!)//self.font.pointSize)
            }else{
                self.btnTextFontSize(size: CGFloat(btnFontSize)*kscaleFactor)
            }
            */
            if btnFontSizeAspect == true {
              self.btnTextFontSize(size: CGFloat(btnFontSize)*kscaleFactor)
            }
        }
    }
}



// ------------------------------------------------------

// MARK: - === Extention : MyButton ===

extension MyButton {
    
    func btnTextColor(color : UIColor) {
//        self.textColor = color
//        self.titleLabel?.textColor = color
        
        self.setTitleColor(color, for: self.state)
    }
    
    // ------------------------------------------------------
    
    func btnTextFont(strFont : String) {
        self.titleLabel?.font = UIFont(name: strFont, size: (self.titleLabel?.font.pointSize)!)
    }
    
    // ------------------------------------------------------
    
    func btnTextFontSize(size : CGFloat) {
        self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size:size)
    }
    
    
    
}
extension UIButton {
    open override func awakeFromNib() {
        self.adjustsImageWhenHighlighted = false
        self.isExclusiveTouch = true
        
    }
}


