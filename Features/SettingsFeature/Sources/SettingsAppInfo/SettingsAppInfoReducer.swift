//
//  AppInfoReducer.swift
//  SettingsFeature
//
//  Created by Y on 5/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Core
import Domain
import MessageUI
import ComposableArchitecture

@Reducer
public struct SettingsAppInfoReducer {
    @ObservableState
    public struct State: Equatable {
        public var currentVersion = ""
        public var isLatestVersion: Bool = false
        public var showMailComposer = false
    }
    
    public enum Action {
        case dismissButtonTapped
        
        case checkVersion
        case checkVersionResponse(Result<Bool, Error>)
        case updateButtonTapped
        case developerInstagramLinkTapped
        case appInstagramLinkTapped
        case emailButtonTapped
        case mailComposerDismissed
    }
    
    @Dependency(\.appVersionService) var appVersionService: AppVersionServiceProtocol
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.openURL) var openURL: OpenURLEffect
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped:
                return .none
            case .checkVersion:
                return .run { send in
                    let isLatest = appVersionService.isLatestVersion
                    await send(.checkVersionResponse(.success(isLatest())))
                } catch: { error, send in
                    await send(.checkVersionResponse(.failure(error)))
                }
            case let .checkVersionResponse(.success(isLatest)):
                state.isLatestVersion = isLatest
                state.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                return .none
                
            case .checkVersionResponse(.failure):
                return .none
                
            case .updateButtonTapped:
                @Environment(\.openURL) var openURL: OpenURLAction
                if let url = appVersionService.getUpdateURL() {
                    openURL(url)
                }
             
                return .none
                
            case .developerInstagramLinkTapped:
                return .run { _ in
                    let appURL = URL(string: "instagram://user?username=_yyyng")!
                    if await UIApplication.shared.canOpenURL(appURL) {
                        await openURL(appURL)
                    } else {
                        let webURL = URL(string: "https://instagram.com/_yyyng")!
                        await openURL(webURL)
                    }
                }
                
            case .appInstagramLinkTapped:
                return .run { _ in
                    let appURL = URL(string: "instagram://user?username=makemyday_app")!
                    if await UIApplication.shared.canOpenURL(appURL) {
                        await openURL(appURL)
                    } else {
                        let webURL = URL(string: "https://instagram.com/makemyday_app")!
                        await openURL(webURL)
                    }
                }
                
            case .emailButtonTapped:
                if MFMailComposeViewController.canSendMail() {
                    state.showMailComposer = true
                } else {
                    return .run { _ in
                        if let url = URL(string: "mailto:yyyng2@gmail.com?subject=[MakeMyDay]%20문의") {
                            await openURL(url)
                        }
                    }
                }
                return .none
                
            case .mailComposerDismissed:
                state.showMailComposer = false
                return .none
            }
        }
      
    }
}
