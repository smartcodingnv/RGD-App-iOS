//
//  UILable+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/4/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit

class MyLable: UILabel {
    
    @IBInspectable var lableColor : Int = 0 {
        didSet{
            switch lableColor {
            case 0:
                break
                
            case 1:
                self.lblTextColor(color: colors.ColorTheamGreen1_02652E)
                break
            case 2:
                self.lblTextColor(color: colors.ColorTheamGreen2_76C043)
                break
            case 3:
                self.lblTextColor(color: colors.ColorTheamGreen3_B9DB9B)
                break
               
            case 11:
                self.lblTextColor(color: colors.ColorTheamWhit1_FFFFFF)
                break
                
            case 21:
                self.lblTextColor(color: colors.ColorBlack_000000)
                break
                
            case 22:
                self.lblTextColor(color: colors.ColorDarkGray_767676)
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
                self.lblTextFont(strFont: self.font.fontName)
                break
                
            case 1:
                self.lblTextFont(strFont: fonts.FagoNoBoldFont)
                break
                
            case 2:
                self.lblTextFont(strFont: fonts.FagoNoMediumFont)
                break
                
            case 3:
                self.lblTextFont(strFont: fonts.FagoNoRegularFont)
                break
                
            default:
                break
            }
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var lableFontSize : Int = 0 {
        didSet{
            
        }
    }
    
    // ------------------------------------------------------
    
    @IBInspectable var lableFontSizeAspect : Bool = false {
        didSet{
            /*
            if lableFontSizeAspect == false {
                self.lblTextFontSize(size: self.font.pointSize)
            }else{
                self.lblTextFontSize(size: CGFloat(lableFontSize)*kscaleFactor)
            }
            */
            if lableFontSizeAspect == true {
                self.lblTextFontSize(size: CGFloat(lableFontSize)*kscaleFactor)
            }
        }
    }
}


// ------------------------------------------------------

// MARK: - === Extention : MyLable ===

extension MyLable {
    
    func lblTextColor(color : UIColor) {
        self.textColor = color
    }
    
    // ------------------------------------------------------
    
    func lblTextFont(strFont : String) {
        self.font = UIFont(name: strFont, size: self.font.pointSize)
    }
    
    // ------------------------------------------------------
    
    func lblTextFontSize(size: CGFloat) {
        self.font = UIFont(name: self.font.fontName, size: size)
    }
    
}

extension UILabel {
    
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
