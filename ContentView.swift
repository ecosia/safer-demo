import SwiftUI
import Safer

struct ContentView: View {
    @State private var text = ""
    @State private var url = ""
    @State private var searched = false
    @State private var progress = CGFloat(1)
    @State private var report = Report.new
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField(.init("URL"), text: $text, onCommit: commit)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: commit) {
                        Text(.init("Go"))
                    }
                }.padding()
                ProgressView(progress: progress)
                    .stroke(progress < 1 ? Color.accentColor : .clear,
                            style: .init(lineWidth: 4, lineCap: .round))
                    .frame(height: 4)
                    .cornerRadius(3)
                    .padding(.horizontal, 20)
                if searched {
                    WebView(url: $url, progress: $progress)
                } else {
                    Text("Enter.url")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }.navigationBarTitle(.init("Safer"), displayMode: searched ? .inline : .large)
                .navigationBarItems(trailing: BadgeView(report: $report))
        }
    }
    
    private func commit() {
        withAnimation {
            searched = true
        }
        url = text
    }
}
