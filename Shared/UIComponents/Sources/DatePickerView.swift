import SwiftUI

public struct DatePickerView: View {
    @Binding var date: Date
    let confirmHandler: (Date) -> Void
    let cancelHandler: () -> Void
    var showTime: Bool
    var cancelButtonString: String
    var confirmButtonString: String
    var backgroundColor: Color
    
    public init(date: Binding<Date>, showTime: Bool, confirmHandler: @escaping (Date) -> Void, cancelHandler: @escaping () -> Void, cancelButtonString: String, confirmButtonString: String, backgroundColor: Color) {
        self._date = date
        self.showTime = showTime
        self.confirmHandler = confirmHandler
        self.cancelHandler = cancelHandler
        self.cancelButtonString = cancelButtonString
        self.confirmButtonString = confirmButtonString
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: showTime ? [.date, .hourAndMinute] : [.date]
                )
                .environment(\.locale, Locale(identifier: String(Locale.preferredLanguages[0])))
                .datePickerStyle(.graphical)
                .labelsHidden()
                .frame(maxWidth: .infinity, maxHeight: showTime ? 350 : 320)
                
                HStack(spacing: 20) {
                    Button(action: {
                        cancelHandler()
                    }, label: {
                        Text(cancelButtonString)
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
                        Text(confirmButtonString)
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
            .background(backgroundColor)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
//            .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}
