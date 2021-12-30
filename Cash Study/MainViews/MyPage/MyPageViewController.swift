//
//  MyPageViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit
import MessageUI
import KakaoSDKUser
import KakaoSDKAuth

class MyPageViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var termsOfUseView: UIView!
    @IBOutlet weak var versionLbl: UILabel!
    
    
    var userInfoData : ShowUserInfoEntity?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradation()
        setUI()
        
        // 문의하기 tap gesture
        let questionTapped = UITapGestureRecognizer(target: self, action: #selector(questionTapped(_:)))
        questionView.addGestureRecognizer(questionTapped)
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
        
        questionView.layer.addBorder([.top, .bottom], color: .homeBorderColor, width: 0.4)
        reviewView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.4)
        termsOfUseView.layer.addBorder([.bottom], color: .homeBorderColor, width: 0.4)
    }
    
    
    // MARK: 문의하기, 앱 리뷰 남기기, 서비스 이용약관
    func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    @objc func questionTapped(_ sender: UITapGestureRecognizer) {
        guard let versionNumber = self.versionLbl.text else { return }
        if MFMailComposeViewController.canSendMail() {
            print("메일을 보낼 수 있습니다.")
            
            let cpVC = MFMailComposeViewController()
            cpVC.mailComposeDelegate = self
            
            let emailTitle = "플래닛 문의"
            let messageBody =
            """
            SystemVersion: \(UIDevice.current.systemVersion)
            AppVersion: \(String(describing: versionNumber))
            Device: \(self.getDeviceIdentifier())
            """
            
            cpVC.setToRecipients(["jiseok2301@gmail.com"])  // 전달 받을 주소
            cpVC.setSubject(emailTitle)  // 메세지 제목
            cpVC.setMessageBody(messageBody, isHTML: false)
            
        } else {
            
            let message =
            """
            SystemVersion: \(UIDevice.current.systemVersion)
            AppVersion: \(String(describing: versionNumber))
            Device: \(self.getDeviceIdentifier())
            """
            print(message)
            
            
        }
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
