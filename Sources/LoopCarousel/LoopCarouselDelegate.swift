import Foundation

public protocol LoopCarouselDelegate: AnyObject {
    func carouselDidScroll(_ carousel: LoopCarousel)
    func carousel(_ carousel: LoopCarousel,
                  didSelectCellAt index: Int,
                  with item: LoopCarouselItem)
}
