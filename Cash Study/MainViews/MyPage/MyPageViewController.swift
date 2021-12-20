//
//  MyPageViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

class MyPageViewController: UIViewController {

    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    var userInfoData : ShowUserInfoEntity?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradation()
        setUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        showIndicator()
        ShowUserInfoDataManager().showUserInfo(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(editUserInfoNoti(_:)), name: NSNotification.Name("EditUserInfo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logout(_:)), name: NSNotification.Name("Logout"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("EditUserInfo"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Logout"), object: nil)
    }
    
    
    // MARK: Function
    func setUI() {
        self.nicknameView.layer.cornerRadius = 8
        
        self.logoutBtn.layer.cornerRadius = 8
        self.logoutBtn.layer.borderColor = UIColor.placeHolderColor.cgColor
        self.logoutBtn.layer.borderWidth = 0.5
    }
    
    
    @objc func editUserInfoNoti(_ noti : Notification) {
        
        ShowUserInfoDataManager().showUserInfo(viewController: self)
    }
    
    
    @objc func logout(_ noti: Notification) {
        if AuthApi.hasToken() {
            UserApi.shared.logout { (error) in
                if let error = error {
                    print(error)
                } else {
                    print("Kakao Logout success")
                }
            }
        } else {
            print("Kakao Token 없다")
        }
        
        Constant.MY_ACCESS_TOKEN = ""
        changeRootVC(LoginViewController())
    }
    
    
    @IBAction func editUserInfo(_ sender: Any) {
        let sbName = UIStoryboard(name: "EditUserInfo", bundle: nil)
        let ibSB = sbName.instantiateViewController(identifier: "EditUserInfoViewController")
        
        self.navigationController?.pushViewController(ibSB, animated: true)
    }
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        let vc = AlertViewController(mainMsg: "로그아웃 하시겠습니까?", subMsg: "", btnTitle: "확인", isTimer: false, isLogout: true, studyRemove: false, passMode: false)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}


extension MyPageViewController {
    func showUserInfo(result: ShowUserInfoEntity) {
        dismissIndicator()
        self.userInfoData = result
        self.nicknameLbl.text = userInfoData?.nickname
    }
}
