//
//  UIFont+Extention.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/12/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit

/*
HelveticaNeue-Bold
HelveticaNeue-Medium
HelveticaNeue
HelveticaNeue-Light
*/
let fonts = BasicFonts()

struct BasicFonts {
    
//    FagoNo ["", "FagoNo", ""]

    let FagoNoBoldFont                    =   "FagoNo-Bold"
    let FagoNoMediumFont                  =   "FagoNo-Medium"
    let FagoNoRegularFont                 =   "FagoNo"
    
    
    
    /*
     Open Sans ["OpenSans-Bold", "OpenSans-Light", "OpenSans-Semibold", "OpenSans"]
    */
    
}

// ------------------------------------------------------

// MARK: - === Extention : UIFont ===

extension UIFont {
    
    //------------------------------------------------------
    
    //MARK:- ----------  Apply Extra Bold Font Method ----------

    class func applyBoldFont(fontSize : CGFloat) -> UIFont{
        return UIFont.init(name: fonts.FagoNoBoldFont, size: fontSize)!
    }
    
    //------------------------------------------------------
    
    //MARK:- ----------  Apply Semi Bold Font Method ----------
    
    class func applySemiBoldFont(fontSize : CGFloat) -> UIFont{
        return UIFont.init(name: fonts.FagoNoMediumFont, size: fontSize)!
    }
    
    //------------------------------------------------------
    
    //MARK:- ----------  Apply Extra Regular Font Method ----------
    
    class func applyRegularFont(fontSize : CGFloat) -> UIFont{
        return UIFont.init(name: fonts.FagoNoRegularFont, size: fontSize)!
    }
    
    
    
}


