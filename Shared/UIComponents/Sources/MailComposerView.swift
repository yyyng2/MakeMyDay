//
//  MailComposerView.swift
//  UIComponents
//
//  Created by Y on 5/01/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import MessageUI

public struct MailComposerView: UIViewControllerRepresentable {
    public let recipients: [String]
    public let subject: String
    public let messageBody: String
    public let result: (Result<MFMailComposeResult, Error>) -> Void
    
    public init(recipients: [String], subject: String, messageBody: String, result: @escaping (Result<MFMailComposeResult, Error>) -> Void) {
        self.recipients = recipients
        self.subject = subject
        self.messageBody = messageBody
        self.result = result
    }
    
    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(recipients)
        mail.setSubject(subject)
        mail.setMessageBody(messageBody, isHTML: false)
        return mail
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        public let parent: MailComposerView
        
        public init(_ parent: MailComposerView) {
            self.parent = parent
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController,
                                 didFinishWith result: MFMailComposeResult,
                                 error: Error?) {
            if let error = error {
                parent.result(.failure(error))
            } else {
                parent.result(.success(result))
            }
            controller.dismiss(animated: true)
        }
    }
}
