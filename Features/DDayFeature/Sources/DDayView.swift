import SwiftUI
import Domain
import UIComponents
import Utilities
import ComposableArchitecture

public struct DDayView: View {
    @Bindable
    var store: StoreOf<DDayReducer>
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<DDayReducer>) {
        self.store = store
        _bannerAdHeight = State(initialValue: storage.get(.bannerAdHeight, defaultValue: 60.0))
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geometry in
                ZStack {
                    NavigationStack {
                        Spacer()
                            .frame(height: bannerAdHeight == 0 ? 60 : bannerAdHeight)
                        
                        VStack {
                            ScrollView(.vertical) {
                                Spacer()
                                    .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 70 : 20)
                                VStack {
                                    if store.ddays.isEmpty {
                                        Button {
                                               store.send(.editDDayTapped(nil))
                                           } label: {
                                               VStack(alignment: .center) {
                                                   HStack {
                                                       Spacer()
                                                       VStack {
                                                           Text(localeService.localized(forKey: .ddayEmpty))
                                                               .font(.headline)
                                                               .lineLimit(1)
                                                           HStack {
                                                               Text(Date().formattedYyyyMmDdWithWeekday())
                                                                   .font(.caption)
                                                                   .lineLimit(1)
                                                           }
                                                       }
                                                       Spacer()
                                                       Text("D-Day")
                                                           .foregroundStyle(.mint)
                                                           .font(.caption)
                                                           .lineLimit(1)
                                                       Spacer()
                                                   }
                                               }
                                               .frame(height: 50)
                                               .frame(maxWidth: .infinity)
                                               .background(
                                                    colorProvider.color(asset: .baseForeground)
                                               )
                                               .clipShape(.rect(cornerRadius: 10))
                                           }
                                           .padding(.horizontal, 20)
                                           .padding(.bottom, 10)
                                    } else {
                                        ForEach(store.ddays, id: \.id) { item in
                                            VStack(alignment: .center) {
                                                HStack {
                                                    Button {
                                                        store.send(.editDDayTapped(item))
                                                        
                                                    } label: {
                                                        VStack(alignment: .center) {
                                                            HStack {
                                                                Spacer()
                                                                VStack {
                                                                    Text(item.title)
                                                                        .font(.headline)
                                                                        .lineLimit(1)
                                                                    HStack {
                                                                        Text(
                                                                            item.isAnniversary
                                                                            ? item.date.getNextAnniversaryCount() + " " + item.date.formattedMmDdWithWeekday()
                                                                            : item.date.formattedYyyyMmDdWithWeekday()
                                                                        )
                                                                        .font(.caption)
                                                                        .lineLimit(1)
                                                                        
                                                                    }
                                                                }
                                                                Spacer()
                                                                Text("D\(item.daysCalculate().formattedDDay())")
                                                                    .foregroundStyle(.mint)
                                                                    .font(.caption)
                                                                    .lineLimit(1)
                                                                Spacer()
                                                            }
                                                        }
                                                        .frame(width: geometry.size.width - 40, height: 50)
                                                        .background(
                                                            colorProvider.color(asset: .baseForeground)
                                                        )
                                                        .clipShape(.rect(cornerRadius: 10))
                                                        .contextMenu {
                                                            Button {
                                                                store.send(.deleteDDay(item))
                                                            } label: {
                                                                Label(
                                                                    localeService.localized(forKey: .commonDelete),
                                                                    systemImage: "trash.circle"
                                                                )
                                                                    .tint(.red)
                                                            }
                                                        }
                                                    }
                                                }
                                                .frame(height: 50)
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                                .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            //                            .frame(height: geometry.size.height - bannerAdHeight)
                            .safeAreaInset(edge: .bottom) {
                                Color.clear
                                    .frame(height: 0)
                            }
                            //                            .safeAreaInset(edge: .top) {
                            //                                Color.clear
                            //                                    .frame(height: bannerAdHeight)
                            //                            }
                            .onAppear {
                                let storedHeight = storage.get(.bannerAdHeight, defaultValue: 60.0)
                                if bannerAdHeight < storedHeight {
                                    bannerAdHeight = storedHeight
                                }
                            }
                            .onChange(of: bannerAdHeight) { oldValue, newValue in
                                storage.set(.bannerAdHeight, value: newValue)
                            }
                        }
                    }
                    .background {
                        Image(uiImage: imageProvider.image(asset: .baseBackground))
                            .resizable()
                            .ignoresSafeArea()
                    }
                }
                .overlay(
                    ZStack {
                        if store.isSortPresented {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    store.send(.setSortPresented(false))
                                }
                        }
                        
                        VStack {
                            Spacer()
                            
                            if store.isSortPresented {
                                SortPopupView(
                                    currentSortType: store.currentSortType,
                                    onSortSelected: { sortType in
                                        store.send(.sortSelected(sortType))
                                    },
                                    onDismiss: {
                                        store.send(.setSortPresented(false))
                                    },
                                    localized: { rawValue in
                                        if let key = localeService.getKeyByRawValue(rawValue: rawValue) {
                                            return localeService.localized(forKey: key)
                                        } else {
                                            return rawValue 
                                        }
                                    },
                                    backgroundColor: colorProvider.color(asset: .baseForeground)
                                )
                                .padding(.bottom, 150)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.easeInOut(duration: 0.2), value: store.isSortPresented)
                            }
                            
                            Spacer()
                        }
                        
                        FloatingButtonView(
                            buttonAction: { store.send(.sortButtonTapped) },
                            buttonImageName: "arrow.up.arrow.down",
                            buttonImgaeTintColor: colorProvider.color(asset: .baseFontColor),
                            buttonBackgroundColor: colorProvider.color(asset: .baseForeground),
                            buttonBorderColor: colorProvider.color(asset: .baseBorder),
                            buttonBottomPadding: 90
                        )
                        
                        FloatingButtonView(
                            buttonAction: { store.send(.editDDayTapped(nil)) },
                            buttonImgaeTintColor: colorProvider.color(asset: .baseFontColor),
                            buttonBackgroundColor: colorProvider.color(asset: .baseForeground),
                            buttonBorderColor: colorProvider.color(asset: .baseBorder)
                        )
                    }
                )
                .sheet(isPresented: $store.isEditSheetPresented.sending(\.setEditSheet)) {
                    if let editingDDay = store.editingDDay {
                        DDayEditView(
                            dday: editingDDay,
                            onSave: { updatedDDay in
                                store.send(.saveDDay(updatedDDay))
                            },
                            onCancel: {
                                store.send(.setEditSheet(isPresented: false))
                            }
                        )
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

public struct SortPopupView: View {
    let currentSortType: DDaySortType
    let onSortSelected: (DDaySortType) -> Void
    let onDismiss: () -> Void
    let localized: (String) -> String
    let backgroundColor: Color
    
    private let sortPairs: [(DDaySortType, DDaySortType)] = [
        (.titleAsc, .titleDesc),
        (.dateAsc, .dateDesc),
        (.ddayAsc, .ddayDesc)
    ]
    
    public init(currentSortType: DDaySortType, onSortSelected: @escaping (DDaySortType) -> Void, onDismiss: @escaping () -> Void, localized: @escaping (String) -> String, backgroundColor: Color) {
        self.currentSortType = currentSortType
        self.onSortSelected = onSortSelected
        self.onDismiss = onDismiss
        self.localized = localized
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            ForEach(Array(sortPairs.enumerated()), id: \.offset) { index, pair in
                HStack(spacing: 10) {
                    Button(action: {
                        onSortSelected(pair.0)
                    }) {
                        HStack {
                            Text(localized(pair.0.rawValue))
                                .font(.headline)
                            Spacer()
                            if currentSortType == pair.0 {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.mint)
                            }
                        }
                        .padding()
                        .background(backgroundColor)
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        onSortSelected(pair.1)
                    }) {
                        HStack {
                            Text(localized(pair.1.rawValue))
                                .font(.headline)
                            Spacer()
                            if currentSortType == pair.1 {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.mint)
                            }
                        }
                        .padding()
                        .background(backgroundColor)
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.thinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
        .frame(maxWidth: 300)
    }
}
