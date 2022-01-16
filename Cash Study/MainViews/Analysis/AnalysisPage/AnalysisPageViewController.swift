//
//  AnalysisPageViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/06.
//

import UIKit
import Lottie
class AnalysisPageViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }


    func setUI() {
        contentView.layer.borderColor = UIColor.homeBorderColor.cgColor
        contentView.layer.borderWidth = 0.8
        contentView.layer.cornerRadius = 8
    }
}
