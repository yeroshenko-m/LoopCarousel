import UIKit

extension UIView {
    public class var nibName: String {
        String(describing: self)
    }
    
    public class func nib() -> UINib {
        UINib(nibName: Self.nibName, bundle: Bundle.module)
    }
    
    public class func initFromNib() -> Self {
        let nib = UINib(nibName: nibName, bundle: Bundle.module)
        let instance = nib.instantiate(withOwner: nil, options: nil)
        guard let view = instance.first as? Self else { fatalError("Couldn't get nib of type \(nibName)") }
        return view
    }
}
