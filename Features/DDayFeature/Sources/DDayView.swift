import SwiftUI
import Domain
import UIComponents
import Utilities
import Resources
import ComposableArchitecture

public struct DDayView: View {
    @Bindable
    var store: StoreOf<DDayReducer>
    @AppStorage("bannerAdHeight") private var storedBannerAdHeight: Double = 60
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<DDayReducer>) {
        self.store = store
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
                                                           Text("dday_empty".localized())
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
                                                   Color(ResourcesAsset.Assets.baseForeground.swiftUIColor)
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
                                                            Color(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                                                        )
                                                        .clipShape(.rect(cornerRadius: 10))
                                                        .contextMenu {
                                                            Button {
                                                                store.send(.deleteDDay(item))
                                                            } label: {
                                                                Label("common_delete".localized(), systemImage: "trash.circle")
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
                                if bannerAdHeight < storedBannerAdHeight {
                                    bannerAdHeight = storedBannerAdHeight
                                }
                            }
                            .onChange(of: bannerAdHeight) { oldValue, newValue in
                                storedBannerAdHeight = newValue
                            }
                        }
                    }
                    .background {
                        Image(uiImage: ResourcesAsset.Assets.baseBackground.image)
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
                                    onSortSelected: { sortType in
                                        store.send(.sortSelected(sortType))
                                    },
                                    onDismiss: {
                                        store.send(.setSortPresented(false))
                                    }
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
                            buttonBottomPadding: 90
                        )
                        
                        FloatingButtonView(
                            buttonAction: { store.send(.editDDayTapped(nil)) }
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
    @AppStorage("ddaySortType") private var storedSortType: String = DDaySortType.dateAsc.rawValue
    let onSortSelected: (DDaySortType) -> Void
    let onDismiss: () -> Void
    
    private let sortPairs: [(DDaySortType, DDaySortType)] = [
        (.titleAsc, .titleDesc),
        (.dateAsc, .dateDesc),
        (.ddayAsc, .ddayDesc)
    ]
    
    public var body: some View {
        VStack(spacing: 10) {
            ForEach(Array(sortPairs.enumerated()), id: \.offset) { index, pair in
                HStack(spacing: 10) {
                    Button(action: {
                        storedSortType = pair.0.rawValue
                        onSortSelected(pair.0)
                    }) {
                        HStack {
                            Text(pair.0.rawValue.localized())
                                .font(.headline)
                            Spacer()
                            if storedSortType == pair.0.rawValue {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.mint)
                            }
                        }
                        .padding()
                        .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        storedSortType = pair.1.rawValue
                        onSortSelected(pair.1)
                    }) {
                        HStack {
                            Text(pair.1.rawValue.localized())
                                .font(.headline)
                            Spacer()
                            if storedSortType == pair.1.rawValue {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.mint)
                            }
                        }
                        .padding()
                        .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
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
