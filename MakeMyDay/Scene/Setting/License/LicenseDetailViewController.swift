//
//  LicenseDetailViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/22.
//

import UIKit

class LicenseDetailViewController: BaseViewController {
    let mainView = LicenseDetailView()
    lazy var licenseDescription = """
                    """
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.textView.text = licenseDescription
    }
}
