import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let identifier = T.identifier

        guard identifier != String(describing: UICollectionViewCell.self)
        else { fatalError("Invalid cell type. Set it explicitly: 'let cell: SomeCellType'") }

        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
        else { fatalError("Couldn't dequeue reusable cell with identifier: \(identifier)") }
        return cell
    }
}
