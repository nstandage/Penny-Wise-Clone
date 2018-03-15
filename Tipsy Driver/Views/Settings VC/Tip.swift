//
//  TipVC.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/29/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class Tip: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tip Developer"
        IAPService.shared.getProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func smallTipButton(_ sender: Any) {
        IAPService.shared.purchase(product: .smallTip)
    }
    
    @IBAction func mediumTipButton(_ sender: Any) {
        IAPService.shared.purchase(product: .mediumTip)
    }
    
    @IBAction func largeTipButton(_ sender: Any) {
        IAPService.shared.purchase(product: .largeTip)
    }
}
