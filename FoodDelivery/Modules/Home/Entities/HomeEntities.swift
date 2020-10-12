//
//  HomeEntities.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Foundation

protocol FoodCellPresentable {
    var id: String?{get}
    var name: String?{get}
    var description: String?{get}
    var imgURL: String?{get}
    var packageDescription: String?{get}
    var price: String?{get}
}

struct FoodCellViewModel: FoodCellPresentable{
    var model: FoodsRes.Food
    var id: String?{return model.itemId}
    var name: String?{return model.name}
    var description: String?{return model.des}
    var imgURL: String?{return model.img}
    var packageDescription: String?{return "\(model.size ?? "") \(model.weight ?? "")"}
    var price: String?{return String(model.price ?? 0)}
    
    init(food: FoodsRes.Food) {
        self.model = food
    }
}
