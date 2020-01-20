//
//  AppConstants.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/22/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Constants
let kScreenWidth                            : CGFloat       =                   UIScreen.main.bounds.size.width
let kScreenHeight                           : CGFloat       =                   UIScreen.main.bounds.size.height
let kscaleFactor                                            =                   (kScreenWidth / 375.0)
let kscaleFactor320                                         =                   (kScreenWidth / 320.0)

//MARK:- StoryBoards

let kMainBoard : UIStoryboard   = UIStoryboard(name: "Main", bundle: nil)

var selectedIndexOfPage : Int = 0

//------------------------------------------------------

//MARK:- ---------- AppDelegate Constants ----------

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

//------------------------------------------------------

//MARK:- ---------- UserDefault Constants ----------

let USERDEFAULTS                = UserDefaults.standard
let kIsLoggedIn                 =   "isUserLogin"
let kUserType                   =   "kUserType"
let kUserRegisterd              =   "kUserRegisterd"
let kUserGuest                  =   "kUserGuest"
let kCurrentLanguage            =   "selectedLanguage"
let kstrEN                      =   "en"
let kstrNL                      =   "nl"
let kAPIBaseURL                 =   "http://rgd.myteamspace.org/api"
//"http://192.168.0.104:8080/RGDWebAdmin/api"


//let kApiKey = "APIKEY"
//let kApiKeyValue = "NDP_APP_KEY0123456"


let kCode = "api_status"
let kData = "data"

let kLanguageArr = "kLanguageArr"
let kSelectedLanguage = "kSelectedLanguage"

let kCountryArr = "kCountryArr"
let kSelectedCountry = "kSelectedCountry"

let kCurrencieArr = "kCurrencieArr"
let kSelectedCurrencie = "kSelectedCurrencie"




//API_KEY =>NDP_APP_KEY0123456

func MyCurerntlanguageMessage() -> String {
    if USERDEFAULTS.value(forKey: kCurrentLanguage) as? String == kstrEN {
        return "message"
    }else {
        return "messageDu"//message_du"
    }
}

let kMessage = MyCurerntlanguageMessage()
