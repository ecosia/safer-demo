import WebKit

final class Coordinator: NSObject, WKNavigationDelegate {
    var view: WebView?
    var contentView: ContentView?
    private var observations = Set<NSKeyValueObservation>()
    
    deinit {
        observations.forEach { $0.invalidate() }
    }
    
    func prepare(_ webView: WKWebView) {
        webView.navigationDelegate = self
        
        observations.insert(webView.observe(\.url, options: .new) { [weak self] in
            $1.newValue?.map {
                print($0)
            }
        })
        
        observations.insert(webView.observe(\.title, options: .new) { [weak self, weak webView] in
            guard let title = $1.newValue as? String, !title.isEmpty, let webView = webView else { return }
            print("title \(title)")
            
        })
        
        observations.insert(webView.observe(\.estimatedProgress, options: .new) { [weak self] in
            $1.newValue.map { self?.contentView?.progress = .init($0) }
        })
    }
    
    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        contentView?.progress = 1
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] in
            print("cookies: \($0)")
        }
    }
}
