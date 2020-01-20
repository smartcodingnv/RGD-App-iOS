//
//  WSHelper.swift
//  NDP
//
//  Created by SapratigsMAC1 on 12/27/18.
//  Copyright © 2018 SapratigsMAC1. All rights reserved.
//

import Foundation
import Alamofire

class WSHelper: SessionManager {

    var indexStatusCode = IndexSet()

    init() {
        //FIXME: Add Default Header
        //FIXME: Add required status code
        indexStatusCode.insert(400)
        indexStatusCode.insert(400)
        indexStatusCode.insert(200)
        let configaration = URLSessionConfiguration.default
        super.init(configuration: configaration)
    }

    /// singleton instatnce of WSHelper
    static let sharedInstance: WSHelper = {
        let instance = WSHelper()
        // setup code



        return instance
    }()


    class func stopAllSessions() {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
    
    class func stopSessionRequest(url : String) {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach {
                if ($0.originalRequest?.url?.absoluteString == url) {
                    $0.cancel()
                }
            }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
        
    }
    

    /// send request with url
    ///
    /// - Parameters:
    ///   - isToCheckLogin: flag for login
    ///   - wsUrl: url
    ///   - method: httpmethod
    ///   - param: parameters
    ///   - header: httpheader
    ///   - wsResponce: closure for response
    class func sendRequestWithURL(wsUrl: String, method: HTTPMethod = .get, param: [String: Any]? = nil, header: HTTPHeaders? = nil,isDebug : Bool , wsResponce:((_ error:DataResponse<Any>?) -> ())?) {

        guard NetworkReachabilityManager()?.isReachable == true else {

            //GlobalUtility.showAlertControllerWith(title: "Failed", message: "U heeft geen internet connectie", cancelButtonTitle: "OK", submitButtonTitle: nil, destructiveButtonTitle: nil, preferredStyle: .alert, completion: nil)
            wsResponce?(nil)
            return
        }


//        let dfd = Sequence(
//        URLEncoding.methodDependent // Working good
//        JSONEncoding.default  //  Not Working

        do {
            let postData = try JSONSerialization.data(withJSONObject: param, options: [])

            // let postData = JSONSerialization.data(withJSONObject: parameters, options: [])

            var request = URLRequest(url: URL(string: wsUrl)!)
            request.httpMethod = HTTPMethod.post.rawValue

            for item in header! {
                request.setValue(item.value, forHTTPHeaderField: item.key)
            }
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = postData

            Alamofire.request(request).responseString(completionHandler: { (response) in
                    debugPrint("----------------------------------------Response String ----------------------------------------")
                    print(response)
                    debugPrint("----------------------------------------Response String ----------------------------------------")
                    //                print(response)
                })
                .responseJSON { (response) in

                    if isDebug {

                        debugPrint("----------------------------------------URL----------------------------------------")
                        print("URL:----\n\(String(describing: response.request?.description))")
                        debugPrint("----------------------------------------------------------------------------------------")

                        debugPrint("----------------------------------------Parameter----------------------------------------")
                        print("Parameter:---\n\(String(describing: param))")
                        debugPrint("----------------------------------------------------------------------------------------")

                        debugPrint("----------------------------------------Response----------------------------------------")
                        debugPrint("Response :-----\n",response)
                        debugPrint("----------------------------------------------------------------------------------------")
                    }

                    switch response.result {
                    case .success:

                        if let statusCode =  response.response?.statusCode , statusCode == 400 {
                            print("Logout User")

                            GFunction.sharedMethods.forceLogOut()
                            //                    completion!(nil,400,nil)
                            wsResponce?(response)
                        }
                        else{
                            var decResponse : [String: Any]?

                            if let decString = response.result.value as? JSONResponse {
                                decResponse = decString
                                //                        decString.decryptData().convertToDictionary()
                            }



                            if let res = decResponse {
                                wsResponce?(response)
                                //                        if completion != nil {
                                //                            completion!(res, response.response!.statusCode, nil)
                                //                        }
                            }
                            else {
                                wsResponce?(response)
                                //                        if completion != nil {
                                //                            completion!(nil, response.response!.statusCode, nil)
                                //                        }
                            }
                        }
                    ////
                    case .failure(let error):
                        print(error)
                        wsResponce?(response)
                        //                DispatchQueue.main.asyncAfter(deadline: time) {
                        //                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wsResponse"), object: nil)
                        //                }
                    }
            }
        } catch  {
            wsResponce?(nil)
            return
        }



    }
    /*
     if let JSON = response.result.value as? NSDictionary {
     //print("URL:----\n\(String(describing: response.request?.description))")
     //print("Parameter:---\n\(String(describing: param))")
     //print("response---\(JSON)")
     if let settings = JSON[ws_param.settings] as? NSDictionary {
     let successValue = "\(settings[ws_param.success]!)"
     if successValue == "-200" || successValue == "-400" || successValue == "-500"
     {

     }
     else if successValue == "-300" {

     }
     else if successValue == "-1000" {

     }
     else{
     wsResponce?(response)

     DispatchQueue.main.asyncAfter(deadline: time) {
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wsResponse"), object: nil)
     }

     }
     } else {
     wsResponce?(response)
     DispatchQueue.main.asyncAfter(deadline: time) {
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wsResponse"), object: nil)
     }

     }
     } else {
     wsResponce?(response)
     DispatchQueue.main.asyncAfter(deadline: time) {
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wsResponse"), object: nil)
     }

     }
     */

    func callMultiPartFormData(wsUrl: String, method: HTTPMethod = .get, param: [String: Any]? = nil, header: HTTPHeaders? = nil, wsResponce:((_ error:DataResponse<Any>?) -> ())?) {

        Alamofire.upload(multipartFormData:{ multipartFormData in
            multipartFormData.append(Data(), withName: "image", fileName: "sample.png", mimeType: "image/png")
            multipartFormData.append("2018-12-26".data(using: .utf8)!, withName: "today_date")},
                         usingThreshold:UInt64.init(),
                         to: wsUrl,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }


    // ------------------------------------------------------

    // MARK: - EditProfile

    func editProfileWithImage(wsUrl: String, method: HTTPMethod = .get, param: [String: Any]? = nil, header: HTTPHeaders? = nil, wsResponce:((_ error:DataResponse<Any>?) -> ())?) {
        print(wsUrl)
        self.session.configuration.timeoutIntervalForRequest = 30
        //        self.session.configuration.timeoutIntervalForResource = 10
        Alamofire.upload(multipartFormData:{ multipartFormData in

                for item in param! {
                    print("==============")
                    print(item)
                    print("==============")
                    if item.key == "profilepic" {
                        if param!["profilepic"] as? Data != nil {

                            //                            multipartFormData.append(param!["description"] as! Data, withName: "description")
                            //                            multipartFormData.append(param!["description"] as! Data, withName: "description", fileName: "file.jpg", mimeType: "image/jpg")//"image/*")
                            let nameOfFile = param!["name"] as? String
                            multipartFormData.append(param!["profilepic"] as! Data, withName: "profilepic", fileName: "file.jpg", mimeType: "image/jpg")//"image/*")
                        }
                    }
                    else {


                        multipartFormData.append((item.value as! String).data(using: .utf8)!, withName: item.key)
                    }

                }

        },
                         usingThreshold:UInt64.init(),
                         to: wsUrl,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)

                                    if let statusCode =  response.response?.statusCode , statusCode == 400 {
                                        print("Logout User")
                                        GFunction.sharedMethods.forceLogOut()
                                        //                    completion!(nil,400,nil)
                                        wsResponce?(response)
                                    }
                                    else{
                                        var decResponse : [String: Any]?

                                        if let decString = response.result.value as? JSONResponse {
                                            decResponse = decString
                                            //                        decString.decryptData().convertToDictionary()
                                        }



                                        if let res = decResponse {
                                            wsResponce?(response)
                                            //                        if completion != nil {
                                            //                            completion!(res, response.response!.statusCode, nil)
                                            //                        }
                                        }
                                        else {
                                            wsResponce?(response)
                                            //                        if completion != nil {
                                            //                            completion!(nil, response.response!.statusCode, nil)
                                            //                        }
                                        }
                                    }


                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }


    // ------------------------------------------------------

    // MARK: - Upload Media For Question

    func uploadMediaForQuestion(wsUrl: String, method: HTTPMethod = .get, param: [String: Any]? = nil, header: HTTPHeaders? = nil, wsResponce:((_ error:DataResponse<Any>?) -> ())?) {
        print(wsUrl)
        self.session.configuration.timeoutIntervalForRequest = 30
//        self.session.configuration.timeoutIntervalForResource = 10
        Alamofire.upload(multipartFormData:{ multipartFormData in

            if param!["description_type"] as? String == "1" {
                for item in param! {
                    print("==============")
                    print(item)
                    print("==============")
                    if item.key == "description" {
                        if param!["description"] as? Data != nil {

//                            multipartFormData.append(param!["description"] as! Data, withName: "description")
//                            multipartFormData.append(param!["description"] as! Data, withName: "description", fileName: "file.jpg", mimeType: "image/jpg")//"image/*")
                            let nameOfFile = param!["name"] as? String
                            multipartFormData.append(param!["description"] as! Data, withName: "description", fileName: "file.jpg", mimeType: "image/jpg")//"image/*")
                        }
                    }
                    else {


                        multipartFormData.append((item.value as! String).data(using: .utf8)!, withName: item.key)
                    }

                }
            }
            else if param!["description_type"] as? String == "2" {
                for item in param! {
                    print("==============")
                    print(item)
                    print("==============")
                    if item.key == "description" {
                        if param!["description"] as? Data != nil {
                            multipartFormData.append(param!["description"] as! Data, withName: item.key, fileName: "file.mp4", mimeType: "mp4")
                        }
                    }
                    else {
                        multipartFormData.append((item.value as! String).data(using: .utf8)!, withName: item.key)
                    }

                }
            }
            else if param!["description_type"] as? String == "3" {
                for item in param! {
                    print("==============")
                    print(item)
                    print("==============")
                    if item.key == "description" {
                        if param!["description"] as? Data != nil {
                            multipartFormData.append(param!["description"] as! Data, withName: item.key, fileName: "file.pdf", mimeType: "application/pdf")
                        }
                    }
                    else {
                        multipartFormData.append((item.value as! String).data(using: .utf8)!, withName: item.key)
                    }

                }
            }
        },
                         usingThreshold:UInt64.init(),
                         to: wsUrl,
                         method:.post,
                         headers:header,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)

                                    if let statusCode =  response.response?.statusCode , statusCode == 400 {
                                        print("Logout User")
                                        GFunction.sharedMethods.forceLogOut()
                                        //                    completion!(nil,400,nil)
                                        wsResponce?(response)
                                    }
                                    else{
                                        var decResponse : [String: Any]?

                                        if let decString = response.result.value as? JSONResponse {
                                            decResponse = decString
                                            //                        decString.decryptData().convertToDictionary()
                                        }



                                        if let res = decResponse {
                                            wsResponce?(response)
                                            //                        if completion != nil {
                                            //                            completion!(res, response.response!.statusCode, nil)
                                            //                        }
                                        }
                                        else {
                                            wsResponce?(response)
                                            //                        if completion != nil {
                                            //                            completion!(nil, response.response!.statusCode, nil)
                                            //                        }
                                        }
                                    }


                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }

}
