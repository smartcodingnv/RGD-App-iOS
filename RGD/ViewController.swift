//
//  ViewController.swift
//  RGD
//
//  Created by SapratigsMACMini on 02/01/20.
//  Copyright © 2020 SapratigsMACMini. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    // ------------------------------------------------------
    
    // MARK: - OutLates
    
    @IBOutlet weak var btn: UIButton!
    
    // ------------------------------------------------------
    
    // MARK: - Class Variables
    
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
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
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
extension ViewController {
    
}
