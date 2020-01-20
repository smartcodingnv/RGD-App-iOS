//
//  UIColor+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/12/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit


let colors = BasicColors()

struct BasicColors {

    let ColorTheamGreen1_02652E      =   MyColor(rgb: 0x02652E, alpha: 1.0)
    let ColorTheamGreen2_76C043      =   MyColor(rgb: 0x76C043, alpha: 1.0)
    let ColorTheamGreen3_B9DB9B      =   MyColor(rgb: 0xB9DB9B, alpha: 1.0)
    
    let ColorTheamWhit1_FFFFFF      =   MyColor(rgb: 0xFFFFFF, alpha: 1.0)
    
    let ColorBlack_000000           =   MyColor(rgb: 0x000000, alpha: 1.0)
    let ColorDarkGray_767676        =   MyColor(rgb: 0x767676, alpha: 1.0)
    
}

class MyColor: UIColor {
    static let kBlack = MyColor(rgb: 0xFFFFFF, alpha: 1.0)
    static let kPurple = MyColor(rgb: 0xFF11CB, alpha: 1.0)
    
    
}

// ------------------------------------------------------

// MARK: - === Extention : MyColor ===

extension MyColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}


