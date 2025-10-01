import SwiftUI
import Utilities
import Resources

public struct DatePickerView: View {
    @Binding var date: Date
    let confirmHandler: (Date) -> Void
    let cancelHandler: () -> Void
    var showTime: Bool
    
    public init(date: Binding<Date>, showTime: Bool, confirmHandler: @escaping (Date) -> Void, cancelHandler: @escaping () -> Void) {
        self._date = date
        self.showTime = showTime
        self.confirmHandler = confirmHandler
        self.cancelHandler = cancelHandler
    }
    
    public var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: showTime ? [.date, .hourAndMinute] : [.date]
                )
                .environment(\.locale, Locale(identifier: String(Locale.preferredLanguages[0])))
                .datePickerStyle(.graphical)
                .labelsHidden()
                .frame(maxWidth: .infinity, maxHeight: showTime ? 320 : 350)
                
                HStack(spacing: 20) {
                    Button(action: {
                        cancelHandler()
                    }, label: {
                        Text("common_cancel".localized())
                            .frame(maxWidth: 150, maxHeight: 44)
                            .frame(height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    })
                    
                    Button(action: {
                        confirmHandler(date)
                    }, label: {
                        Text("common_confirm".localized())
                            .frame(maxWidth: 150, maxHeight: 44)
                            .frame(height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.accentColor, lineWidth: 1)
                            )
                    })
                }
                .padding(.top, 10)
            }
            .padding()
            .background(.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
//            .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}
