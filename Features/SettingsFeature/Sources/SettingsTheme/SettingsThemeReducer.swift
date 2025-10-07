//
//  SettingsThemeReducer.swift
//  SettingsFeature
//
//  Created by Y on 5/22/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Core
import Data
import Domain
import ComposableArchitecture

@Reducer
public struct SettingsThemeReducer {
    @ObservableState
    public struct State: Equatable {
        public var isLightTheme: Bool = true
        public var hasChanges: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        case dismissButtonTapped
        case saveButtonTapped
        case themeSelected(Bool)
        case onAppear
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsClient) var userDefaultsClient: UserDefaultsClient
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped:
                return .run { _ in
                    await dismiss()
                }
                
            case .saveButtonTapped:
                userDefaultsClient.setBool(UserDefaultsKey.isLightTheme, state.isLightTheme)
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                windowScene?.windows.forEach { window in
                    window.overrideUserInterfaceStyle = state.isLightTheme ? .light : .dark
                }
                
                state.hasChanges = false
                return .run { _ in
                    await dismiss()
                }
                
            case let .themeSelected(isLight):
                let previous = state.isLightTheme
                state.isLightTheme = isLight
                state.hasChanges = (isLight != previous)
                return .none
                
            case .onAppear:
                state.isLightTheme = userDefaultsClient.getBool(UserDefaultsKey.isLightTheme)
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                windowScene?.windows.forEach { window in
                    window.overrideUserInterfaceStyle = state.isLightTheme ? .light : .dark
                }
                return .none
            }
        }
    }
}
