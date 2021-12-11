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
        setCVLayout()
        
        passCV.delegate = self
        passCV.dataSource = self
        passCV.register(UINib(nibName: "PlanitPassCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "passCell")
        passCV.decelerationRate = UIScrollView.DecelerationRate.fast
        passCV.isPagingEnabled = false

    }


    // MARK: Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUI() {
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
    }
    
    func setCVLayout() {
        let cellWidth = self.view.bounds.width - 40
        let cellHeight = floor(self.passCV.bounds.height)
        
        let layout = passCV.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        passCV.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension PlanitPassViewController : UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.passCV.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x - 30) / cellWidthIncludingSpacing
        var roundIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundIndex = floor(index)
        } else {
            roundIndex = ceil(index)
        }
        
        print("scrollView.contentOffset.x = \(scrollView.contentOffset.x)")
        print("targetContentOffset.pointee.x = \(targetContentOffset.pointee.x)")
        
        if currentIdx > roundIndex {
            currentIdx -= 1
            roundIndex = currentIdx
        } else if currentIdx < roundIndex {
            currentIdx += 1
            roundIndex = currentIdx
        }
        
//        offset = CGPoint(x: roundIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
//                         y: -scrollView.contentInset.top)
        if roundIndex == 0.0 {
            offset = CGPoint(x: 32,
                             y: -scrollView.contentInset.top)
        }
        else if roundIndex == 2.0 {
            offset = CGPoint(x: roundIndex * layout.itemSize.width - layout.minimumLineSpacing,
                             y: -scrollView.contentInset.top)
        }
        else {
            offset = CGPoint(x: 288,
                             y: -scrollView.contentInset.top)
        }
//        offset = CGPoint(x: roundIndex * cellWidthIncludingSpacing,
//                         y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
//        print("offset = \(offset)")
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: passCV.bounds.width * 0.8, height: self.view.bounds.height * 0.42857)
    }
    
    
}
