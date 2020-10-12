//
//  CartFoodCell.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import RxSwift
import UIKit

class CartFoodCell: UITableViewCell, CellConfigurable {
    @IBOutlet weak var ol_imageView: UIImageView!
    @IBOutlet weak var ol_nameLabel: UILabel!
    @IBOutlet weak var ol_priceLabel: UILabel!
    
    typealias Presenter = CartFoodCellPresentable
    private(set) var disposeBag = DisposeBag()
    
    func configCell(presenter: CartFoodCellPresentable) {
            ol_imageView.imageFromURL(urlString: presenter.imgURL ?? "")
            ol_nameLabel.text = presenter.name
            ol_priceLabel.text = "\(presenter.price ?? 0) usd"
//        self.calculateTotal()
    }
//    func calculateTotal() {
//
//    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag()
    }
}

protocol CartFoodCellDelegate: AnyObject {
    func removeItemButtonClicked(cell: CartFoodCell)
}
