import UIKit

extension UIView {
    func pinToSuperview(edges: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: edges.top),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: edges.left),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: edges.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: edges.bottom)
        ])
    }
}
