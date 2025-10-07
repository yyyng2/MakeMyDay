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
import Resources
import ComposableArchitecture

public struct SettingsProfileView: View {
    @Bindable
    public var store: StoreOf<SettingsProfileReducer>
    @AppStorage("bannerAdHeight") private var storedBannerAdHeight: Double = 60
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsProfileReducer>) {
        self.store = store
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
                    VStack(spacing: 30) {
                        Text("settings_profile_image".localized())
                            .foregroundStyle(Color(ResourcesAsset.Assets.baseFontColor.color))
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Image(uiImage: store.currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(ResourcesAsset.Assets.baseFontColor.color), lineWidth: 2))
                        
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
                                Text("settings_profile_load".localized())
                                    .foregroundStyle(.white)
                                    .frame(width: 200, height: 44)
                                    .background(.mint)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(ResourcesAsset.Assets.baseFontColor.color), lineWidth: 1)
                                    )
                            }
                            
                            Button {
                                store.send(.resetButtonTapped)
                            } label: {
                                Text("settings_profile_reset".localized())
                                    .foregroundStyle(Color(ResourcesAsset.Assets.baseFontColor.color))
                                    .frame(width: 200, height: 44)
                                    .background(.red)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(ResourcesAsset.Assets.baseFontColor.color), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
            }
            .onAppear {
                if bannerAdHeight < storedBannerAdHeight {
                    bannerAdHeight = storedBannerAdHeight
                }
                store.send(.onAppear)
            }
            .onChange(of: bannerAdHeight) { oldValue, newValue in
                storedBannerAdHeight = newValue
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
