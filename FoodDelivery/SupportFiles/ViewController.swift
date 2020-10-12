//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 09/10/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = HomeRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = " "
    }


}

