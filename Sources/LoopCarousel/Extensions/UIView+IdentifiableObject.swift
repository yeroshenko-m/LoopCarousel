import UIKit

extension UIView: IdentifiableObject {
    static var identifier: String {
        String(describing: Self.self)
    }
}
