import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    @Binding var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let url = self.url.contains("http") ? self.url : "http://" + self.url
        _ = URL(string: url).map { uiView.load(.init(url: $0)) }
    }
}
