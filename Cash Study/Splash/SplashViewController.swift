//
//  SplashViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit
import Network

class SplashViewController: UIViewController {
    
    var isConnect : Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        /// 네트워크 감지
//        NetworkMonitor.shared.startMonitoring()
//
//        NotificationCenter.default.addObserver(self, selector: #selector(networkConnect(_:)), name: NSNotification.Name("NetworkConnect"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(networkDisconnect(_:)), name: NSNotification.Name("NetworkDisconnect"), object: nil)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NetworkConnect"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NetworkDisconnect"), object: nil)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
//        self.isConnectVC(self.isConnect)
//        changeRootVC(TermsOfUseViewController())
        usleep(2000000)
        changeRootVC(LoginViewController())
    }

    
    // MARK: - Custom Method
//    @objc private func networkConnect(_ noti: Notification) {
//        self.isConnect = true
//        print("Splash VC → 인터넷 연결되어 있음")
//    }
//    @objc private func networkDisconnect(_ noti: Notification) {
//        self.isConnect = false
//        print("Splash VC → 인터넷 연결되어 있지 않음")
//    }
//    
//    private func isConnectVC(_ status: Bool) {
//        if status {
//            usleep(2000000)
//            changeRootVC(LoginViewController())
//        } else {
//            usleep(1000000)
//            let vc = ObAlertViewController(mainMsg: "네트워크가\n연결되지 않았습니다", subMsg: "네트워크 연결 상태를 확인해주세요", heightValue: 0.255, btnTitle: "다시 시도", isTimer: false, isMypage: false, networkConnect: true)
//            vc.modalPresentationStyle = .overFullScreen
//            present(vc, animated: true, completion: nil)
//        }
//    }
}
