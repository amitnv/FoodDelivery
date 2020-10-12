//
//  Identifier.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import UIKit

protocol Identifier {
    static var identifier: String{get}
}
extension Identifier{
    static var identifier: String {
        return String(describing: self)
    }
}
extension UIView: Identifier{}
extension UITableView{
    func regCell<CellName>(cell: CellName.Type) where CellName: UITableViewCell{
        self.register(UINib(nibName: CellName.identifier, bundle: nil),
                      forCellReuseIdentifier: CellName.identifier)
    }
}
