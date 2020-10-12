//
//  NetworkAPI.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import Moya

enum NetworkApi{
    case loadPromotions
    case loadFoods
}

extension NetworkApi: TargetType{
    var baseURL: URL {
        return URL(string: "https://fooddelivery.com/")!
    }
    
    var path: String {
        switch self {
        case .loadPromotions: return "promotions"
        case .loadFoods: return "foods"
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .loadPromotions: return loadSampleResponse(fileName: "Promotions")
        case .loadFoods: return loadSampleResponse(fileName: "Foods")
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    
}

extension NetworkApi{
    private func loadSampleResponse(fileName: String) -> Data{
        @objc class TestClass: NSObject{}
        let bundle = Bundle(for: TestClass.self)
        let p = bundle.path(forResource: fileName, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: p!))) ?? Data()
    }
}
