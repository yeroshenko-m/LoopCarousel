import UIKit

final class LoopCarouselCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    
    func setupImage(fromURL url: URL,
                    placeholder: UIImage?) {
        imageView.setupWithImage(from: url, placeholder: placeholder)
    }
}
