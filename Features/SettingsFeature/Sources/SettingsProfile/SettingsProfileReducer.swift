//
//  SettingsProfileReducer.swift
//  SettingsFeature
//
//  Created by Y on 5/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import PhotosUI
import Utilities
import ComposableArchitecture

@Reducer
public struct SettingsProfileReducer {
    @ObservableState
    public struct State: Equatable {
        public var currentImage: UIImage = UIImage()
        public var hasChanges: Bool = false
        public var showImagePicker: Bool = false
        public var selectedPhoto: PhotosPickerItem? = nil
        public var isUsingCustomImage: Bool = false
        public var nickname: String = ""
        public var previousNickname: String = ""
        
        public init() {}
    }
    
    public enum Action {
        case dismissButtonTapped
        case saveButtonTapped
        case loadImageButtonTapped
        case resetButtonTapped
        case photoSelected(PhotosPickerItem?)
        case hideImagePicker
        case imageLoaded(UIImage)
        case nicknameChanged(String)
        case onAppear
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.imageProvider) var imageProvider
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismissButtonTapped:
                return .run { _ in
                    await dismiss()
                }
                
            case .saveButtonTapped:
                userDefaultsClient.setBool(.isUsingCustomImage, state.isUsingCustomImage)
                userDefaultsClient.setString(.userNickname, state.nickname)
                
                if state.isUsingCustomImage {
                    if let imageData = state.currentImage.pngData() {
                        userDefaultsClient.setData(.userProfileImage, imageData)
                    }
                } else {
                    userDefaultsClient.setData(.userProfileImage, nil)
                }
                
                state.hasChanges = false
                return .run { _ in
                    await dismiss()
                }
                
            case .loadImageButtonTapped:
                state.showImagePicker = true
                return .none
                
            case .resetButtonTapped:
                state.currentImage = imageProvider.image(asset: .dIcon)
                state.isUsingCustomImage = false
                state.nickname = "D"
                state.hasChanges = true
                return .none
                
            case .photoSelected(let photo):
                state.selectedPhoto = photo
                guard let photo = photo else { return .none }
                
                return .run { send in
                    do {
                        if let data = try await photo.loadTransferable(type: Data.self) {
                            if let originalImage = UIImage(data: data) {
                                let resizedImage = originalImage.resizedWithAspectRatio(maxSize: 100)
                                await send(.imageLoaded(resizedImage))
                            }
                        }
                    } catch {
                        print("이미지 로드 실패: \(error)")
                    }
                    await send(.hideImagePicker)
                }
                
            case .hideImagePicker:
                state.showImagePicker = false
                state.selectedPhoto = nil
                return .none
                
            case .imageLoaded(let image):
                state.currentImage = image
                state.isUsingCustomImage = true
                state.hasChanges = true
                return .none
                
            case .nicknameChanged(let nickname):
                state.nickname = nickname
                state.hasChanges = (nickname != state.previousNickname) || state.isUsingCustomImage
                return .none
                
            case .onAppear:
                let isCustom = userDefaultsClient.getBool(.isUsingCustomImage)
                var savedNickname = userDefaultsClient.getString(.userNickname)
                if savedNickname == "" {
                    savedNickname = "D"
                }
                state.nickname = savedNickname
                state.previousNickname = savedNickname
                
                if isCustom,
                   let imageData = userDefaultsClient.getData(.userProfileImage),
                   let savedImage = UIImage(data: imageData) {
                    state.currentImage = savedImage
                    state.isUsingCustomImage = true
                } else {
                    state.currentImage = imageProvider.image(asset: .dIcon)
                    state.isUsingCustomImage = false
                }
                return .none
            }
        }
    }
}
