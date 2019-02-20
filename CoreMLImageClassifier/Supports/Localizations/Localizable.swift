import Foundation

public protocol Localizable: RawRepresentable where RawValue == String {}

public extension Localizable {
    public func localized(tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
        return NSLocalizedString(self.rawValue, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}
