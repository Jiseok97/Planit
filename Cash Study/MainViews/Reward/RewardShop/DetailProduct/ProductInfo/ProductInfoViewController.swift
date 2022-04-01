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
    @IBOutlet weak var remainingDescriptionLbl: UILabel!
    @IBOutlet weak var remainingPointLbl: UILabel!
    
    @IBOutlet weak var lackPointView: UIStackView!
    @IBOutlet weak var lackPointLbl: UILabel!
    
    @IBOutlet weak var getBtn: UIButton!
    
    var myPoint: Int = 0
    var pricePoint: Int = 1000
    
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
        
        setRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
    }
    
    
    // MARK: - Custom Method
    private func setRadius() {
        self.productImgView.layer.cornerRadius = 10
        self.firstView.layer.cornerRadius = 8
        self.secondView.layer.cornerRadius = 8
        self.getBtn.layer.cornerRadius = getBtn.frame.height / 2
    }
    
    private func setUI() {
        /// 상품 가격 ',' 추가
        var priceStr = String(describing: pricePoint)
        priceStr.insert(",", at: priceStr.index(priceStr.endIndex, offsetBy: -3))
        priceLbl.text = priceStr + "P"
        
        /// 내 포인트 ',' 추가
        var myPointStr = String(describing: myPoint)
        if myPoint > 999 {
            myPointStr.insert(",", at: myPointStr.index(myPointStr.endIndex, offsetBy: -3))
        } else if myPoint > 999999 {
            myPointStr.insert(",", at: myPointStr.index(myPointStr.endIndex, offsetBy: -3))
            myPointStr.insert(",", at: myPointStr.index(myPointStr.endIndex, offsetBy: -7))
        }
        myPointLbl.text = myPointStr + "P"
        
        /// 포인트가 부족할 때
        if myPoint < pricePoint {
            self.remainingPointLbl.isHidden = true
            self.remainingDescriptionLbl.isHidden = true
            self.lackPointView.isHidden = false
            
            let lackPoint = pricePoint - myPoint
            var lackPointStr = String(describing: lackPoint)
            if lackPoint > 999 {
                lackPointStr.insert(",", at: lackPointStr.index(lackPointStr.endIndex, offsetBy: -3))
            }
            lackPointLbl.text = lackPointStr + "P가 부족해요"
        }
        /// 포인트의 조건이 충족될 때
        else {
            self.remainingPointLbl.isHidden = false
            self.remainingDescriptionLbl.isHidden = false
            self.lackPointView.isHidden = true
            
            let remainingPoint = myPoint - pricePoint
            var remainingPointStr = String(describing: remainingPoint)
            if remainingPoint > 999 {
                remainingPointStr.insert(",", at: remainingPointStr.index(remainingPointStr.endIndex, offsetBy: -3))
            } else if remainingPoint > 999999 {
                remainingPointStr.insert(",", at: remainingPointStr.index(remainingPointStr.endIndex, offsetBy: -3))
                remainingPointStr.insert(",", at: remainingPointStr.index(remainingPointStr.endIndex, offsetBy: -7))
            }
            remainingPointLbl.text = remainingPointStr + "P"
        }
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
