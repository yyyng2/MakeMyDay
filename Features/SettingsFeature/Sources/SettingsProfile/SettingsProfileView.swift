//
//  SettingsProfileView.swift
//  SettingsFeature
//
//  Created by Y on 5/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import PhotosUI
import Utilities
import ComposableArchitecture

public struct SettingsProfileView: View {
    @Bindable
    public var store: StoreOf<SettingsProfileReducer>
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsProfileReducer>) {
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
                    VStack(spacing: 30) {
                        Text(localeService.localized(forKey: .settingsProfileImage))
                            .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Image(uiImage: store.currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(colorProvider.color(asset: .baseFontColor), lineWidth: 1))
                        
                        VStack(spacing: 16) {
                            TextField(store.previousNickname, text: Binding(
                                get: { store.nickname },
                                set: { store.send(.nicknameChanged($0)) }
                            ), prompt: Text(store.previousNickname).foregroundColor(.gray))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            
                            Button {
                                store.send(.loadImageButtonTapped)
                            } label: {
                                Text(localeService.localized(forKey: .settingsProfileLoad))
                                    .foregroundStyle(.white)
                                    .frame(width: 200, height: 44)
                                    .background(.mint)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(colorProvider.color(asset: .baseFontColor), lineWidth: 1)
                                    )
                            }
                            
                            Button {
                                store.send(.resetButtonTapped)
                            } label: {
                                Text(localeService.localized(forKey: .settingsProfileReset))
                                    .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                                    .frame(width: 200, height: 44)
                                    .background(.red)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(colorProvider.color(asset: .baseFontColor), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
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
        .photosPicker(
            isPresented: Binding(
                get: { store.showImagePicker },
                set: { _ in store.send(.hideImagePicker) }
            ),
            selection: Binding(
                get: { store.selectedPhoto },
                set: { photo in
                    if let photo = photo {
                        store.send(.photoSelected(photo))
                    }
                }
            ),
            matching: .images
        )
    }
}
