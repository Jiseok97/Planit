//
//  DetailProductViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2022/01/27.
//

import UIKit

class DetailProductViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var expiryPeriodLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var getBtn: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }


    // MARK: - Custom Method
    private func setUI() {
        self.getBtn.layer.cornerRadius = getBtn.frame.height / 2
    }
    
    
    @IBAction func dismissBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
