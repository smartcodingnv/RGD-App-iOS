//
//  DoctorVC.swift
//  RGD
//
//  Created by SapratigsMACMini on 06/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import NMAKit

enum SelectedRang : String {
    case s5 = "5"
    case s10 = "10"
    case s15 = "15"
    case s20 = "20"
    case sAll = "All"
}

enum TypeOfData : String {
    case Doctor = "Doctor"
    case Apotheek = "Apotheek"
    case Lab = "Lab"
    case Service = "Service"
}

class DoctorListTblCell: UITableViewCell {
    
    @IBOutlet weak var viewBG: MyView!
    
    @IBOutlet weak var vwTitle: MyView!
    @IBOutlet weak var lblTitle: MyLable!
    
    @IBOutlet weak var vwLocation: MyView!
    @IBOutlet weak var lblLocation: MyLable!
    @IBOutlet weak var lblLocationDot: MyLable!
    @IBOutlet weak var lblLocationValue: MyLable!
    
    @IBOutlet weak var vwService: MyView!
    @IBOutlet weak var lblService: MyLable!
    @IBOutlet weak var lblServiceDot: MyLable!
    @IBOutlet weak var lblServiceValue: MyLable!
    
    @IBOutlet weak var vwAddress: MyView!
    @IBOutlet weak var lblAddress: MyLable!
    @IBOutlet weak var lblAddressDot: MyLable!
    @IBOutlet weak var lblAddressValue: MyLable!
    
    @IBOutlet weak var vwWorkTime: MyView!
    @IBOutlet weak var lblWorkTime: MyLable!
    @IBOutlet weak var lblWorkTimeDot: MyLable!
    @IBOutlet weak var lblWorkTimeValue: MyLable!
    
    @IBOutlet weak var vwPhone: MyView!
    @IBOutlet weak var lblPhone: MyLable!
    @IBOutlet weak var lblPhoneDot: MyLable!
    @IBOutlet weak var lblPhoneValue: MyLable!
    
    
    
}

class DoctorVC: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btnMenu: MyButton!
    @IBOutlet weak var lblScreenTitle: MyLable!
    @IBOutlet weak var btnSearch: MyButton!

    @IBOutlet weak var mapView: NMAMapView!
    
    @IBOutlet weak var vwBGDistence: MyView!
    
    @IBOutlet weak var imgDistanceMark1: UIImageView!
    @IBOutlet weak var imgDistanceMark2: UIImageView!
    @IBOutlet weak var imgDistanceMark3: UIImageView!
    @IBOutlet weak var imgDistanceMark4: UIImageView!
    @IBOutlet weak var imgDistanceMark5: UIImageView!
    
    @IBOutlet weak var btn1: MyButton!
    @IBOutlet weak var btn2: MyButton!
    @IBOutlet weak var btn3: MyButton!
    @IBOutlet weak var btn4: MyButton!
    @IBOutlet weak var btn5: MyButton!
    
    @IBOutlet weak var btnExpand: MyButton!
    @IBOutlet weak var btnCurrent: MyButton!
    @IBOutlet weak var btnDownload: MyButton!
    
    @IBOutlet weak var constonTop: NSLayoutConstraint!
    @IBOutlet weak var constonBottom: NSLayoutConstraint!
    
    @IBOutlet weak var tblView: UITableView!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
    var arrData = [MyDataOnMap]()
    var arrDataSearch = [MyDataOnMap]()
    
    var currentLocation = NMAGeoCoordinates()
    
    var typeData : TypeOfData = .Doctor
    var rangeType : SelectedRang = .sAll
    
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
        
    }
    
    // ------------------------------------------------------
    
    func setUpData() {
        
    }
    
    // ------------------------------------------------------
    
    // MARK: - Custome Methods
    
    
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
extension DoctorVC {
    
}
