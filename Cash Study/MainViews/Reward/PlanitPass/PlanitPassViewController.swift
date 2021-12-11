//
//  PlanitPassViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/12/10.
//

import UIKit
import KakaoSDKCommon

class PlanitPassViewController: UIViewController {
    
    @IBOutlet weak var planitNameLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var passCV: UICollectionView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    var currentIdx : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        passCV.delegate = self
        passCV.dataSource = self
        passCV.register(UINib(nibName: "PlanitPassCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "passCell")
        passCV.decelerationRate = .fast
        passCV.isPagingEnabled = true
       
    }


    // MARK: Functions
    func setUI() {
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        passCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PlanitPassViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "passCell", for: indexPath) as? PlanitPassCollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(32)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.passCV.bounds.width - 32, height: self.passCV.bounds.height)
    }
    
    
}
