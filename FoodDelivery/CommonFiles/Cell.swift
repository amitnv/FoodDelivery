//
//  Cell.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Foundation

protocol CellConfigurable {
    associatedtype Presenter
    func configCell(presenter: Presenter)
}

