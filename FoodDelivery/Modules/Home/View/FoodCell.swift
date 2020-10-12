//
//  FoodCell.swift
//  FoodDelivery
//
//  Created by Amit Vaidya on 10/10/2020.
//

import UIKit
import RxSwift
import QuartzCore

class FoodCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var ol_imageView: UIImageView!
    @IBOutlet weak var ol_name: UILabel!
    @IBOutlet weak var ol_description: UILabel!
    @IBOutlet weak var ol_packageDescription: UILabel!
    @IBOutlet weak var ol_buy: UIButton!
    @IBOutlet weak var WrapperView: UIView!
    @IBAction func ol_buy_Clicked(sender: AnyObject) {
                self.ol_buy.alpha = 1.0
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {() -> Void in
                    self.ol_buy.alpha = 0.0
                    self.ol_buy.titleLabel?.text = "added +1"
                    }, completion: {(finished: Bool) -> Void in
                        self.ol_buy.alpha = 1.0
                })
        
    }
    typealias Presenter = FoodCellPresentable
    private(set) var disposeBag = DisposeBag()
    
    func configCell(presenter: FoodCellPresentable) {
        ol_imageView.imageFromURL(urlString: presenter.imgURL ?? "")
        ol_imageView.contentMode = .scaleToFill
        ol_name.text = presenter.name
        ol_description.text = presenter.description
        ol_packageDescription.text = presenter.packageDescription
        ol_buy.setTitle("\(presenter.price ?? "0") usd", for: .normal)
        self.WrapperView.layer.borderColor = UIColor.lightGray.cgColor

    }
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
}

extension UIButton {

  func setBackgroundColor(_ color: UIColor, for forState: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.setBackgroundImage(colorImage, for: forState)
  }

}
