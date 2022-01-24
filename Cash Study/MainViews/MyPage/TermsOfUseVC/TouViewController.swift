//
//  TouViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/30.
//

import UIKit

class TouViewController: UIViewController {

    @IBOutlet weak var touView: UIView!
    @IBOutlet weak var infoFirstView: UIView!
    @IBOutlet weak var infoSecondView: UIView!
    @IBOutlet weak var marketingView: UIView!
    @IBOutlet weak var leaveView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUI()
        addGesture()
    }
    
    
    // MARK: - Custom Method
    func setUI() {
        leaveView.isHidden = true
        
        touView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        infoFirstView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        infoSecondView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
        marketingView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.5)
    }
    
    /// Extension UIViewController 정의
    func addGesture() {
        /// 이용약관 필수동의(필수) 클릭
        let touTapped = UITapGestureRecognizer(target: self, action: #selector(self.touTapped(_:)))
        touView.addGestureRecognizer(touTapped)
        /// 개인정보 수집 이용 동의(필수) 클릭
        let infoFirstTapped = UITapGestureRecognizer(target: self, action: #selector(self.infoFirstTapped(_:)))
        infoFirstView.addGestureRecognizer(infoFirstTapped)
        /// 개인정보 수집 이용 동의(선택) 클릭
        let infoSecondTapped = UITapGestureRecognizer(target: self, action: #selector(self.infoSecondTapped(_:)))
        infoSecondView.addGestureRecognizer(infoSecondTapped)
        /// 플래닛 알림 및 광고 메세지 수신(선택) 클릭
        let marketingTapped = UITapGestureRecognizer(target: self, action: #selector(self.marketingTapped(_:)))
        marketingView.addGestureRecognizer(marketingTapped)
        /// 회원 탈퇴 클릭
        let leaveTapped = UITapGestureRecognizer(target: self, action: #selector(self.leaveTapped(_:)))
        leaveView.addGestureRecognizer(leaveTapped)
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
