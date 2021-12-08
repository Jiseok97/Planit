//
//  ProductCollectionViewCell.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/02.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.productImgView.layer.cornerRadius = 8
        self.productImgView.clipsToBounds = true
    }

}
