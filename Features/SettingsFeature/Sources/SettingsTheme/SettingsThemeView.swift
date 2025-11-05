//
//  SettingsThemeView.swift
//  SettingsFeature
//
//  Created by Y on 5/22/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Utilities
import ComposableArchitecture

public struct SettingsThemeView: View {
    @Bindable
    public var store: StoreOf<SettingsThemeReducer>
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsThemeReducer>) {
        self.store = store
        self._bannerAdHeight = State(initialValue: self.storage.get(.bannerAdHeight, defaultValue: 60.0))
    }
    
    public var body: some View {
        ZStack {
            Color(.clear)
            Image(uiImage: imageProvider.image(asset: .baseBackground))
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
                            .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button {
                        store.send(.saveButtonTapped)
                    } label: {
                        Text(localeService.localized(forKey: .commonSave))
                            .foregroundStyle(store.hasChanges ? colorProvider.color(asset: .baseFontColor) : .gray)
                    }
                    .padding(.trailing, 20)
                    .disabled(!store.hasChanges)
                }
                .frame(height: 200)
                
                GeometryReader { geometry in
                    VStack {
                        Text(localeService.localized(forKey: .settingsThemeTitle))
                            .foregroundStyle(colorProvider.color(asset: .baseFontColor))
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
                                                store.isLightTheme ? colorProvider.color(asset: .baseFontColor) : Color.gray.opacity(0.3),
                                                lineWidth: store.isLightTheme ? 3 : 1
                                            )
                                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.4)
                                        
                                        Image(uiImage: imageProvider.image(asset: .themeColor))
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
                                                !store.isLightTheme ? colorProvider.color(asset: .baseFontColor) : Color.gray.opacity(0.3),
                                                lineWidth: !store.isLightTheme ? 3 : 1
                                            )
                                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.4)

                                        Image(uiImage: imageProvider.image(asset: .themeBlack))
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
