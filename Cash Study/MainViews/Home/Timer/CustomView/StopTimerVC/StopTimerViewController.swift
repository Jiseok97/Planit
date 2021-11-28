//
//  StopTimerViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/29.
//

import UIKit

class StopTimerViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var restView: UIView!
    @IBOutlet weak var starView: UIView!
    @IBOutlet weak var bonusView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var totalRecordTimeLbl: UILabel!
    @IBOutlet weak var additionRecordTimeLbl: UILabel!
    @IBOutlet weak var restLbl: UILabel!
    @IBOutlet weak var starCntLbl: UILabel!
    @IBOutlet weak var bonusCntLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var studyTitle: String = ""
//    var totalRcrd: Int = 0
//    var additionRcrd: Int = 0
//    var starCnt: Int = 0
//    var bonusCnt: Int = 0
//    var restCnt: Int = 0
//    var isEdit: Bool = false
    
    init(title: String) {
        self.studyTitle = title
//        self.totalRcrd = totalRcrd
//        self.additionRcrd = additionRcrd
//        self.starCnt = starCnt
//        self.bonusCnt = bonusCnt
//        self.restCnt = restCnt
//        self.isEdit = isEdit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstView.layer.cornerRadius = 8
        self.restView.layer.cornerRadius = 8
        self.starView.layer.cornerRadius = 8
        self.bonusView.layer.cornerRadius = 8
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        self.titleLbl.text = studyTitle
        
    }

    
    // MARK: Function
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
