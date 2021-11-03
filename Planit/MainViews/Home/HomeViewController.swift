//
//  HomeViewController.swift
//  Planit
//
//  Created by 이지석 on 2021/11/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addDdayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func setUI() {
        addDdayBtn.layer.borderColor = UIColor.homeBorderColor.cgColor
        addDdayBtn.layer.borderWidth = 1
        addDdayBtn.layer.cornerRadius = 8
    }
}
