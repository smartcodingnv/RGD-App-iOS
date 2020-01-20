//
//  ContactUsVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 06/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class ContactUsListTblCell: UITableViewCell {
    @IBOutlet weak var viewBG: MyView!
    
    @IBOutlet weak var vwTitle: MyView!
    @IBOutlet weak var lblTitle: MyLable!
    
    @IBOutlet weak var vwAddress: MyView!
    @IBOutlet weak var lblAddress: MyLable!
    
    @IBOutlet weak var vwPhoneNo: MyView!
    @IBOutlet weak var lblPhoneNo: MyLable!
    @IBOutlet weak var lblPhoneNoDot: MyLable!
    @IBOutlet weak var lblPhoneNoValue: MyLable!
    
    @IBOutlet weak var vwEmail: MyView!
    @IBOutlet weak var lblEmail: MyLable!
    @IBOutlet weak var lblEmailDot: MyLable!
    @IBOutlet weak var lblEmailValue: MyLable!
    
    @IBOutlet weak var vwTime: MyView!
    @IBOutlet weak var lblTime: MyLable!
    @IBOutlet weak var lblTimeDot: MyLable!
    @IBOutlet weak var lblTimeValue: MyLable!
    
    var arrPhone : [ClassContactUSPhone]!
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        var str = ""
        
        for item in self.arrPhone {
            
            if item.phone != "" {
                if str == "" {
                    str  = item.phone
                }
                else {
                    str = str + ",\n\n" + item.phone
                }
            }
            if item.ext != "" {
                str = str + " ext. " + item.ext
            }
        }
        
        
        
        for item in self.arrPhone {
            var strPhone = ""
            if item.phone != "" {
                if strPhone == "" {
                    strPhone  = item.phone
                }
                else {
                    strPhone = strPhone + ",\n\n" + item.phone
                }
            }
            if item.ext != "" {
                strPhone = strPhone + " ext. " + item.ext
            }
            let strNS : NSString = NSString(string: self.lblPhoneNoValue.text!)
            let signRange = strNS.range(of: strPhone)
            
            if gesture.didTapAttributedTextInLabel(label: self.lblPhoneNoValue, inRange: signRange) {
                print("Tapped Create an Accoount")
                
//                GFunction.ShowAlert(message: item.phone)
                
                let strCallNumber = item.phone!
                
                let strPhone = strCallNumber.components(separatedBy:CharacterSet.decimalDigits.inverted)
                    .joined(separator: "")
                //        replacingOccurrences(of: " ", with: "")
                if strPhone == "" {
                    return
                }
                print(strPhone)
                let url = URL(string: "tel://\(strPhone)")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                return
                
            }  else {
                print("Tapped none")
            }
        }
        
    }
}

class ContactUsVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnMenu: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnNotification: MyButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var arrData = [ClassContactUS]()
    private let refreshControl = UIRefreshControl()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ------------------------------------------------------
    
    // MARK: Contact Us List
    
    func contactUsAPI(strInsurID : String,withBlock completion :(([JSONResponse],String) -> Void)?) {
        
        /*
         ===========API CALL===========
         
         Method Name : contact_list
         
         Parameter   :
         {
         "sync_date":"2019-12-30 05:54:00"
         }
         
         Optional    :
         
         
         Comment     : This api is used to Register.
         
         
         ==============================
         */
        
        
        var headersT = Alamofire.SessionManager.defaultHTTPHeaders
        headersT["Content-Type"] = "application/json"
        headersT["X-Authorization"] = "HRKUXIl4ouqWa88Kefr17LQiG5YZemShNqx0WMkkPtNSHLR8cAPXwStz1KLhQy37"
        
        var params = [String:String]()
        
        params["sync_date"] = ""
        params["id"] = strInsurID
        
        GFunction.sharedMethods.addloader()
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/contact_list", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            GFunction.sharedMethods.removeLoader()
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? NSNumber == 1 {
                                if let tempArr = response[kData] as? [JSONResponse] {
                                    if tempArr.count > 0 {
                                        completion!(tempArr,strInsurID)
                                    }
                                }
                            }
                            else {
                                GFunction.ShowAlert(message: response["message"] as! String)
                                completion!([JSONResponse](),strInsurID)
                            }
                            
                        } // Is Json Value
                        else {
                            completion!([JSONResponse](),strInsurID)
                        }
                    }
                    else {
                        completion!([JSONResponse](),strInsurID)
                    }
                } // End error Nil
                else {
                    GFunction.ShowAlert(message: (resPonse?.error?.localizedDescription)!)
                    completion!([JSONResponse](),strInsurID)
                }
            } // End ResPonse Nil
            else {
                completion!([JSONResponse](),strInsurID)
            }
        }
    }

    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.btnMenu.addTarget(self, action: #selector(self.btnMenuTapped(_:)), for: .touchUpInside)
        self.perform(#selector(self.setUpDataPullRefresh), with: nil, afterDelay: 1.0)
        
        self.contactUsAPI(strInsurID: "") { (data, insurance) in
            for item in data {
                let userJson : JSON = JSON(item)
                let dataT = ClassContactUS(fromJson: userJson)
                self.arrData.append(dataT)
                self.tblView.reloadData()
            }
        }
    }
    
    // ------------------------------------------------------
    
    @objc func setUpDataPullRefresh() {
        // Add Refresh Control to Table View
        
        self.tblView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
    }
    
    // ------------------------------------------------------
    
    @objc private func refreshListData(_ sender: Any) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.contactUsAPI(strInsurID: "") { (data, insurance) in
                for item in data {
                    let userJson : JSON = JSON(item)
                    let dataT = ClassContactUS(fromJson: userJson)
                    self.arrData.append(dataT)
                    self.tblView.reloadData()
                }
            }
        }
    }

    
    // ------------------------------------------------------
    
    func setUpData() {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    @IBAction func btnMenuTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.toggleLeft()
    }
    
    // ------------------------------------------------------
    
    // MARK: - Delegate
    
    // ------------------------------------------------------
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // ------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // ------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.slideMenuController()?.addLeftGestures()
    }
    
    // ------------------------------------------------------
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.slideMenuController()?.removeLeftGestures()
    }

    // ------------------------------------------------------
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
extension ContactUsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }

    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactUsListTblCell", for: indexPath) as! ContactUsListTblCell
        let obj = self.arrData[indexPath.row]
        
        cell.lblTitle.text = obj.location
        cell.lblAddress.text = obj.address
        cell.lblPhoneNo.text = "Telefoon nummer"
        cell.lblPhoneNoValue.text = ""
        
        var str = ""
        
        var objTemp = [ClassContactUSPhone]()
        objTemp.append(contentsOf: obj.phone)
        objTemp.append(contentsOf: obj.phone)
        
        for item in obj.phone {
//        for item in objTemp {
        
            if item.phone != "" {
                if str == "" {
                    str  = item.phone
                }
                else {
                    str = str + ",\n\n" + item.phone
                }
            }
            if item.ext != "" {
                str = str + " ext. " + item.ext
            }
        }
        cell.lblPhoneNoValue.text = str
        cell.arrPhone = obj.phone
        cell.lblPhoneNoValue.isUserInteractionEnabled = true
        cell.lblPhoneNoValue.addGestureRecognizer(UITapGestureRecognizer(target: cell, action: #selector(cell.tapLabel(gesture:))))
        cell.lblPhoneNoValue.textColor = UIColor.blue
        cell.lblEmail.text = "Email"
        cell.lblEmailValue.text = obj.email
        cell.lblTime.text = "Openingstijden"
        cell.lblTimeValue.text = obj.openingTime
        
        
        
        return cell
    }
    
    
}
