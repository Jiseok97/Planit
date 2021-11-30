//
//  TermsAlertViewController.swift
//  Cash Study
//
//  Created by 이지석 on 2021/11/30.
//

import UIKit
import PDFKit

class TermsAlertViewController: UIViewController {
    
    @IBOutlet weak var pdfAlertView: PDFView!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var idx: Int = 0
    
    init(idx: Int) {
        self.idx = idx
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    
    // MARK: Funcions
    func setUI() {
        self.confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        
        switch idx {
        case 1:
            let urlStr = "https://assets.planit-study.com/1.usage_agreements_required.pdf"
            
            if let url = URL(string: urlStr),
               let doc = PDFDocument(url: url) {
                    loadPdfView(document: doc)
            }
            
        case 2:
            let urlStr = "https://assets.planit-study.com/2.personal_information_agreement_required.pdf"
            
            if let url = URL(string: urlStr),
               let doc = PDFDocument(url: url) {
                    loadPdfView(document: doc)
            }
            
        case 3:
            let urlStr = "https://assets.planit-study.com/3.personal_information_agreement_select.pdf"
            
            if let url = URL(string: urlStr),
               let doc = PDFDocument(url: url) {
                    loadPdfView(document: doc)
            }
            
        default:
            let urlStr = "https://assets.planit-study.com/4.alert_agreement_select.pdf"
            
            if let url = URL(string: urlStr),
               let doc = PDFDocument(url: url) {
                    loadPdfView(document: doc)
            }
            
        }
        
    }
    
    func loadPdfView(document: PDFDocument) {
        pdfAlertView.layer.cornerRadius = 8
        pdfAlertView.autoScales = true
        pdfAlertView.displayMode = .singlePageContinuous
        pdfAlertView.displayDirection = .vertical
        pdfAlertView.document = document
    }

    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
