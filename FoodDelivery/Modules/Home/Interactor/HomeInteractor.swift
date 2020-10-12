//
//  HomeInteractor.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Foundation

protocol HomeInteractorProtocol{
    //PRESENTER -> INTERACTOR
    var presenter: HomePresenterIProtocol?{get set}
    var foods: [FoodsRes.Food]{get}
    
    func fetchFoods()
    func fetchPromotions()
    
    func getFetchedFoods()
}

final class HomeInteractor{
    weak var presenter: HomePresenterIProtocol?
    var foods: [FoodsRes.Food] = []
    private var networkingService = NetworkingService()
}

extension HomeInteractor: HomeInteractorProtocol{
    func fetchFoods() {
        networkingService.fetchFoods { (success, response) in
            if success, let res = response as? FoodsRes, let foods = res.foods{
                self.foods = foods
                self.presenter?.fetchFoodsFinished(foods: foods.map{FoodCellViewModel(food: $0)})
            }
        }
    }
    func fetchPromotions(){
        networkingService.fetchPromotions { (success, response) in
            if success, let res = response as? PromotionRes, let promotions = res.promotions{
                self.presenter?.fetchPromotionsFinished(promotionsURLs: promotions)
            }
        }
    }
    func getFetchedFoods(){
        self.presenter?.gotFetchedFoods(foods: foods)
    }
}

