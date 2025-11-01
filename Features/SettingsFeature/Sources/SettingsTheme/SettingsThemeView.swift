//
//  SettingsThemeView.swift
//  SettingsFeature
//
//  Created by Y on 5/22/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Utilities
import Resources
import ComposableArchitecture

public struct SettingsThemeView: View {
    @Bindable
    public var store: StoreOf<SettingsThemeReducer>
    @Dependency(\.appStorageRepository) var storage
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsThemeReducer>) {
        self.store = store
        self._bannerAdHeight = State(initialValue: self.storage.get(.bannerAdHeight, defaultValue: 60.0))
    }
    
    public var body: some View {
        ZStack {
            Color(.clear)
            Image(uiImage: ResourcesAsset.Assets.baseBackground.image)
                .resizable()
                .ignoresSafeArea(.all)
            
            Spacer()
                .frame(height: bannerAdHeight == 0 ? 60 : bannerAdHeight)
            
            VStack {
                HStack {
                    Button {
                        store.send(.dismissButtonTapped)
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Settings")
                            .foregroundStyle(Color(ResourcesAsset.Assets.baseFontColor.color))
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button {
                        store.send(.saveButtonTapped)
                    } label: {
                        Text("common_save".localized())
                            .foregroundStyle(store.hasChanges ? Color(ResourcesAsset.Assets.baseFontColor.color) : .gray)
                    }
                    .padding(.trailing, 20)
                    .disabled(!store.hasChanges)
                }
                .frame(height: 200)
                
                GeometryReader { geometry in
                    VStack {
                        Text("settings_theme_themeTitle".localized())
                            .foregroundStyle(Color(ResourcesAsset.Assets.baseFontColor.color))
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 40)
                        
                        HStack(spacing: 40) {
                            VStack(spacing: 16) {
                                Button {
                                    store.send(.themeSelected(true))
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                store.isLightTheme ? Color(ResourcesAsset.Assets.baseFontColor.color) : Color.gray.opacity(0.3),
                                                lineWidth: store.isLightTheme ? 3 : 1
                                            )
                                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.4)
                                        
                                        Image(uiImage: ResourcesAsset.Assets.themeColor.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.38)
                                            .clipped()
                                            .cornerRadius(16)
                                            .scaleEffect(store.isLightTheme ? 1.1 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: store.isLightTheme)
                                        
                                    }
                                }
                                
                                
                            }

                            VStack(spacing: 16) {
                                Button {
                                    store.send(.themeSelected(false))
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                !store.isLightTheme ? Color(ResourcesAsset.Assets.baseFontColor.color) : Color.gray.opacity(0.3),
                                                lineWidth: !store.isLightTheme ? 3 : 1
                                            )
                                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.4)

                                        Image(uiImage: ResourcesAsset.Assets.themeBlack.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.38)
                                            .clipped()
                                            .cornerRadius(16)
                                            .scaleEffect(!store.isLightTheme ? 1.1 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: !store.isLightTheme)
                                    }
                                }
                                
                                
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                }
            }
            .onAppear {
                let storedHeight = storage.get(.bannerAdHeight, defaultValue: 60.0)
                if bannerAdHeight < storedHeight {
                    bannerAdHeight = storedHeight
                }
                store.send(.onAppear)
            }
            .onChange(of: bannerAdHeight) { oldValue, newValue in
                storage.set(.bannerAdHeight, value: newValue)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
    }
}
