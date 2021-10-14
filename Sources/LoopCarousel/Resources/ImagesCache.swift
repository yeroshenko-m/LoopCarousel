import UIKit

final class ImageCache: NSCache<NSString, UIImage> {
    static let shared = ImageCache()

    func cache(_ image: UIImage, for urlString: String) {
        setObject(image, forKey: urlString as NSString)
    }

    func image(with urlString: String) -> UIImage? {
        object(forKey: urlString as NSString)
    }
}
