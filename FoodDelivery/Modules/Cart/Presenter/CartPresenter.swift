//
//  CartPresenter.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import RxSwift
import RxCocoa

protocol CartPresenterVProtocol {
    var view: CartViewProtocol?{get set}
    var interactor: CartInteractorProtocol?{get set}
    var router: CartRouterProtocol?{get set}
    
    
    var listItems: BehaviorRelay<[FoodsRes.Food]>{get}
    var listFoods: BehaviorRelay<[CartFoodCellPresentable]>{get}
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func viewDidAppear()
}

protocol CartPresenterIProtocol: AnyObject {
    //INTERACTOR -> PRESENTER

//    func fetchCart(foods: [Food])
//    func fetchPromotionsFinished(promotionsURLs: [String])
//    func fetchFoodsFinished(foods: [FoodCellPresentable])
}

final class CartPresenter{
    weak var view: CartViewProtocol?
    var interactor: CartInteractorProtocol?
    var router: CartRouterProtocol?
    
    var listItems = BehaviorRelay<[FoodsRes.Food]>(value: [])
    var listFoods = BehaviorRelay<[CartFoodCellPresentable]>(value: [])
    
    private var foods: [FoodsRes.Food] = []
    private let disposeBag = DisposeBag()
    init(buyFoods: [FoodsRes.Food]) {
        foods = buyFoods
        
    }
}

extension CartPresenter: CartPresenterVProtocol{
    func viewDidLoad() {
        loadBuyFoods()
    }
    func viewDidAppear() {
    }
}

extension CartPresenter: CartPresenterIProtocol{
    
}
//MARK: - Private
extension CartPresenter{
    private func loadBuyFoods(){
        listItems.accept(foods)
        listFoods.accept(foods.map{CartFoodCellViewModel(food: $0)})
    }
}
