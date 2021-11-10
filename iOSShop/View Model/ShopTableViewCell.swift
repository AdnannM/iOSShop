//
//  ShopTableViewCell.swift
//  iOSShop
//
//  Created by Adnann Muratovic on 03.11.21.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var backgroundCellView: UIView! {
        didSet {
            backgroundCellView.layer.cornerRadius = 20
            backgroundCellView.layer.borderWidth = 2
            backgroundCellView.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var imageViewCell: UIImageView! {
        didSet {
            imageViewCell.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cpuLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
