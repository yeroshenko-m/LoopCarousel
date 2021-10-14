import UIKit

extension UICollectionView {
    func registerNib(for cellType: UICollectionViewCell.Type) {
        register(cellType.nib(), forCellWithReuseIdentifier: cellType.identifier)
    }

    func registerNibs(for cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach { registerNib(for: $0) }
    }
}
