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
    
    @IBOutlet weak var nextPageBtn: UIButton!
    @IBOutlet weak var prevPageBtn: UIButton!
    
    
    var passInfo : PlanitPassInfoEntity?
    var currentIdx : Int = 0 {
        didSet {
            self.pageCtrl.currentPage = currentIdx
        }
    }
    var isSuccess: Bool = false {
        didSet {
            let vc = PlanetPassAlertViewController(pointTxt: String(describing: self.passGetPoint))
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    var notEnough: Bool = false {
        didSet {
            let vc = ObAlertViewController(mainMsg: "보유하고 있는\n플래닛 패스가 없습니다", subMsg: "", heightValue: 0.2, btnTitle: "확인", isTimer: false)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    var prevPoint : Int = 0
    var passGetPoint : Int = 0
    var usePassDataLst : UsePlanetPassEntity?
    
    init(prevPoint: Int) {
        self.prevPoint = prevPoint
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        passCV.delegate = self
        passCV.dataSource = self
        passCV.register(UINib(nibName: "PlanitPassCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "passCell")
        passCV.decelerationRate = .fast
        passCV.isPagingEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showIndicator()
        PlanitPassInfoDataManager().showPassInfo(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPass(_:)), name: NSNotification.Name("dismissPass"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dismissPass"), object: nil)
    }

    

    // MARK: Functions
    func setUI() {
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        passCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
        pageCtrl.isUserInteractionEnabled = false
    }
    
    @objc func dismissPass(_ noti: Notification) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePageTapped(_ sender: UIButton) {
        
        switch sender {
        case self.nextPageBtn:
            switch currentIdx {
            case 0:
                currentIdx += 1
                let idxPath = IndexPath(item: self.currentIdx, section: 0)
                self.passCV.scrollToItem(at: idxPath, at: .centeredHorizontally, animated: true)
                
            case 1:
                currentIdx += 1
                let idxPath = IndexPath(item: self.currentIdx, section: 0)
                self.passCV.scrollToItem(at: idxPath, at: .centeredHorizontally, animated: true)
                
            default:
                return
            }
            
        default:
            switch currentIdx {
            case 2:
                currentIdx -= 1
                let idxPath = IndexPath(item: self.currentIdx, section: 0)
                self.passCV.scrollToItem(at: idxPath, at: .centeredHorizontally, animated: true)
                
            case 1:
                currentIdx -= 1
                let idxPath = IndexPath(item: self.currentIdx, section: 0)
                self.passCV.scrollToItem(at: idxPath, at: .centeredHorizontally, animated: true)
                
            default:
                return
            }
        }
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        showIndicator()
        UsePlanetPassDataManager().usePlanetPass(planetId: (currentIdx + 1) , viewController: self)
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        let vc = AlertViewController(mainMsg: "플래닛 패스를 닫으시겠습니까?", subMsg: "", btnTitle: "확인", isTimer: false, isLogout: false, studyRemove: false, passMode: true)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension PlanitPassViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentIdx = Int(scrollView.contentOffset.x / width)
        
        guard let data = self.passInfo?.planets else { return }
        
        if passInfo?.planets.count != 0 {
            
            let nameTxt = String(describing: data[currentIdx].name)
            let desTxt = String(describing: data[currentIdx].description)
            
            switch currentIdx {
            case 0:
                self.planitNameLbl.text = "\(nameTxt)"
                self.pointLbl.text = "\(desTxt)"
                
            case 1:
                self.planitNameLbl.text = "\(nameTxt)"
                self.pointLbl.text = "\(desTxt)"
                
            default:
                self.planitNameLbl.text = "\(nameTxt)"
                self.pointLbl.text = "\(desTxt)"
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "passCell", for: indexPath) as? PlanitPassCollectionViewCell else { return UICollectionViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.imgView.image = UIImage(named: "planet01")
        case 1:
            cell.imgView.image = UIImage(named: "planet02")
        default:
            cell.imgView.image = UIImage(named: "planet03")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(32)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.passCV.bounds.width - 32, height: self.passCV.bounds.height)
    }
    
    
}



extension PlanitPassViewController {
    func showPassInfo(result: PlanitPassInfoEntity) {
        dismissIndicator()
        self.passInfo = result
    }
    
    
    func usePlanetPass(result: UsePlanetPassEntity) {
        self.usePassDataLst = result
        
        if usePassDataLst != nil {
            guard let star = usePassDataLst?.star else { return }
            self.passGetPoint = star - self.prevPoint
        }
    }
}
