import UIKit

final class LoopCarouselCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupImage(fromURL url: URL,
                    placeholder: UIImage?) {
        imageView.setupWithImage(from: url, placeholder: placeholder)
    }
    
    func setupImage(_ image: UIImage) {
        imageView.image = image
    }
}
