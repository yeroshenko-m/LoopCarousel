import UIKit

extension UIView {
    class var nibName: String {
        String(describing: self)
    }
    
    class func nib() -> UINib {
        UINib(nibName: Self.nibName, bundle: Bundle.module)
    }
    
    class func initFromNib() -> Self {
        let nib = UINib(nibName: nibName, bundle: Bundle.module)
        let instance = nib.instantiate(withOwner: nil, options: nil)
        guard let view = instance.first as? Self else { fatalError("Couldn't get nib of type \(nibName)") }
        return view
    }
}
