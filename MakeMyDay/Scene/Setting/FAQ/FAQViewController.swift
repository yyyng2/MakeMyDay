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
        self.view = mainView
    }
    
    override func configure() {
        mainView.emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        mainView.instaButton.addTarget(self, action: #selector(instaButtonTapped), for: .touchUpInside)
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
        let sendMailErrorAlert = UIAlertController(title: "mail".localized, message: "mailFailed".localized, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "okay".localized, style: .default) {
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
            compseVC.setSubject("[MakeMyDay]")
            compseVC.setMessageBody("", isHTML: false)
            
            self.present(compseVC, animated: true, completion: nil)
        
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    @objc func instaButtonTapped() {
        let instagram = "https://www.instagram.com/makemyday_app"
          
          let instagramURL = NSURL(string: instagram)
          
          if UIApplication.shared.canOpenURL(instagramURL! as URL) {
              UIApplication.shared.open(
              instagramURL! as URL,
              options: [:],
              completionHandler: nil
              )
          }
    }
    
}
extension FAQViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
          dismiss(animated: true)
      }

}
