import WebKit

final class Coordinator: NSObject, WKNavigationDelegate {
    private var observations = Set<NSKeyValueObservation>()
    private let webView: WebView
    
    init(_ webView: WebView) {
        self.webView = webView
    }
    
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
    }
    
    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies {
            print("cookies: \($0)")
        }
    }
}
