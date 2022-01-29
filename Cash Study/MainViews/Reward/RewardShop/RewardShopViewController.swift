//
//  RewardShopViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/02.
//

import UIKit

class RewardShopViewController: UIViewController {
    
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var myPointLbl: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var seventhBtn: UIButton!
    @IBOutlet weak var eighthBtn: UIButton!
    
    @IBOutlet var categoryBtns: [UIButton]!
    
    @IBOutlet weak var productCV: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    var myPoint: Int = 0
    
    /// For Picker View
    @IBOutlet weak var filterBtn: UIButton!
    let filterTitle: [String] = ["인기순", "낮은가격순", "높은가격순"]
    var toolBar = UIToolbar()
    var picker = UIPickerView()
    
    // MARK: - Init
    init(point: Int) {
        self.myPoint = point
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lify Clycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        productCV.delegate = self
        productCV.dataSource = self
        
        productCV.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
//        if let collectionViewLayout = productCV.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var pointStr = String(describing: myPoint)
        if myPoint > 999 {
            pointStr.insert(",", at: pointStr.index(pointStr.endIndex, offsetBy: -3))
        } else if myPoint > 999999 {
            pointStr.insert(",", at: pointStr.index(pointStr.endIndex, offsetBy: -3))
            pointStr.insert(",", at: pointStr.index(pointStr.endIndex, offsetBy: -7))
        }
        self.myPointLbl.text = pointStr
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }

    
    // MARK: - Custom Method
    func setUI() {
        self.pointView.layer.cornerRadius = 8
        self.buttonsView.layer.cornerRadius = 8
        self.buttonsView.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        categoryBtns.forEach {
            $0.layer.cornerRadius = 4
        }
    }
    
    /// 필터 버튼 클릭 이벤트
    /// 필터 Set Up
    @IBAction func filterBtnTapped(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([space, doneBtn], animated: true)
        
        self.view.addSubview(toolBar)
    }
    /// 픽커뷰 "Done" 버튼 누를 시 이벤트
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    
    /// 뒤로 가기
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension Picker View
extension RewardShopViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    /// 픽커(그룹) 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// 픽커 요소 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    /// 표시할 텍스트
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return filterTitle[row]
            
        case 1:
            return filterTitle[row]
            
        case 2:
            return filterTitle[row]
            
        default:
            return ""
        }
        
        /// 선택 관련 메소드
        
    }
    
}



// MARK: - Extension Collection View
extension RewardShopViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.productCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductViewController(point: myPoint)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.addBorder([.top, .bottom], color: UIColor.homeBorderColor, width: 0.8)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = productCV.frame.width
        let height =  self.view.frame.height * 0.2054
        
        return CGSize(width: width, height: height)
    }
    
}
