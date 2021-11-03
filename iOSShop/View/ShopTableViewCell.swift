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
        }
    }
    @IBOutlet weak var imageViewCell: UIImageView! {
        didSet {
            imageViewCell.layer.cornerRadius = 20
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
