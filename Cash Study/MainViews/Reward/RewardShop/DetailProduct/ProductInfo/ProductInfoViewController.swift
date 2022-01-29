//
//  ProductInfoViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2022/01/29.
//

import UIKit

class ProductInfoViewController: UIViewController {
    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var expiryPeriodLbl: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var myPointLbl: UILabel!
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var lackPointView: UIStackView!
    @IBOutlet weak var remainingPointLbl: UILabel!
    
    @IBOutlet weak var getBtn: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: - Custom Method
    private func setUI() {
        self.productImgView.layer.cornerRadius = 10
        self.firstView.layer.cornerRadius = 8
        self.secondView.layer.cornerRadius = 8
        self.getBtn.layer.cornerRadius = getBtn.frame.height / 2
    }
    
    
    @IBAction func getBtnTapped(_ sender: Any) {
        /// 구매 완료 누를 시, 이벤트
        /// 포인트 충족 되는지 안되는지 여부 판단 해주기
        
        
    }
    
    
    @IBAction func dismissBtnTapped(_ sender: Any) {
        /// 뒤로 가기 버튼 이벤트
        self.dismiss(animated: true, completion: nil)
    }
}
