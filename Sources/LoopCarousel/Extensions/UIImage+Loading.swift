import UIKit

private enum Constants {
    static let loadingTimeout: TimeInterval = 5.0
    static var dataTaskKey = "com.loopcarousel.datatask.key"
}

typealias Completion = () -> Void

extension UIImageView {
    private var currentTask: URLSessionDataTask? {
        get {
            objc_getAssociatedObject(self, &Constants.dataTaskKey) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(self, &Constants.dataTaskKey,  newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func setupWithImage(from url: URL,
                        placeholder: UIImage? = nil,
                        completion: Completion? = nil) {
        if let cachedImage = ImageCache.shared.image(with: url.absoluteString) {
            image = cachedImage
            completion?()
            return
        }
        
        showLoadingView()
        currentTask?.cancel()
        let session = URLSession.shared
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: Constants.loadingTimeout)
        
        let task = session.dataTask(with: request) { [weak self] (responseData, _, _) in
            guard let data = responseData,
                  let loadedImage = UIImage(data: data)
            else {
                self?.hideLoadingView()
                self?.setupPlaceholder(placeholder)
                return
            }
            self?.hideLoadingView()
            self?.image = loadedImage
        }
        
        currentTask = task
        task.resume()
    }
    
    private func setupPlaceholder(_ placeholder: UIImage?) {
        image = placeholder
    }
    
    private func showLoadingView() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.pinToSuperview()
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingView() {
        guard let activityIndicator = subviews.first(where: { $0 is UIActivityIndicatorView })
        else { return }
        activityIndicator.removeFromSuperview()
    }
}
