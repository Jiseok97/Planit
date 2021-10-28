//
//  SelectJobViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/27.
//

import UIKit

class SelectJobViewController: UIViewController {
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var seventhBtn: UIButton!
    @IBOutlet weak var eighthBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        let size : CGFloat = 11
        
        self.firstBtn.layer.cornerRadius = size
        self.secondBtn.layer.cornerRadius = size
        self.thirdBtn.layer.cornerRadius = size
        self.fourthBtn.layer.cornerRadius = size
        self.fifthBtn.layer.cornerRadius = size
        self.sixthBtn.layer.cornerRadius = size
        self.seventhBtn.layer.cornerRadius = size
        self.eighthBtn.layer.cornerRadius = size
        
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        
        swipeRecognizer()
    }
    
    
//    @IBAction func selectedBtn(_ sender: UIButton) {
//        switch sender {
//        case firstBtn:
//            print("Selected FirstButton")
//        case secondBtn:
//            print("Selected SecondeButton")
//        default:
//            print("This is Default")
//        }
//    }
    
    @IBAction func moveRecommenderVC(_ sender: Any) {
        guard let rcVC = self.storyboard?.instantiateViewController(identifier: "InputRecommenderViewController") as? InputRecommenderViewController else { return }
        
        self.navigationController?.pushViewController(rcVC, animated: false)
    }
    
}
