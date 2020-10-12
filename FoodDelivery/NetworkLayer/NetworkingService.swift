//
//  NetworkingService.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Moya
import ObjectMapper

typealias RESPONSE_COMPLETE = (Bool, Any?) -> Void
typealias RESPONSE_DATA_COMPLETE = (Bool, Data?) -> Void

protocol Networkable {
    var provider: MoyaProvider<NetworkApi> {get}
    func fetchPromotions(completion: @escaping RESPONSE_COMPLETE)
}

struct NetworkingService: Networkable {
    var provider = MoyaProvider<NetworkApi>(stubClosure: MoyaProvider<NetworkApi>.immediatelyStub)
    
    private func fetch(api: NetworkApi, complete: @escaping  RESPONSE_DATA_COMPLETE) {
        provider.request(api) {(result) in
            switch result{
            case .success(let response):
                print("Request success! \(api.path)")
                complete(true, response.data)
            case .failure(let error):
                print("Request failed! \(error.localizedDescription )")
                complete(false, nil)
            }
        }
    }
}

//public methods
extension NetworkingService{
    
    public func fetchPromotions(completion: @escaping RESPONSE_COMPLETE) {
        fetch(api: .loadPromotions) { (success, data) in
            guard let data = data else{ completion(false, "Response is empty!"); return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
                completion(false, "Wrong format of response!"); return
            }
            guard let promotions:PromotionRes = Mapper<PromotionRes>().map(JSON: json) else {
                completion(false, "Error mapping response"); return
            }
            completion(true, promotions)
        }
    }
    
    public func fetchFoods(completion: @escaping RESPONSE_COMPLETE) {
        fetch(api: .loadFoods) { (success, data) in
            guard let data = data else{ completion(false, "Response is empty!"); return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
                completion(false, "Wrong format of response!"); return
            }
            guard let promotions:FoodsRes = Mapper<FoodsRes>().map(JSON: json) else {
                completion(false, "Error mapping response"); return
            }
            completion(true, promotions)
        }
    }
}

