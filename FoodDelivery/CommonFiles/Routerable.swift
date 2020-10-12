//
//  Routerable.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import UIKit

protocol Routerable {
    static func createModule() -> UIViewController
}

extension Routerable{
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
