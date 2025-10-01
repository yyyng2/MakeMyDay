import Foundation

extension Int {
    public func formattedDDay() -> String {
        if self == 0 {
            return "-Day"
        }
        return self > 0 ? "+\(self)" : "\(self)"
    }
    
    public func anniversarySuffix() -> String {
        switch self {
        case 1: return "\(self)st"
        case 2: return "\(self)nd"
        case 3: return "\(self)rd"
        default: return "\(self)th"
        }
    }
}
