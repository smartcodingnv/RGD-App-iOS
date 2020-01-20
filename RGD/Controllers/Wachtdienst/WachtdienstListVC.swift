//
//  WachtdienstListVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 04/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class WachtdienstListTblCell: UITableViewCell {
    @IBOutlet weak var viewBG: MyView!
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
}

class WachtdienstListVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnMenu: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnNotification: MyButton!
    
    @IBOutlet weak var tblView: UITableView!

    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var arrData = [ClassWachtdienst]()
    private let refreshControl = UIRefreshControl()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: Wachtdienst List
    
    func wachtdienstListAPI() {
        
        /*
         ===========API CALL===========
         
         Method Name : gaurd_time_table
         
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
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/gaurd_time_table", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
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
                                        let dataT = ClassWachtdienst(fromJson: userJson)
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
        self.wachtdienstListAPI()
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
            self.wachtdienstListAPI()
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
extension WachtdienstListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WachtdienstListTblCell", for: indexPath) as! WachtdienstListTblCell
        let obj = self.arrData[indexPath.row]
        
        cell.lblTitle.text = obj.title
        cell.lblStartDate.text = "Start Date"
        cell.lblStartDateValue.text = obj.startDateTime

        cell.lblEndDate.text = "End Date"
        cell.lblEndDateValue.text = obj.endDateTime
        
        return cell
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let obj = self.arrData[indexPath.row]
        let nextVC = kMainBoard.instantiateViewController(withIdentifier: "WachtdienstDetailsVC") as! WachtdienstDetailsVC
        nextVC.objData = obj
        nextVC.strID = "\(obj.id!)"
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
