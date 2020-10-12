//
//  CartEntities.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Foundation

protocol CartFoodCellPresentable {
    var name: String?{get}
    var imgURL: String?{get}
    var price: Int?{get}
}
struct CartFoodCellViewModel: CartFoodCellPresentable{
    var model: FoodsRes.Food
    var name: String?{return model.name}
    var imgURL: String?{return model.img}
    var price: Int?{return model.price ?? 0}
    
    init(food: FoodsRes.Food) {
        self.model = food
    }
}
