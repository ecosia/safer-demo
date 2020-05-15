import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    @Binding var url: String
    @Binding var progress: CGFloat
    
    func makeCoordinator() -> Coordinator {
        .init(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        context.coordinator.prepare(webView)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = self.url.contains("http") ? self.url : "http://" + self.url
        _ = URL(string: url).map { uiView.load(.init(url: $0)) }
    }
}
