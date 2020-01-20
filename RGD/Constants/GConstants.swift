//
//  GConstants.swift
//  NDP
//
//  Created by SapratigsMAC1 on 10/3/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON

typealias JSONResponse = [String: Any]
//typealias JSONResponse = [String: Any]


class GFunction : NSObject {
    
    static let sharedMethods : GFunction = GFunction()
    var progressHud : MBProgressHUD = MBProgressHUD()
    
    var arrNotificationCall = [JSONResponse]()
    var arrNotificationLocal = [JSONResponse]()
    var unReadCount = 0
    
    
    func MyCurerntlanguageMessage() -> String {
        if USERDEFAULTS.value(forKey: kCurrentLanguage) as? String == kstrEN {
            return "message"
        }else {
            return "messageDu"//message_du"
        }
    }
//    var activityLoader = ActivityData(size: CGSize(width: 80, height: 80)
//        , messageFont: UIFont(name: fonts.helveticaNeueMediumFont, size: 13.0*kscaleFactor)
//        , type: NVActivityIndicatorType.ballTrianglePath //ballSpinFadeLoader
//        , color: colors.ColorTheamPurple1_FF11CB
//        , textColor: UIColor.white)
//
//    var indicatorView   : UIActivityIndicatorView = UIActivityIndicatorView()
    
    // ------------------------------------------------------
    
    // MARK: - Set Attributed string
    
    func setAttrributedString(_ str : String, font : UIFont, textColor : UIColor) -> NSMutableAttributedString {
        
        var attriStr = NSMutableAttributedString()
        attriStr = NSMutableAttributedString(string:str, attributes: [NSAttributedString.Key.font:font, NSAttributedString.Key.foregroundColor : textColor])
        
        return attriStr
    }
    
    // ------------------------------------------------------
    
    // MARK: - Nevigate User
    
    func navigateUser() {
   
        if USERDEFAULTS.value(forKey: kIsLoggedIn)  == nil{
            self.navigateToLoginScreen()
        }else{
            self.navigateToHomeScreen()
//            APPDELEGATE.createMenuView()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Check User Login Status
    
    func checkUserLogin() -> Bool {
        
        if USERDEFAULTS.value(forKey: kIsLoggedIn)  == nil{
            return false
        } else {
            return true
        }
    }
    
    func checkUserType() -> String {
        if let userType =  USERDEFAULTS.value(forKey: kUserType) as? String {
            return userType
        }
        return ""
    }

    //------------------------------------------------------
    
    //MARK: Navigate To Login Screen
    
    func navigateToLoginScreen () {
        /*
        let navigationController : UINavigationController = kAuthStoryBoard.instantiateViewController(withIdentifier: "NavLoginID") as! UINavigationController
        APPDELEGATE.window?.rootViewController = navigationController
        APPDELEGATE.window?.makeKeyAndVisible()
        */
    }
    
    //------------------------------------------------------
    
    //MARK: Navigate To Home Screen
    
    func navigateToHomeScreen () {
        /*
        let navigationController : UINavigationController = kHomeBoard.instantiateViewController(withIdentifier: "NavIDHome") as! UINavigationController
        APPDELEGATE.window?.rootViewController = navigationController
        APPDELEGATE.window?.makeKeyAndVisible()
        */
    }
//
    
    //------------------------------------------------------
    
    //MARK: Force LogOut
    
    func forceLogOut() {
        
        USERDEFAULTS.removeObject(forKey: kIsLoggedIn)
        USERDEFAULTS.removeObject(forKey: kUserType)
        
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            if key != kIsFirstTime {
//                UserDefaults.standard.removeObject(forKey: key.description)
//            }
//
//        }
//        USERDEFAULTS.set(deviceTokenStrig, forKey: kDeviceToken)
//
        USERDEFAULTS.synchronize()
        GFunction.sharedMethods.navigateToLoginScreen()
        
    }
    
    
    class func getToken() -> String {
        
        var strToken = ""
        if GFunction.sharedMethods.checkUserLogin() {
            //            if let userType =  USERDEFAULTS.value(forKey: kUserType) as? String {
            let userType = GFunction.sharedMethods.checkUserType()
            if userType == kUserGuest {
                strToken = ""
            }
            else {
//                let userData = USERDEFAULTS.value(forKey: "ClassUserLoginData") as! JSONResponse
//                let userJson : JSON = JSON(userData)
//                let classUserData = ClassUserLoginData(fromJson: userJson)
//                strToken = classUserData.token
            }
            //            }
        }
        
        if strToken == "" {
            return strToken
        }
        else {
        }
        return "Bearer \(strToken)"
    }
    
    //MARK:- Valid Email
    
    class func isValidEmail(text : String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }
    
    //--------------------------------------------------------------------------
    
    //MARK:- Valid Number
    class func isValidNumber(_ txt: String)-> Bool {
        
        let RegEx   = "[0-9]+"
        let eTest   = NSPredicate(format:"SELF MATCHES %@", RegEx)
        let result  = eTest.evaluate(with: txt)
        return result;
    }
    
    
    
    // ------------------------------------------------------
    
    // MARK: - Get Price
    
    class func getPrice(arrFloat : [Float], place : Int = 2) -> String {
        
        var floatPrice : Float!
        
        if arrFloat.count > 0 {
            floatPrice = 1
        }
        else {
            return ""
        }
        
        for item in arrFloat {
            floatPrice = floatPrice * item
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = place
        let totalAmount = floatPrice
        let nsNumberTottal = NSNumber(value: totalAmount ?? 0)
        let strTotal = formatter.string(from: nsNumberTottal)
        
        return strTotal!.replacingOccurrences(of: ",", with: "")
        
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Get ID From TimeStemp
    
    class func getIDFromTimeStemp() -> Int {
        // using current date and time as an example
        let someDate = Date()
        // convert Date to TimeInterval (typealias for Double)
        let timeInterval = someDate.timeIntervalSince1970
        // convert to Integer
        let myInt = Int(timeInterval)
        
        return myInt
    }
    /*
    // ------------------------------------------------------
    
    // MARK: - Get Cart Count
    
    class func getProuctCartCount(tempObjCart : ClassCart) -> Int {
     
        let arrTemp = APPDELEGATE.arrCart.filter { (objCart) -> Bool in
            if objCart.product.id == tempObjCart.product.id {
                if objCart.selectedVariant.id == tempObjCart.selectedVariant.id {
                    if objCart.selectedQuality.id == tempObjCart.selectedQuality.id {
                        if objCart.selectedQuanity == tempObjCart.selectedQuanity {
                            return true
                        }
                    }
                }
            }
            return false
        }
        print(arrTemp)
        
        
        
        if arrTemp.count > 0 {
            return (arrTemp.first?.totalItem)!
        }
        return 0
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Add Product In Cart
    
    class func addProductToCart(tempObjCart : ClassCart) {
        let arrTemp = APPDELEGATE.arrCart.filter { (objCart) -> Bool in
            if objCart.product.id == tempObjCart.product.id {
                if objCart.selectedVariant.id == tempObjCart.selectedVariant.id {
                    if objCart.selectedQuality.id == tempObjCart.selectedQuality.id {
                        if objCart.selectedQuanity == tempObjCart.selectedQuanity {
                            return true
                        }
                    }
                }
            }
            return false
        }
        print(arrTemp)
        if arrTemp.count > 0 {
            let tempCart = arrTemp[0]
//            tempCart.totalItem = tempCart.totalItem + 1
            APPDELEGATE.arrCart = APPDELEGATE.arrCart.map({ (objCart) -> ClassCart in
                
                if objCart.id == tempCart.id {
                    objCart.totalItem = objCart.totalItem + 1
                }
                
                return objCart
                
            })
        }
        else {
            
            let objCart = tempObjCart
            objCart.id = self.getIDFromTimeStemp()
            objCart.totalItem = 1
            
            APPDELEGATE.arrCart.append(objCart)
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Remove Product From Cart
    
    class func removeProductFromCart(tempObjCart : ClassCart) {
        let arrTemp = APPDELEGATE.arrCart.filter { (objCart) -> Bool in
            if objCart.product.id == tempObjCart.product.id {
                if objCart.selectedVariant.id == tempObjCart.selectedVariant.id {
                    if objCart.selectedQuality.id == tempObjCart.selectedQuality.id {
                        if objCart.selectedQuanity == tempObjCart.selectedQuanity {
                            return true
                        }
                    }
                }
            }
            return false
        }
        print(arrTemp)
        
        if arrTemp.count > 0 {
            let tempCart = arrTemp[0]
//            tempCart.totalItem = tempCart.totalItem + 1
            APPDELEGATE.arrCart = APPDELEGATE.arrCart.map({ (objCart) -> ClassCart in
                if objCart.id == tempCart.id {
                    objCart.totalItem = objCart.totalItem - 1
                }
                return objCart
                
            })
        }
        
        APPDELEGATE.arrCart = APPDELEGATE.arrCart.filter({ (item) -> Bool in
            if item.totalItem <= 0 {
                return false
            }
            return true
        })
    }
    */
    
    //-----------------------------------------------------------------------------------------------
    
    //MARK:- Show Alert
    
    class func myLoadderAdd() {
        /*
        print("++++++ Add")
        let modalViewController = kHomeBoard.instantiateViewController(withIdentifier: "GifWithAnimationPopUpVC") as! GifWithAnimationPopUpVC
        modalViewController.completionHandler = {
            objSelected in
        }
        modalViewController.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.definesPresentationContext = true
        UIApplication.topViewController()?.providesPresentationContextTransitionStyle = true
//        self.definesPresentationContext = true
//        self.providesPresentationContextTransitionStyle = true
        APPDELEGATE.window?.rootViewController?.present(modalViewController, animated: false, completion: nil)
        
        */
        
        
        /*
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(APPDELEGATE.MyLoaderViewController, animated: true, completion: nil)
        */

    }
    
    class func myLoaderRemove() {
        /*
//        DispatchQueue.main.async {
            print("++++++ remove")
            if (UIApplication.topViewController()?.isKind(of: GifWithAnimationPopUpVC.self))! {
                UIApplication.topViewController()?.dismiss(animated: false, completion: nil)
            }
//        }
        */
        
//        APPDELEGATE.MyLoaderViewController.dismiss(animated: true, completion: nil)
    }
    
    class func ShowAlert(message : String , view : UIViewController? = APPDELEGATE.window!.rootViewController!) {
        
        
        
        let alert = UIAlertController(title: nil, message: message /*.Localized()*/, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK"/*ksbOK()*/, style: .default, handler: nil))
        
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    //------------------------------------------------------
    
    class func showAlert(_ title : String = "" ,
                         actionOkTitle : String = "OK"/*ksbOK()*/ ,
                         actionCancelTitle : String = "" ,
                         message : String,
                         completion: ((Bool) -> ())? ) {
        
        let alert : UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let actionOk : UIAlertAction = UIAlertAction(title: actionOkTitle, style: .default) { (action) in
            if completion != nil {
                completion!(true)
            }
        }
        alert.addAction(actionOk)
        
        if actionCancelTitle != "" {
            
            let actionCancel : UIAlertAction = UIAlertAction(title: actionCancelTitle, style: .cancel) { (action) in
                if completion != nil {
                    completion!(false)
                }
            }
            
            alert.addAction(actionCancel)
        }
        
        //        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    //------------------------------------------------------
    
    //MARK:- Add Loader
    
    func addloader(view : UIView = APPDELEGATE.window!) {
        /*
        GFunction.myLoaderRemove()
        GFunction.myLoadderAdd()
        */
        
        self.removeLoader()
        //                progressHud = MBProgressHUD(view: view)
        //                progressHud.labelText = labelText
        //                view.addSubview(progressHud)
        //                progressHud.show(true)
        
        
        progressHud = MBProgressHUD(view: view)
        APPDELEGATE.window?.addSubview(progressHud)
        //        view.addSubview(progressHud)
        progressHud.show(animated: true)
        
        
    }
    //------------------------------------------------------
    
    //MARK: Remove Loader
    
    func removeLoader() {
        /*
        GFunction.myLoaderRemove()
        */
        
        progressHud.hide(animated: true)
        progressHud.show(animated: false)
        progressHud.removeFromSuperview()
        
    }
    
    class func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let strDate = formatter.string(from: date)
        return strDate
    }
    
    // ------------------------------------------------------
    
    // MARK: - Change Date Format
    
    //-----------------------------------------------------------------------------------------------
    
    //MARK:- Change Date Format
    
    class func changeDateFormat(strDate : String, strCurrentDateFormat : String, strNewDateFormat : String) -> String {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = strCurrentDateFormat
        let date1 = dateFormater.date(from: strDate)
        dateFormater.dateFormat = strNewDateFormat
        let strDate1 = dateFormater.string(from: date1!)
        
        return strDate1
    }
    
    
    //------------------------------------------------------
    
    //MARK: Sort Array By Date
    
    class func sortArrayid(tempArr : [JSONResponse], strKey : String)->[JSONResponse]{
        
        var arr2 = [JSONResponse]()
        
        arr2 = tempArr.sorted(by: { (temp1, temp2) -> Bool in
            
            let id1 = temp1[strKey] as! String
            let id2 = temp2[strKey] as! String
            
            let t1 = Int(id1)
            let t2 = Int(id2)
            
            return (t1)! > (t2)!
        })
        return arr2
    }
    /*
    func manageFirebaseUserToken(strFirebaseToken : String) {
        
        if USERDEFAULTS.value(forKey: kIsLoggedIn)  == nil{
            return
        }
        
        if deviceTokenStrig == "0" {
            
            self.updateFirebaseTokenApi(strFirebaseToken: "0")
        }
        else {
            self.updateFirebaseTokenApi(strFirebaseToken: strFirebaseToken)
        }
        
    }
    */
    func updateFirebaseTokenApi(strFirebaseToken : String) {
        return
        /*
         ===========API CALL===========
         
         Method Name : updatefirebasekey
         
         Parameter   :
         {
         "device_type":"I",//"A"
         "firebase_key":"0" // firebase_key
         }
         
         Optional    :
         
         
         Comment     : This api is used to Register.
         
         
         ==============================
         */
        
        var headersT = Alamofire.SessionManager.defaultHTTPHeaders
        headersT["Content-Type"] = "application/json"
        let userData = USERDEFAULTS.value(forKey: "ClassUserLoginDetails") as! JSONResponse
        headersT["Authorization"] = GFunction.getToken()
//        "Bearer \(userData["token"] as! String)"
        
        
        var params = [String:String]()
        params["device_type"] = "I"
        params["firebase_key"] = strFirebaseToken
        //        GFunction.sharedMethods.addloader()
        // api/forgotpassword
        //        email : ""
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/api/updatefirebasekey", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            //            GFunction.sharedMethods.removeLoader()
            //            print(resPonse)
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
//                            if response[kCode] as? Int == 1 {
//
//                                //                                self.navigationController?.popViewController(animated: true)
//                                GFunction.ShowAlert(message: response["message"] as! String)
//
//                            }else {
//                                GFunction.ShowAlert(message: response["message"] as! String)
//                            }
                            
                        } // Is Json Value
                    }
                    
                } // End error Nil
                else {
                    GFunction.ShowAlert(message: (resPonse?.error?.localizedDescription)!)
                }
            } // End ResPonse Nil
        }
    }
}

extension GFunction {
    
    // ------------------------------------------------------
    
    // MARK: - Locations, Currency, Language
    /*
    func getLocationsCurrencyLanguageApi() {
        
        /*
         ===========API CALL===========
         
         Method Name : locations
         
         Parameter   :
         {
         "lang_code": "en"
         }
         
         Optional    :
         
         
         Comment     : This api is used to Register.
         
         
         ==============================
         */
        
        var headersT = Alamofire.SessionManager.defaultHTTPHeaders
        headersT["Content-Type"] = "application/json"
        /*
        let userData = USERDEFAULTS.value(forKey: "ClassUserLoginDetails") as! JSONResponse
        headersT["Authorization"] = "Bearer \(userData["token"] as! String)"
        */
        //            userData["token"] as? String
        headersT["Authorization"] = GFunction.getToken()
        
        var params = [String:String]()
        params["lang_code"] = GFunction.sharedMethods.getSelectedLanguageID()
        //        GFunction.sharedMethods.addloader()
        // api/forgotpassword
        //        email : ""
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/locations", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            //            GFunction.sharedMethods.removeLoader()
            //            print(resPonse)
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? Int == 1 {
                                if let userData = response[kData] as? JSONResponse {
                                    if let languageArr = userData["languages"] as? [JSONResponse] {
                                        var arrTemp = [ClassLanguage]()
                                        for item in languageArr {
                                            let userJson : JSON = JSON(item)
                                            let dataT = ClassLanguage(fromJson: userJson)
                                            arrTemp.append(dataT)
                                        }
                                        var arrTemp2 = [JSONResponse]()
                                        for item in arrTemp {
                                            if item.languageCode == kstrEN ||
                                                item.languageCode == kstrNL {
                                                arrTemp2.append(item.toDictionary())
                                            }
                                        }
                                        USERDEFAULTS.set(arrTemp2, forKey: kLanguageArr)
                                    }
                                    if let countrieaArr = userData["countries"] as? [JSONResponse] {
                                        var arrTemp = [ClassCountrie]()
                                        for item in countrieaArr {
                                            let userJson : JSON = JSON(item)
                                            let dataT = ClassCountrie(fromJson: userJson)
                                            arrTemp.append(dataT)
                                        }
                                        var arrTemp2 = [JSONResponse]()
                                        for item in arrTemp {
                                            arrTemp2.append(item.toDictionary())
                                        }
                                        USERDEFAULTS.set(arrTemp2, forKey: kCountryArr)
                                    }
                                    if let currencieArr = userData["currencies"] as? [JSONResponse] {
                                        var arrTemp = [ClassCurrencie]()
                                        for item in currencieArr {
                                            let userJson : JSON = JSON(item)
                                            let dataT = ClassCurrencie(fromJson: userJson)
                                            arrTemp.append(dataT)
                                        }
                                        var arrTemp2 = [JSONResponse]()
                                        for item in arrTemp {
                                            arrTemp2.append(item.toDictionary())
                                        }
                                        USERDEFAULTS.set(arrTemp2, forKey: kCurrencieArr)
                                    }
                                    self.setUpDefualtLocationsCurrencyLanguage()
                                }
                            }
                        } // Is Json Value
                    }
                } // End error Nil
                else {
//                    GFunction.ShowAlert(message: (resPonse?.error?.localizedDescription)!)
                }
            } // End ResPonse Nil
        }
    }
    */
    // ------------------------------------------------------
    
    // MARK: - setUpDefualt Locations, Currency, Language
    
    func setUpDefualtLocationsCurrencyLanguage() {
        
        if USERDEFAULTS.value(forKey: kSelectedLanguage) as? JSONResponse == nil {
            if let arrTemp1 = USERDEFAULTS.value(forKey: kLanguageArr) as? [JSONResponse] {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedLanguage)
                }
            }
        }
        if USERDEFAULTS.value(forKey: kSelectedCountry) as? JSONResponse == nil {
            if let arrTemp1 = USERDEFAULTS.value(forKey: kCountryArr) as? [JSONResponse] {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedCountry)
                }
            }
        }
        if USERDEFAULTS.value(forKey: kSelectedCurrencie) as? JSONResponse == nil {
            if let arrTemp1 = USERDEFAULTS.value(forKey: kCurrencieArr) as? [JSONResponse] {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedCurrencie)
                }
            }
        }
        
    
        // ------------------------------------------------------
        
        if let arrTemp1 = USERDEFAULTS.value(forKey: kLanguageArr) as? [JSONResponse] {
            var flag = false
            if let obj = USERDEFAULTS.value(forKey: kSelectedLanguage) as? JSONResponse{
                for item in arrTemp1 {
                    if item["id"] as? Int == obj["id"] as? Int {
                        flag = true
                    }
                }
            }
            if flag == false {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedLanguage)
                }
            }
        }
        
        
        if let arrTemp1 = USERDEFAULTS.value(forKey: kCountryArr) as? [JSONResponse] {
            var flag = false
            if let obj = USERDEFAULTS.value(forKey: kSelectedCountry) as? JSONResponse{
                for item in arrTemp1 {
                    if item["id"] as? Int == obj["id"] as? Int {
                        flag = true
                    }
                }
            }
            if flag == false {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedCountry)
                }
            }
        }
        
        
        if let arrTemp1 = USERDEFAULTS.value(forKey: kCurrencieArr) as? [JSONResponse] {
            var flag = false
            if let obj = USERDEFAULTS.value(forKey: kSelectedCurrencie) as? JSONResponse{
                for item in arrTemp1 {
                    if item["id"] as? Int == obj["id"] as? Int {
                        flag = true
                    }
                }
            }
            if flag == false {
                if arrTemp1.count > 0 {
                    USERDEFAULTS.set(arrTemp1.first, forKey: kSelectedCurrencie)
                }
            }
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Get Country
    
    func getSelectedCountryID() -> String {
//        return ""
        if let obj = USERDEFAULTS.value(forKey: kSelectedCountry) as? JSONResponse{
            return obj["master_id"] as! String
        }
        return ""
    }
    
    func getSelectedCountryName() -> String {
//        return ""
        if let obj = USERDEFAULTS.value(forKey: kSelectedCountry) as? JSONResponse{
            return obj["name"] as! String
        }
        return ""
    }
    
    // ------------------------------------------------------
    
    // MARK: - Get Currencie
    
    func getSelectedCurrencieID() -> String {
        if let obj = USERDEFAULTS.value(forKey: kSelectedCurrencie) as? JSONResponse{
            return obj["master_id"] as! String
        }
        return ""
    }
    
    func getSelectedCurrencieName() -> String {
        if let obj = USERDEFAULTS.value(forKey: kSelectedCurrencie) as? JSONResponse{
            return obj["currency"] as! String
        }
        return ""
    }
    
   
    
    // ------------------------------------------------------
    
    // MARK: - Get Language
    
    func getSelectedLanguageID() -> String {
        if let obj = USERDEFAULTS.value(forKey: kSelectedLanguage) as? JSONResponse{
            return obj["language_code"] as! String
        }
        return ""
    }
    
    func getSelectedLanguageName() -> String {
        if let obj = USERDEFAULTS.value(forKey: kSelectedLanguage) as? JSONResponse{
            return obj["language_name"] as! String
        }
        return ""
    }
    
    

}
