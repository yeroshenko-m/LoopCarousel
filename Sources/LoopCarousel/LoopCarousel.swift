import UIKit

public class LoopCarousel: UIView {
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var collectionView: UICollectionView!
    
    weak var delegate: LoopCarouselDelegate?
    
    private var isLoopScrollEnabled = true
    private var placeholder: UIImage?
    private var items = [LoopCarouselItem]()
    private var currentItemIndex = 0
    
    private var cellsCount: Int {
        isLoopScrollEnabled && items.count > 1 ? items.count + 2 : items.count
    }
    
    private var realCurrentPageIndex: Int {
        let center = CGPoint(x: collectionView.contentOffset.x + (frame.width / 2), y: frame.height / 2)
        guard let centerIndexPath = collectionView.indexPathForItem(at: center) else { return 0 }
        return isLoopScrollEnabled && items.count > 1 ? itemIndex(at: centerIndexPath) : centerIndexPath.row
    }
    
    private var currentCellIndex: Int {
        Int(ceil(collectionView.contentOffset.x / collectionView.bounds.width))
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setupCollectionViewLayout()
        setupPageControl()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scroll(toCellWith: currentItemIndex)
        loopScrollIfNeeded()
    }
    
    public func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func setup(with configuration: LoopCarouselConfiguration) {
        isLoopScrollEnabled = configuration.isLoopScrollEnabled
        items = configuration.items
        pageControl.numberOfPages = items.count
        placeholder = configuration.placeholder ?? UIImage(named: "placeholder",
                                                           in: .package,
                                                           compatibleWith: nil)
        resetCarouselState()
        collectionView.reloadData()
    }
        
    private func setupCollectionView() {
        collectionView.registerNib(for: LoopCarouselCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
    }
    
    private func setupCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        layout.scrollDirection = .horizontal
    }
    
    private func setupPageControl() {
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }
    
    private func resetCarouselState() {
        pageControl.currentPage = 0
        currentItemIndex = isLoopScrollEnabled && items.count > 1 ? 1 : 0
        scroll(toCellWith: currentItemIndex)
    }
    
    private func itemIndex(at indexPath: IndexPath) -> Int {
        guard isLoopScrollEnabled, items.count > 1 else { return indexPath.row }
        switch indexPath.row {
        case .zero:
            return items.count - 1
        case items.count + 1:
            return .zero
        default:
            return indexPath.row - 1
        }
    }
    
    private func scroll(toCellWith cellIndex: Int, animated: Bool = false) {
        let cellWidth = collectionView.bounds.size.width
        let updatedOffset = CGPoint(x: cellWidth * CGFloat(cellIndex), y: .zero)
        collectionView.setContentOffset(updatedOffset, animated: animated)
    }
    
    private func loopScrollIfNeeded() {
        guard isLoopScrollEnabled, cellsCount > 1 else { return }
        switch currentCellIndex {
        case .zero:
            scroll(toCellWith: cellsCount - 2)
        case cellsCount - 1:
            scroll(toCellWith: 1)
        default:
            return
        }
    }
}

extension LoopCarousel: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let selectedItem = items[selectedIndex]
        delegate?.carousel(self, didSelectCellAt: selectedIndex, with: selectedItem)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension LoopCarousel: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_: UIScrollView) {
        loopScrollIfNeeded()
        currentItemIndex = currentCellIndex
        pageControl.currentPage = realCurrentPageIndex
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.carouselDidScroll(self)
    }
}

extension LoopCarousel: UICollectionViewDataSource {
    public func collectionView(_: UICollectionView,
                               numberOfItemsInSection _: Int) -> Int {
        cellsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LoopCarouselCell = collectionView.dequeueCell(forIndexPath: indexPath)
        let itemIndex = self.itemIndex(at: indexPath)
        let item = items[itemIndex]
        
        switch item.value {
        case let .image(image):
            cell.setupImage(image)
        case let .url(url):
            cell.setupImage(fromURL: url,
                            placeholder: placeholder)
        }
        
        return cell
    }
}

extension LoopCarousel: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout _: UICollectionViewLayout,
                               sizeForItemAt _: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}
