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
    
    var myPoint: Int = 0
    
    // MARK: - Init
    init(point: Int) {
        self.myPoint = point
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: - Custom Method
    private func setUI() {
        self.productImgView.layer.cornerRadius = 10
        self.getBtn.layer.cornerRadius = getBtn.frame.height / 2
    }
    
    /// 구매하기 이벤트
    @IBAction private func getBtnTapped(_ sender: Any) {
        let vc = ProductInfoViewController(point: myPoint)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    /// 뒤로 가기 이벤트
    @IBAction private func dismissBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
