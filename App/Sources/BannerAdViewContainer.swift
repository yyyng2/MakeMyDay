import SwiftUI
import GoogleMobileAds

public struct BannerViewContainer: UIViewRepresentable {
    @Binding public var adSize: AdSize

    public init(adSize: Binding<AdSize>) {
        self._adSize = adSize
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.addSubview(context.coordinator.bannerView)
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.bannerView.adSize = adSize
    }
    
    public func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
}

public class BannerCoordinator: NSObject, ObservableObject, BannerViewDelegate {
    @Published var adSize: AdSize
    
    private(set) lazy var bannerView: BannerView = {
        let banner = BannerView(adSize: adSize)
        if let unitID = Bundle.main.object(forInfoDictionaryKey: "GADBannerUnitID") as? String {
            banner.adUnitID = unitID
        }
        banner.load(Request())
        banner.delegate = self
        return banner
    }()
    
    let parent: BannerViewContainer
    
    init(_ parent: BannerViewContainer) {
        self.parent = parent
        self.adSize = parent.adSize
        super.init()
    }
    
    func updateAdSize(_ newSize: AdSize) {
        self.adSize = newSize
        bannerView.adSize = newSize
    }
}
