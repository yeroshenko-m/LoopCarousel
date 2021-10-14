import Foundation

private final class BundleToken {}

extension Bundle {
    static var package: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}
