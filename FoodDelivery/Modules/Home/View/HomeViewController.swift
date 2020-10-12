//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
// view -> presenter, router ->presenter, presenter - > interactor, interactor -> entities

import UIKit
import RxSwift
import QuartzCore

//MARK: - Protocol
protocol HomeViewControllerProtocol: AnyObject{
    //VIEW -> PRESENTER
    var presenter: HomePresenterVProtocol?{get set}
    /// Displays a horizontally scrollable promotion images
    /// - Parameter promotionsURLs: Array of image URLs
    func displayPromotions(promotionsURLs: [String])
}
//MARK: - Class

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var promotionsScrollView: UIScrollView!
    @IBOutlet weak var promotionsWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var promotionsPageControl: UIPageControl!
    @IBOutlet weak var foodsTableView: UITableView!
    @IBOutlet weak var foodsTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buyItemCountLabel: UILabel!
    @IBOutlet weak var buyItemButtonView: UIView!
    @IBOutlet weak var buyItemButton: UIButton!
    
    var presenter: HomePresenterVProtocol?
    //ARC for RxSwift
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initTableView()
        DispatchQueue.main.async {
            self.binding()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    //Changes status bar colour to white on homeViewController
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    //Update foodstableview height
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        foodsTableView.layer.removeAllAnimations()
        foodsTableViewHeightConstraint.constant = foodsTableView.contentSize.height
        UIView.animate(withDuration: 0.1) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    deinit {
        foodsTableView.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    //Scroll size set to width of frame so that entire ad scrolls
    @IBAction func pageControlSelected(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = promotionsScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        promotionsScrollView.scrollRectToVisible(frame, animated: true)
    }
    //Handles the segue actions via HomePresenter
    @IBAction func cartButtonClicked(_ sender: UIButton) {
        presenter?.showCart()
    }
}

//MARK: - Extensions

extension HomeViewController: HomeViewControllerProtocol{
    func displayPromotions(promotionsURLs: [String]){
        drawPromotions(arrString: promotionsURLs)
    }
}

extension HomeViewController{
    //Initialise tableViewStyle and cells
    private func initTableView(){
        
        foodsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        foodsTableView.regCell(cell: FoodCell.self)
        foodsTableView.tableFooterView = UIView(frame: CGRect.zero)
        foodsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        foodsTableView.allowsSelection = false
    }
    
    private func binding(){

        //list foods
        presenter?.listFoods.asObservable().bind(to:foodsTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier) as! FoodCell
            cell.configCell(presenter: element)
            
            cell.ol_buy.rx.tap.subscribe({[unowned self] value in
                if let food = self.presenter?.interactor?.foods.filter({$0.itemId == element.id}).first{
                    
                    self.presenter?.addItem.onNext(food)
                    self.buyItemButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
                }
                
            }).disposed(by: cell.disposeBag)
            return cell
        }.disposed(by: disposeBag)
        //cart
        presenter?.itemsCount.asObservable().bind(to: self.buyItemCountLabel.rx.text).disposed(by: disposeBag)
        
    }
    //Adds shadow to the Cart button
    private func setupBuyButtonShadow() {
        self.buyItemButtonView.layer.shadowRadius = 3.0
        self.buyItemButtonView.layer.shadowColor = UIColor.gray.cgColor
        self.buyItemButtonView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.buyItemButtonView.layer.shadowOpacity = 0.5
        self.buyItemButtonView.layer.masksToBounds = false

    }
    /// Function that defines the layout of Images which are fetched from URLs
    /// - Parameter arrString: Array of Image URLs
    private func drawPromotions(arrString: [String]) {
        self.setupBuyButtonShadow()
        var xOffset: CGFloat = 0
        let buttonPadding: CGFloat = 0
        for urlString in arrString {
            let _imgV = UIImageView(frame: CGRect(x: xOffset, y: 0.0, width: UIScreen.main.bounds.width, height: promotionsScrollView.bounds.height))
            _imgV.contentMode = .scaleToFill
            _imgV.backgroundColor = .white
            _imgV.imageFromURL(urlString: urlString)
            
            promotionsScrollView.addSubview(_imgV)
            xOffset = xOffset + _imgV.bounds.width + buttonPadding
        }
        promotionsWidthConstraint.constant = xOffset
        promotionsScrollView.contentSize = CGSize(width: xOffset, height: promotionsScrollView.bounds.height)
        promotionsPageControl.numberOfPages = arrString.count
        promotionsPageControl.currentPage = 0
    }
}
//UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        promotionsPageControl.currentPage = Int(pageIndex)
    }
}
