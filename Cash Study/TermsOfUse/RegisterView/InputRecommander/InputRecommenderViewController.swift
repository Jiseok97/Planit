//
//  InputRecommenderViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/10/28.
//

import UIKit

class InputRecommenderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfView: UIView!
    @IBOutlet weak var recommenderTF: UITextField! {
        didSet {
            recommenderTF.delegate = self
        }
    }
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    var keyHeight: CGFloat?
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    func setUI() {
        self.tfView.layer.cornerRadius = 11
        self.skipBtn.layer.borderWidth = 1
        self.skipBtn.layer.borderColor = UIColor.white.cgColor
        self.skipBtn.layer.cornerRadius = skipBtn.frame.height / 2 - 5
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2 - 5
        self.recommenderTF.setPlaceHolderColor(UIColor.placeHolderColor)
        swipeRecognizer()
        
        self.errorLbl.isHidden = true
        self.errorImageView.isHidden = true
    }
    
    // MARK: TF Delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}
