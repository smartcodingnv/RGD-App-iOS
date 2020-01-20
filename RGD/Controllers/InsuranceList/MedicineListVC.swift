//
//  MedicineListVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 03/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MedicineLisTblCell: UITableViewCell {
    @IBOutlet weak var viewBG: MyView!
    @IBOutlet weak var lblTitle: MyLable!
}


class MedicineListVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnBack: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnNotification: MyButton!

    @IBOutlet weak var txtSearch: MyTextFild!
    @IBOutlet weak var btnClear: MyButton!
    
    @IBOutlet weak var tblView: UITableView!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var insuranceID = ""
    var arrData = [ClassInsuranceList]()
    var arrDataSearch = [ClassInsuranceList]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: Medicine List
    
    func medicineListAPI(strInsurID : String,withBlock completion :(([JSONResponse],String) -> Void)?) {
        
        /*
         ===========API CALL===========
         
         Method Name : insurance_plan/detail
         
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
        WSHelper.sendRequestWithURL(wsUrl: "\(kAPIBaseURL)/insurance_plan/detail", method: .post, param: params, header: headersT, isDebug: true) { (resPonse) in
            GFunction.sharedMethods.removeLoader()
            if resPonse != nil {
                if resPonse?.error == nil {
                    if resPonse!.response?.statusCode == 200 {
                        if let response = resPonse!.value as? JSONResponse {
                            
                            if response[kCode] as? NSNumber == 1 {
                                if let tempArr = response[kData] as? [JSONResponse] {
                                    /*
                                    for item in tempArr {
                                        let userJson : JSON = JSON(item)
                                        let dataT = ClassInsuranceList(fromJson: userJson)
                                        self.arrData.append(dataT)
                                    }
                                    */
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
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        
        
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.btnBack.addTarget(self, action: #selector(self.btnBankTapped(_:)), for: .touchUpInside)
        
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.reloadData()
        self.medicineListAPI(strInsurID: "\(self.insuranceID)") { (data, insurance) in
            for item in data {
                let userJson : JSON = JSON(item)
                let dataT = ClassInsuranceList(fromJson: userJson)
                self.arrData.append(dataT)
                self.arrDataSearch = self.arrData
                self.tblView.reloadData()
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
    
    // ------------------------------------------------------
    
    @IBAction func btnBankTapped(_ sender: UIButton) {
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

extension MedicineListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDataSearch.count
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineLisTblCell", for: indexPath) as! MedicineLisTblCell
        let obj = self.arrDataSearch[indexPath.row]
        
        cell.lblTitle.text = obj.name
        
        return cell
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        /*
         let obj = self.arrData[indexPath.row]
         let nextVC = kMainBoard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
         nextVC.objData = obj
         nextVC.strID = "\(obj.id!)"
         self.navigationController?.pushViewController(nextVC, animated: true)
         */
    }
    
}

extension MedicineListVC : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        if range.location == 0 && (string == " ") {
            return false
        }
        return true
    }
    
    // ------------------------------------------------------
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            //            self.btnClear.isHidden = true
        }
        else {
            //            self.btnClear.isHidden = false
        }
        let searchString = textField.text!.replacingOccurrences(of: " ", with: " ").uppercased()
        //        if searchString != "" || searchString != " " {
        
        self.arrDataSearch = self.arrData.filter({ (obj) -> Bool in
            
            let objStr = obj.name.replacingOccurrences(of: " ", with: " ").uppercased()
            return objStr.contains(str: searchString)
            //                if objStr.contains(str: searchString) == true {
            //                    return true
            //                }
            //
            //                return false
        })
        //        }
        if self.txtSearch.text == "" || self.txtSearch.text == "*" {
            self.arrDataSearch = self.arrData
        }
        //        self.dataArrSearch = self.sortArrayMedicineByName(tempArr: self.dataArrSearch)
        self.tblView.reloadData()
    }
}
