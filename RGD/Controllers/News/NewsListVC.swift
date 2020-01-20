//
//  NewsListVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 02/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewsListTblCell: UITableViewCell {
    @IBOutlet weak var viewBG: MyView!
    @IBOutlet weak var lblTitle: MyLable!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var imgMainHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDate: MyLable!
    @IBOutlet weak var lblDesc: MyLable!
}

class NewsListVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnMenu: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnNotification: MyButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var arrData = [ClassNewsList]()
    private let refreshControl = UIRefreshControl()

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: News List
    
    func newsListAPI() {
        
        /*
         ===========API CALL===========
         
         Method Name : news
         
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
        
        GFunction.sharedMethods.addloader()
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/news", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            GFunction.sharedMethods.removeLoader()
            //            print(resPonse)
            self.arrData.removeAll()
            self.tblView.reloadData()
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? Int == 1 {
                                if let tempArr = response[kData] as? [JSONResponse] {
                                    for item in tempArr {
                                        let userJson : JSON = JSON(item)
                                        let dataT = ClassNewsList(fromJson: userJson)
                                        self.arrData.append(dataT)
                                    }
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
            self.tblView.reloadData()
        }
    }

    
    // ------------------------------------------------------
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.newsListAPI()
        self.btnMenu.addTarget(self, action: #selector(self.btnMenuTapped(_:)), for: .touchUpInside)
        self.perform(#selector(self.setUpDataPullRefresh), with: nil, afterDelay: 1.0)
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
            self.newsListAPI()
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
extension NewsListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTblCell", for: indexPath) as! NewsListTblCell
        let obj = self.arrData[indexPath.row]
        
        cell.lblTitle.text = obj.title
        cell.imgMain.image = UIImage(named: "IMGBGLogo")
        
        if let strImg = obj.image.first {
            cell.imgMain.setIMageWithURL(strURL: strImg, contentType: .scaleAspectFill)
        }
        
        cell.imgMainHeight.constant = ((kScreenWidth-40) * 9)/16//(cell.imgMain.frame.width * 9)/16
        cell.lblDate.text = obj.date
        cell.lblDesc.text = obj.descriptionField
        
        return cell
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let obj = self.arrData[indexPath.row]
        
        let nextVC = kMainBoard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
        nextVC.objData = obj
        nextVC.strID = "\(obj.id!)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
