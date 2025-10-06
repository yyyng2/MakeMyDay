import SwiftUI
import Data
import Domain
import UIComponents
import Utilities
import Resources
import ComposableArchitecture

public struct HomeView: View {
    @Bindable
    var store: StoreOf<HomeReducer>
    @AppStorage("bannerAdHeight") private var storedBannerAdHeight: Double = 60
    @State private var bannerAdHeight: Double = 60
    @FocusState private var isTextFieldFocused: Bool
    @State private var scrollProxy: ScrollViewProxy?
    
    public init(store: StoreOf<HomeReducer>) {
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
                            ScrollViewReader { proxy in
                                ScrollView(.vertical) {
                                    Spacer()
                                        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 70 : 20)
                                    VStack(spacing: 15) {
                                        ChatBubbleView(
                                            profileImage: store.currentImage,
                                            userNickname: store.userNickname,
                                            message: store.welcomeMessage,
                                            messageType: .systemMessage,
                                            item: nil,
                                            store: store
                                        )
                                        
                                        if !store.todaySchedules.isEmpty {
                                            ChatBubbleView(
                                                profileImage: store.currentImage,
                                                userNickname: store.userNickname,
                                                message: "home_schedule_exist".localized(),
                                                messageType: .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                            
                                            ForEach(store.todaySchedules, id: \.id) { schedule in
                                                ChatBubbleView(
                                                    profileImage: nil,
                                                    userNickname: store.userNickname,
                                                    message: "",
                                                    messageType: .schedule,
                                                    item: schedule,
                                                    store: store
                                                )
                                            }
                                        } else {
                                            ChatBubbleView(
                                                profileImage: store.currentImage,
                                                userNickname: store.userNickname,
                                                message: "home_schedule_none".localized(),
                                                messageType: .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                        }
                                        
                                        if !store.todayDDays.isEmpty {
                                            ChatBubbleView(
                                                profileImage: store.currentImage,
                                                userNickname: store.userNickname,
                                                message: "home_dday_exist".localized(),
                                                messageType: .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                            
                                            ForEach(store.todayDDays, id: \.id) { dday in
                                                ChatBubbleView(
                                                    profileImage: nil,
                                                    userNickname: store.userNickname,
                                                    message: "",
                                                    messageType: .dday,
                                                    item: dday,
                                                    store: store
                                                )
                                            }
                                        } else {
                                            ChatBubbleView(
                                                profileImage: store.currentImage,
                                                userNickname: store.userNickname,
                                                message: "home_dday_none".localized(),
                                                messageType: .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                        }
                                        
                                        if store.showWeatherInfo {
                                            ChatBubbleView(
                                                profileImage: nil,
                                                userNickname: store.userNickname,
                                                message: "지금 날씨 어때?",
                                                messageType: .userMessage,
                                                item: nil,
                                                store: store
                                            )
                                            
                                            ChatBubbleView(
                                                profileImage: store.currentImage,
                                                userNickname: store.userNickname,
                                                message: "오늘의 날씨를 알려드릴게요.",
                                                messageType: .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                            
                                            if let weather = store.currentWeather {
                                                ChatBubbleView(
                                                    profileImage: nil,
                                                    userNickname: store.userNickname,
                                                    message: "최저 \(Int(weather.minTemp))°C, 최고 \(Int(weather.maxTemp))°C",
                                                    messageType: .weather,
                                                    item: nil,
                                                    store: store
                                                )
                                                
                                                ChatBubbleView(
                                                    profileImage: nil,
                                                    userNickname: store.userNickname,
                                                    message: "오늘 하루 \(weather.condition) 날씨가 예상됩니다.",
                                                    messageType: .weather,
                                                    item: nil,
                                                    store: store
                                                )
                                            }
                                        }
                                        
                                        ForEach(store.chatMessages) { message in
                                            ChatBubbleView(
                                                profileImage: message.isUser ? nil : store.currentImage,
                                                userNickname: store.userNickname,
                                                message: message.text,
                                                messageType: message.isUser ? .userMessage : .systemMessage,
                                                item: nil,
                                                store: store
                                            )
                                        }
                                        
                                        Color.clear
                                            .frame(height: 80)
                                            .id("bottom")
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .background {
                                    Color.clear.ignoresSafeArea()
                                }
                                .scrollContentBackground(.hidden)
                                .scrollIndicators(.hidden)
                                .onAppear {
                                    scrollProxy = proxy
                                }
                                .onChange(of: store.chatMessages.count) { _, _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            proxy.scrollTo("bottom", anchor: .bottom)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .background {
                        Image(uiImage: ResourcesAsset.Assets.baseBackground.image)
                            .resizable()
                            .ignoresSafeArea()
                    }
                    
                    VStack {
                        Spacer()
                        
//                        if store.showMenuOptions {
//                            VStack(spacing: 10) {
//                                Button {
//                                    store.send(.magic8BallTapped)
//                                } label: {
//                                    Text("내 고민 어떻게 생각해?")
//                                        .frame(maxWidth: .infinity)
//                                        .padding()
//                                        .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
//                                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                                }
//                                
//                                if !store.showWeatherInfo {
//                                    Button {
//                                        store.send(.weatherTapped)
//                                    } label: {
//                                        Text("오늘 날씨 어때?")
//                                            .frame(maxWidth: .infinity)
//                                            .padding()
//                                            .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
//                                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                                    }
//                                }
//                                
//                                if store.chatMessages.count > 0 {
//                                    Button {
//                                        store.send(.clearChat)
//                                    } label: {
//                                        Text("채팅 지우기")
//                                            .tint(.red)
//                                            .frame(maxWidth: .infinity)
//                                            .padding()
//                                            .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
//                                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                            .padding(.bottom, 10)
//                        }
                        
//                        FloatingButtonView(
//                            buttonAction: { store.send(.textFieldTapped) },
//                            buttonAction: {
//                                fatalError("Crash was triggered")
//                              },
//                            buttonImageName: "message"
//                        )
                        
//                        HStack {
//                            Button {
//                                isTextFieldFocused = false
//                                store.send(.textFieldTapped)
//                            } label: {
//                                HStack {
//                                    Text("메시지를 입력하세요...")
//                                        .foregroundColor(.gray)
//                                    Spacer()
//                                }
//                                .padding()
//                                .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.bottom, 20)
                    }
                }
//                .onTapGesture {
//                    if store.showMenuOptions {
//                        store.send(.dismissMenu)
//                    }
//                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
//        .alert("위치 권한", isPresented: .init(
//            get: { store.showLocationAlert },
//            set: { _ in store.send(.dismissAlert) }
//        )) {
//            Button("설정으로") {
//                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(settingsUrl)
//                }
//                store.send(.dismissAlert)
//            }
//            Button("취소", role: .cancel) {
//                store.send(.dismissAlert)
//            }
//        } message: {
//            Text(store.alertMessage)
//        }
//        .alert("날씨 오류", isPresented: .init(
//            get: { store.showWeatherAlert },
//            set: { _ in store.send(.dismissAlert) }
//        )) {
//            Button("확인") {
//                store.send(.dismissAlert)
//            }
//        } message: {
//            Text(store.alertMessage)
//        }
    }
}

struct ChatBubbleView: View {
    let profileImage: UIImage?
    let userNickname: String
    let message: String
    let messageType: MessageType
    let item: Any?
    @State private var store: StoreOf<HomeReducer>
    
    init(profileImage: UIImage?,
         userNickname: String,
         message: String,
         messageType: MessageType,
         item: Any? = nil,
         store: StoreOf<HomeReducer>) {
        self.profileImage = profileImage
        self.userNickname = userNickname
        self.message = message
        self.messageType = messageType
        self.item = item
        self._store = State(initialValue: store)
    }
    
    @ViewBuilder
    var messageContent: some View {
        switch messageType {
        case .userMessage, .systemMessage:
            Text(message)
                .padding(12)
                .background(
                    Color(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(maxWidth: 250, alignment: messageType == .userMessage ? .trailing : .leading)
            
        case .weather:
            Text(message)
                .padding(12)
                .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(maxWidth: 250, alignment: .leading)
            
        case .schedule:
            if let schedule = item as? Schedule {
                VStack(alignment: .center, spacing: 4) {
                    Text(schedule.title)
                        .font(.headline)
                        .lineLimit(1)
                    HStack {
                        Text(schedule.isWeeklyRepeat ? schedule.date.formattedWeekday() : schedule.date.formattedYyyyMmDdWithWeekday())
                            .font(.caption)
                            .lineLimit(1)
                        Text(schedule.date.formattedTime())
                            .foregroundStyle(.mint)
                            .font(.caption)
                            .lineLimit(1)
                        if schedule.isWeeklyRepeat {
                            Text("schedule_weekOption".localized())
                                .foregroundStyle(.orange)
                                .font(.caption2)
                                .padding(.horizontal, 4)
                                .background(Color.orange.opacity(0.2))
                                .clipShape(.capsule)
                        }
                    }
                }
                .padding(12)
                .frame(maxWidth: 250)
                .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
        case .dday:
            if let dday = item as? DDay {
                VStack(alignment: .center, spacing: 4) {
                    Text(dday.title)
                        .font(.headline)
                        .lineLimit(1)
                    HStack {
                        Text(
                            dday.isAnniversary
                             ? dday.date.getNextAnniversaryCount() + " " + dday.date.formattedMmDdWithWeekday()
                             : dday.date.formattedYyyyMmDdWithWeekday()
                        )
                            .font(.caption)
                            .lineLimit(1)
                        Text("D\(dday.daysCalculate().formattedDDay())")
                            .foregroundStyle(.mint)
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
                .padding(12)
                .frame(maxWidth: 250)
                .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            switch messageType {
            case .systemMessage:
                if let image = profileImage {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(ResourcesAsset.Assets.baseFontColor.color), lineWidth: 2))
                        
                        Text(userNickname)
                            .font(.caption)
                            .frame(height: 5)
                    }
                } else {
                    Color.clear
                        .frame(width: 45, height: 45)
                }
                
                messageContent
                Spacer()
            case .dday, .schedule, .weather:
                Color.clear
                    .frame(width: 45, height: 45)
                
                messageContent
                Spacer()
            case .userMessage:
                Spacer()
                messageContent
            }
            
            
        }
    }
}
