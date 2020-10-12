//
//  CartView.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import RxSwift

protocol CartViewProtocol: AnyObject{
    //PRESENTER -> VIEW
    var presenter: CartPresenterVProtocol?{get set}
}

final class CartView: UIViewController {

    @IBOutlet weak var foodsTableView: UITableView!
    
    var presenter: CartPresenterVProtocol?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
        initTableView()
        binding()
        presenter?.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
}

extension CartView: CartViewProtocol{
    
}

//MARK: - Private
extension CartView{
    private func initTableView(){
        
        foodsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        foodsTableView.regCell(cell: CartFoodCell.self)
        foodsTableView.tableFooterView = UIView(frame: CGRect.zero)
        foodsTableView.allowsSelection = false
        
        
    }
    private func binding(){
        //list foods
        presenter?.listFoods.asObservable().bind(to:foodsTableView.rx.items) { (tableView, row, element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CartFoodCell.identifier) as! CartFoodCell
            cell.configCell(presenter: element)
//            var bill: Int = element.price ?? 0
            return cell
        }.disposed(by: disposeBag)
    }
}

