import SwiftUI
import Domain
import Utilities
import Resources

public struct DDayItemView: View {
    let dday: DDay
    let onTap: () -> Void
    let onLongPress: () -> Void
    
    public init(dday: DDay, onTap: @escaping () -> Void, onLongPress: @escaping () -> Void) {
        self.dday = dday
        self.onTap = onTap
        self.onLongPress = onLongPress
    }
    
    public var body: some View {
        Button {
            onTap()
        } label: {
            GeometryReader { proxy in
                VStack(alignment: .center) {
                    Text(dday.title)
                        .font(.headline)
                        .lineLimit(1)
                    HStack {
                        Text(dday.date.formattedYyyyMmDdWithWeekday())
                            .font(.caption)
                            .lineLimit(1)
                        Text("D\(dday.daysCalculate().formattedDDay())")
                            .foregroundStyle(.mint)
                            .font(.caption)
                            .lineLimit(1)
                    }
                }
                .frame(width: proxy.size.width - 40, height: 50)
                .background(
                    Color(ResourcesAsset.Assets.baseForeground.color)
                )
                .clipShape(.rect(cornerRadius: 10))
            }
        }
        .frame(height: 50)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .padding(.bottom, 10)
        .contextMenu {
            Button {
                onLongPress()
            } label: {
                Label("common_delete".localized(), systemImage: "trash.circle")
            }
        }
    }
}
