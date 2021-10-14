import UIKit

public struct LoopCarouselConfiguration {
    let imageURLs: [URL]
    let isLoopScrollEnabled: Bool
    let placeholder: UIImage?
    
    init(imageURLs: [URL],
         isLoopScrollEnabled: Bool = false,
         placeholder: UIImage? = nil) {
        self.imageURLs = imageURLs
        self.isLoopScrollEnabled = isLoopScrollEnabled
        self.placeholder = placeholder
    }
}
