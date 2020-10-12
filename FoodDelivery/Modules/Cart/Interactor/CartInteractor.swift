//
//  CartInteractor.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Foundation

protocol CartInteractorProtocol{
    //PRESENTER -> INTERACTOR
    var presenter: CartPresenterIProtocol?{get set}
    
    func fetchCartFoods()
    
}

final class CartInteractor{
    weak var presenter: CartPresenterIProtocol?
    
    private var networkingService = NetworkingService()
}

extension CartInteractor: CartInteractorProtocol{
    func fetchCartFoods() {
//        networkingService.fetchFoods { (success, response) in
//            if success, let res = response as? FoodsRes, let foods = res.foods{
//                self.presenter?.fetchFoodsFinished(foods: foods.map{FoodCellViewModel(food: $0)})
//            }
//        }
        
    }
}
