//
//  WachtdienstDetailsVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 04/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import WebKit

class WachtdienstDetailsTblCell: UITableViewCell {
    @IBOutlet weak var viewBG: MyView!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var imgMainHeight: NSLayoutConstraint!
}

class WachtdienstDetailsVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnBack: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnNotification: MyButton!
    
    @IBOutlet weak var vwBG: MyView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var vwTitle: MyView!
    @IBOutlet weak var lblTitle: MyLable!
    
    @IBOutlet weak var vwStartDate: MyView!
    @IBOutlet weak var lblStartDate: MyLable!
    @IBOutlet weak var lblStartDateDot: MyLable!
    @IBOutlet weak var lblStartDateValue: MyLable!
    
    @IBOutlet weak var vwEndDate: MyView!
    @IBOutlet weak var lblEndDate: MyLable!
    @IBOutlet weak var lblEndDateDot: MyLable!
    @IBOutlet weak var lblEndDateValue: MyLable!
    
    @IBOutlet weak var vwTblView: MyView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var vwBGImportantNote: MyView!
    @IBOutlet weak var webImportantNote: WKWebView!
    @IBOutlet weak var webImportantNoteHeight: NSLayoutConstraint!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var objData : ClassWachtdienst!
    var strID = ""
    var arrImgs = [String]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: Wachtdienst Details
    
    func wachtdienstDetailsAPI() {
        
        /*
         ===========API CALL===========
         
         Method Name : gaurd_time_table/detail
         
         Parameter   :
         {
         "sync_date":"2019-12-30 05:54:00",
         "id" : 3
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
        params["id"] = self.strID
        
        GFunction.sharedMethods.addloader()
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/gaurd_time_table/detail", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            GFunction.sharedMethods.removeLoader()
            //            print(resPonse)
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? Int == 1 {
                                if let tempArr = response[kData] as? JSONResponse {
                                    
                                    let userJson : JSON = JSON(tempArr)
                                    self.objData = ClassWachtdienst(fromJson: userJson)
                                    self.setUpData()
                                }
                            }else {
                                GFunction.ShowAlert(message: response["message"] as! String)
                            }
                            
                        } // Is Json Value
                    }
                    
                } // End error Nil
                else {
                    GFunction.ShowAlert(message: (resPonse?.error?.localizedDescription)!)
                }
            } // End ResPonse Nil
        }
    }

    
    // ------------------------------------------------------
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        self.btnBack.addTarget(self, action: #selector(self.btnBackTapped(_:)), for: .touchUpInside)
        self.vwBG.isHidden = true
        self.vwTitle.isHidden = true
        self.vwStartDate.isHidden = true
        self.vwEndDate.isHidden = true
        self.vwTblView.isHidden = true
        self.vwBGImportantNote.isHidden = true
        
        if objData != nil {
            self.setUpData()
        }
        if strID != "" {
//            self.wachtdienstDetailsAPI()
        }
    }
    
    // ------------------------------------------------------
    
    func setUpData() {
        
        self.vwBG.isHidden = true
        self.vwTitle.isHidden = true
        self.vwStartDate.isHidden = true
        self.vwEndDate.isHidden = true
        self.vwTblView.isHidden = true
        self.vwBGImportantNote.isHidden = true
        
        if objData != nil {
            self.vwBG.isHidden = false
            if self.objData.title != "" {
                self.vwTitle.isHidden = false
                self.lblTitle.text = self.objData.title
            }
            
            self.vwStartDate.isHidden = false
            self.lblStartDate.text = "Start Date"
            self.lblStartDateValue.text = self.objData.startDateTime
            
            self.vwEndDate.isHidden = false
            self.lblEndDate.text = "End Date"
            self.lblEndDateValue.text = self.objData.endDateTime

            self.arrImgs.removeAll()
            
            if let arr : [String] = self.objData.image.components(separatedBy: ",") {
                self.arrImgs = arr
            }
            
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.tblView.isScrollEnabled = false
            
            if self.arrImgs.count > 0 {
                self.vwTblView.isHidden = false
                self.tblViewHeight.constant = 15
            }
            else {
                self.tblViewHeight.constant = 0
            }
            self.tblView.reloadData()
            
            self.vwBGImportantNote.isHidden = false
            self.webImportantNote.backgroundColor = UIColor.clear
            self.webImportantNote.isOpaque = false
            
//            self.webImportantNote.scrollView.isScrollEnabled = false
            self.webImportantNote.scrollView.alwaysBounceHorizontal = false
            self.webImportantNote.scrollView.alwaysBounceVertical = false
            let tempStr = "<meta name=\"viewport\" content=\"initial-scale=1.2\"/>" + self.objData.descriptionField
            self.webImportantNote.loadHTMLString(tempStr, baseURL: nil)
            self.webImportantNote.navigationDelegate = self
        }
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
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
    }
    
    // ------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // ------------------------------------------------------
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // ------------------------------------------------------
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}

extension WachtdienstDetailsVC  : WKNavigationDelegate {
    
    // ------------------------------------------------------
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webImportantNote.sizeToFit()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.webImportantNoteHeight.constant = self.webImportantNote.scrollView.contentSize.height
            DispatchQueue.main.async {
                self.webImportantNote.sizeToFit()
                self.webImportantNoteHeight.constant = self.webImportantNote.scrollView.contentSize.height
            }
        }
        
    }
    
    // ------------------------------------------------------
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard url != nil else {
            decisionHandler(.allow)
            return
        }
        if url!.description.lowercased().starts(with: "http://") ||
            url!.description.lowercased().starts(with: "https://")  {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
}
extension WachtdienstDetailsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImgs.count
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WachtdienstDetailsTblCell", for: indexPath) as! WachtdienstDetailsTblCell
        let obj = self.arrImgs[indexPath.row]
        cell.imgMain.setIMageWithURL(strURL: obj, contentType: .scaleAspectFill)
        cell.imgMain.addTap(flag: true)
        self.tblViewHeight.constant = self.tblView.contentSize.height
        return cell
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tblViewHeight.constant = self.tblView.contentSize.height
    }
    
}
extension WachtdienstDetailsVC {
    
}
