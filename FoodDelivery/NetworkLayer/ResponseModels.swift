//
//  ResponseModels.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import ObjectMapper

struct PromotionRes: Mappable {
    
    var promotions: [String]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        promotions <- map["promotions"]
    }
    
}

struct FoodsRes: Mappable {
    var foods: [Food]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        foods <- map["foods"]
    }
    
    struct Food: Mappable {
        var itemId: String?
        var name: String?
        var des: String?
        var img: String?
        var size: String?
        var weight: String?
        var price: Int?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            itemId <- map["itemId"]
            name <- map["name"]
            des <- map["des"]
            img <- map["img"]
            size <- map["size"]
            weight <- map["weight"]
            price <- map["price"]
        }
    }
}

