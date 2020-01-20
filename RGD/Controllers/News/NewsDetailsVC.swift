//
//  NewsDetailsVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 03/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import YouTubePlayer


class NewsDetailsVC: UIViewController {
    
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
    
    @IBOutlet weak var vwTopImageView: MyView!
    @IBOutlet weak var vwContainerImage: MyView!
    @IBOutlet weak var vwContainerImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnImageLeftBG: MyButton!
    
    @IBOutlet weak var btnImageRightBG: MyButton!
    
    @IBOutlet weak var vwTime: MyView!
    @IBOutlet weak var lblTime: MyLable!
    
    @IBOutlet weak var vwDetails: MyView!
    @IBOutlet weak var lblDetails: MyLable!
    
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var objData : ClassNewsList!
    var strID = ""
    
    var pageViewControllerImages : UIPageViewController = UIPageViewController()
    
    var oldPageIndexImage = 0
    var newPageIndexImage = 0

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: News Details
    
    func newsDetailsAPI() {
        
        /*
         ===========API CALL===========
         
         Method Name : news/detail
         
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
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/news/detail", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            GFunction.sharedMethods.removeLoader()
            //            print(resPonse)
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? Int == 1 {
                                if let tempArr = response[kData] as? JSONResponse {
                                    
                                        let userJson : JSON = JSON(tempArr)
                                        self.objData = ClassNewsList(fromJson: userJson)
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
        self.btnImageLeftBG.addTarget(self, action: #selector(self.btnLeftTapped(_:)), for: .touchUpInside)
        self.btnImageRightBG.addTarget(self, action: #selector(self.btnRightTapped(_:)), for: .touchUpInside)
        
        self.vwContainerImageHeight.constant = ((kScreenWidth-60) * 9)/16//(self.vwContainerImage.frame.width * 9)/16
        self.pageViewControllerImages = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewControllerImages.view.backgroundColor = UIColor.clear
        self.pageViewControllerImages.view.frame = CGRect(x: 0, y: 0, width: self.vwContainerImage.frame.size.width, height: self.vwContainerImage.frame.size.height)
        self.addChild(self.pageViewControllerImages)
        
        self.vwContainerImage.addSubview(self.pageViewControllerImages.view)
        self.pageViewControllerImages.didMove(toParent: self)

        
        self.vwBG.isHidden = true
        self.vwTitle.isHidden = true
        self.vwTopImageView.isHidden = true
        self.btnImageLeftBG.isHidden = true
        self.btnImageRightBG.isHidden = true
        self.vwTime.isHidden = true
        self.vwDetails.isHidden = true
        if objData != nil {
            self.setUpData()
        }
        if strID != "" {
            self.newsDetailsAPI()
        }
        
    }
    
    // ------------------------------------------------------
    
    func setUpData() {
        self.vwBG.isHidden = true
        self.vwTitle.isHidden = true
        self.vwTopImageView.isHidden = true
        self.btnImageLeftBG.isHidden = true
        self.btnImageRightBG.isHidden = true
        self.vwTime.isHidden = true
        self.vwDetails.isHidden = true
        
        if objData != nil {
            self.vwBG.isHidden = false
            
            if self.objData.title != "" {
                self.vwTitle.isHidden = false
                self.lblTitle.text = self.objData.title
            }
            
            if self.objData.media.count > 0 {
                self.vwTopImageView.isHidden = false
                self.setUPContainerImage()
                if self.objData.media.count > 1 {
                    self.btnImageLeftBG.isHidden = false
                    self.btnImageRightBG.isHidden = false
                }
            }
            
            if self.objData.date != "" {
                self.vwTime.isHidden = false
                self.lblTime.text = self.objData.date
            }
            
            if self.objData.descriptionField != "" {
                self.vwDetails.isHidden = false
                self.lblDetails.text = self.objData.descriptionField
            }
            
        }
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    // ------------------------------------------------------
    
    func setUPContainerImage() {
        
        if self.newPageIndexImage > self.oldPageIndexImage {
            let imgVW = kMainBoard.instantiateViewController(withIdentifier: "NewsDetailsImagePageViewVC") as! NewsDetailsImagePageViewVC
            imgVW.objImage = self.objData.media[self.newPageIndexImage]
            self.pageViewControllerImages.setViewControllers([imgVW], direction: .forward, animated: true, completion: nil)
        }
        else if self.newPageIndexImage < self.oldPageIndexImage {
            let imgVW = kMainBoard.instantiateViewController(withIdentifier: "NewsDetailsImagePageViewVC") as! NewsDetailsImagePageViewVC
            imgVW.objImage = self.objData.media[self.newPageIndexImage]
            self.pageViewControllerImages.setViewControllers([imgVW], direction: .reverse, animated: true, completion: nil)
        }
        else {
            let imgVW = kMainBoard.instantiateViewController(withIdentifier: "NewsDetailsImagePageViewVC") as! NewsDetailsImagePageViewVC
            imgVW.objImage = self.objData.media[self.newPageIndexImage]
            self.pageViewControllerImages.setViewControllers([imgVW], direction: .reverse, animated: false, completion: nil)
        }
        self.oldPageIndexImage = self.newPageIndexImage
        
    }
    
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // ------------------------------------------------------
    
    @IBAction func btnLeftTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if self.newPageIndexImage > 0 {
            self.newPageIndexImage = self.newPageIndexImage - 1
        }
        else {
            self.newPageIndexImage = 0
        }
        self.setUPContainerImage()
        
    }
    
    // ------------------------------------------------------
    
    @IBAction func btnRightTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if self.newPageIndexImage < self.objData.media.count-1 {
            self.newPageIndexImage = self.newPageIndexImage + 1
        }
        else {
            self.newPageIndexImage = self.objData.media.count-1
        }
        self.setUPContainerImage()
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
extension NewsDetailsVC {
    
}
