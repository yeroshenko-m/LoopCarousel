import UIKit

/**
 Item that will be displayed in carousel.
 
 Can be initialized with image URL, which will be loaded by carousel.
 Loaded images are stored in cache.
 
 ```
 let item = LoopCarouselItem(image: UIImage)
 ```
 
 Also can be initialized with UIImage to be used in carousel.
 ```
 let item = LoopCarouselItem(url: URL)
 ```
 */

public struct LoopCarouselItem {
    enum Kind {
        case image(UIImage)
        case url(URL)
    }
    
    let value: Kind
    
    init(url: URL) {
        value = .url(url)
    }
    
    init(image: UIImage) {
        value = .image(image)
    }
}
