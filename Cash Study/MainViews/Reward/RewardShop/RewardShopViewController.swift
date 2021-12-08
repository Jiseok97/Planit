//
//  RewardShopViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/02.
//

import UIKit

class RewardShopViewController: UIViewController {
    
    @IBOutlet weak var pointView: UIView!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        productCV.delegate = self
        productCV.dataSource = self
        
        productCV.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        if let collectionViewLayout = productCV.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.changeHeight()
    }

    
    // MARK: Functions
    func setUI() {
        self.pointView.layer.cornerRadius = 8
        self.buttonsView.layer.cornerRadius = 8
        self.buttonsView.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        categoryBtns.forEach {
            $0.layer.cornerRadius = 4
        }
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension RewardShopViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func changeHeight() {
        self.cvHeight.constant = self.productCV.collectionViewLayout.collectionViewContentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
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
