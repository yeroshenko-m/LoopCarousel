import UIKit

/**
A configuration object for LoopCarousel
 */
public struct LoopCarouselConfiguration {
    /// Array of items that will be displayed in carousel
    let items: [LoopCarouselItem]
    /// Boolean value for on/off loop scrolling in carousel
    let isLoopScrollEnabled: Bool
    /// An optional placeholder UIImage, which is displayed in case when image can not be set from a given URL.
    /// If is not set, carousel uses default placeholder
    let placeholder: UIImage?
    
    init(items: [LoopCarouselItem],
         isLoopScrollEnabled: Bool = false,
         placeholder: UIImage? = nil) {
        self.items = items
        self.isLoopScrollEnabled = isLoopScrollEnabled
        self.placeholder = placeholder
    }
}
