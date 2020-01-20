//
//  MenuVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 03/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit

class MenuTblRowCell: UITableViewCell {
    @IBOutlet weak var lblName: MyLable!
}

class MenuVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var imgVWBG: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    
    static let strKNews         =       "Nieuwsbrief"
    static let strKDoctor       =       "Huisartsen"
    static let strKApotheek     =       "Apotheek"
    static let strKLab          =       "Lab"
    static let strKClinic       =       "Diensten"
    static let strKMedicin      =       "Geneesmiddelen"
    static let strKWaiting      =       "Wachtdienst"
    static let strKContactUs    =       "Contact ons"
    
    var arrData : [String] = [strKNews, strKDoctor, strKApotheek, strKLab, strKClinic, strKMedicin, strKWaiting, strKContactUs ]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------------------------------------------------
    
    deinit {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - SetUp Methods
    
    
    func setUp() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
    }
    
    // ------------------------------------------------------
    
    func setUpData() {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    // ------------------------------------------------------
    
    func naviagteUserFromMenu(str : String) {
        switch str {
        case MenuVC.strKNews:
            
            let nextVC = kMainBoard.instantiateViewController(withIdentifier: "NewsListVC") as! NewsListVC
            let nextNav = UINavigationController(rootViewController: nextVC)
            AppDelegate.shared.slideMenuController.changeMainViewController(nextNav, close: true)
            break
        case MenuVC.strKMedicin:
            
            let nextVC = kMainBoard.instantiateViewController(withIdentifier: "InsuranceListVC") as! InsuranceListVC
            let nextNav = UINavigationController(rootViewController: nextVC)
            AppDelegate.shared.slideMenuController.changeMainViewController(nextNav, close: true)
            break
            
        case MenuVC.strKWaiting:
            
            let nextVC = kMainBoard.instantiateViewController(withIdentifier: "WachtdienstListVC") as! WachtdienstListVC
            let nextNav = UINavigationController(rootViewController: nextVC)
            AppDelegate.shared.slideMenuController.changeMainViewController(nextNav, close: true)
            break
            
        case MenuVC.strKContactUs:
            
            let nextVC = kMainBoard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            let nextNav = UINavigationController(rootViewController: nextVC)
            AppDelegate.shared.slideMenuController.changeMainViewController(nextNav, close: true)
            break
        default :
            break
        }
    }
    
    // ------------------------------------------------------
    
    // MARK: - Action Methods
    
    @IBAction func btnTapped(_ sender: UIButton) {
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
        self.tblView.reloadData()
    }
    
    // ------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tblView.reloadData()
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
extension MenuVC {
 
    func makeData() {
        
    }
}
extension MenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTblRowCell", for: indexPath) as! MenuTblRowCell
        let obj = self.arrData[indexPath.row]
        cell.lblName.text = obj
        return cell
    }
    
    // ------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let obj = self.arrData[indexPath.row]
        print(obj)
        self.naviagteUserFromMenu(str: obj)
        
    }
        
}
