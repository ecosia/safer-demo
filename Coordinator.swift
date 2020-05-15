import WebKit
import Safer

final class Coordinator: NSObject, WKNavigationDelegate {
    var view: WebView?
    var contentView: ContentView?
    private var observations = Set<NSKeyValueObservation>()
    private let safer = Safer()
    
    deinit {
        observations.forEach { $0.invalidate() }
    }
    
    func prepare(_ webView: WKWebView) {
        webView.navigationDelegate = self
        
        observations.insert(webView.observe(\.estimatedProgress, options: .new) { [weak self] in
            $1.newValue.map { progress in
                DispatchQueue.main.async {
                    self?.contentView?.progress = .init(progress)
                }
            }
        })
    }
    
    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        contentView?.progress = 1
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] in
            guard let report = self?.safer.analyse($0) else { return }
            self?.contentView?.report = report
        }
    }
}
