//
//  HomeRouter.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import UIKit

protocol HomeRouterProtocol {
    //PRESENTER -> ROUTER
    func presentCartScreenFrom(view: HomeViewControllerProtocol, buyFoods: [FoodsRes.Food])
//    func presentDetailScreenFrom(view: HomeViewControllerProtocol, data: String?)
}
final class HomeRouter: Routerable{
    static func createModule() -> UIViewController {
     
        //TODO: create module
        let view = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        if let view = view as? HomeViewController {
            var presenter: HomePresenterVProtocol & HomePresenterIProtocol = HomePresenter()
            var interactor: HomeInteractorProtocol = HomeInteractor()
            let router: HomeRouterProtocol = HomeRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            return view
        }
        return UIViewController()
    }
}
extension HomeRouter: HomeRouterProtocol{
    //Segue from homeVC to cartVC
    func presentCartScreenFrom(view: HomeViewControllerProtocol, buyFoods: [FoodsRes.Food]){
        let vc = CartRouter.createModule(buyFoods: buyFoods)
        if let sourceView = view as? UIViewController{
            sourceView.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
