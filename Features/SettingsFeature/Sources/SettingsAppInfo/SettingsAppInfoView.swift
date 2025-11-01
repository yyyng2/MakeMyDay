//
//  AppInfoView.swift
//  SettingsFeature
//
//  Created by Y on 5/1/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import Resources
import UIComponents
import ComposableArchitecture

public struct SettingsAppInfoView: View {
    @Bindable
    public var store: StoreOf<SettingsAppInfoReducer>
    @Dependency(\.appStorageRepository) var storage
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsAppInfoReducer>) {
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
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .frame(height: 200)
                
                Image(uiImage: ResourcesAsset.Assets.dIcon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("Make My Day")
                Button {
                    store.send(.developerInstagramLinkTapped)
                } label: {
                    HStack {
                        Text("Developer: Dongyeong Kim")
                        Image(systemName: "link.circle")
                    }
                }

                Text("Illustrator: Heejeong Chae")
                Button {
                    store.send(.emailButtonTapped)
                } label: {
                    HStack {
                        Text("Email: yyyng2@gmail.com")
                        Image(systemName: "mail")
                    }
                }
                
                Button {
                    store.send(.appInstagramLinkTapped)
                } label: {
                    HStack {
                        Text("Contact: @makemyday_app")
                        Image(systemName: "link.circle")
                    }
                }
                
                Spacer()

                Button {
                    if !store.isLatestVersion {
                        store.send(.updateButtonTapped)
                    }
                } label: {
                    VStack {
                        Text(store.currentVersion)
                        if !store.isLatestVersion {
                            Text("Update available")
                                .foregroundStyle(.red)
                            Image(systemName: "app.badge.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .onAppear {
                let storedHeight = storage.get(.bannerAdHeight, defaultValue: 60.0)
                if bannerAdHeight < storedHeight {
                    bannerAdHeight = storedHeight
                }
            }
            .onChange(of: bannerAdHeight) { oldValue, newValue in
                storage.set(.bannerAdHeight, value: newValue)
            }
            .sheet(
                isPresented: Binding(
                    get: { store.showMailComposer },
                    set: { _ in store.send(.mailComposerDismissed) }
                )
            ) {
                MailComposerView(
                    recipients: ["yyyng2@gmail.com"],
                    subject: "[MakeMyDay] 문의",
                    messageBody: ""
                ) { _ in
                    store.send(.mailComposerDismissed)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            store.send(.checkVersion)
        }

    }
}
