//
//  FAQViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/29.
//

import UIKit
import MessageUI

class FAQViewController: BaseViewController {
    lazy var mainView = FAQView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func configure() {
        mainView.emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
    }
    
    override func setNavigationUI() {
        UINavigationBar.appearance().isTranslucent = false

        navigationBarAppearance.backgroundColor = themeType().foregroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeType().whiteBlackUIColor]

        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func showSendMailErrorAlert() {
           let sendMailErrorAlert = UIAlertController(title: "메일 전송", message: "메일 전송에 실패 했습니다.", preferredStyle: .alert)
           let confirmAction = UIAlertAction(title: "확인", style: .default) {
               (action) in
               print("확인")
           }
           sendMailErrorAlert.addAction(confirmAction)
           self.present(sendMailErrorAlert, animated: true, completion: nil)
       }
    
    @objc func emailButtonTapped(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients(["yyyng2@gmail.com"])
            compseVC.setSubject("[MakeMyDay]문의")
            compseVC.setMessageBody("", isHTML: false)
            
            self.present(compseVC, animated: true, completion: nil)
        
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
}
extension FAQViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          dismiss(animated: true)
      }

}
