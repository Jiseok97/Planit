//
//  SplashViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class SplashViewController: UIViewController {
    
    var isConnect : Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkDisconnect(_:)), name: NSNotification.Name("NetworkDisconnect"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NetworkDisconnect"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        self.isConnectVC(self.isConnect)
    }

    
    // MARK: - Custom Method
    @objc private func networkDisconnect(_ noti: Notification) {
        self.isConnect = false
    }
    
    private func isConnectVC(_ status: Bool) {
        if status {
            usleep(2700000)
            changeRootVC(LoginViewController())
        } else {
            usleep(1000000)
            let vc = ObAlertViewController(mainMsg: "네트워크가\n연결되지 않았습니다", subMsg: "네트워크 연결 상태를 확인해주세요", heightValue: 0.25, btnTitle: "다시 시도", isTimer: false, isMypage: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}
