import SwiftUI
import Safer

let coordinator = Coordinator()

struct ContentView: View {
    @State var progress = CGFloat(1)
    @State var report = Report.new
    @State private var text = ""
    @State private var url = ""
    @State private var searched = false
    
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
                    WebView(url: $url)
                } else {
                    Text("Enter.url")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }.navigationBarTitle(.init("Safer"), displayMode: searched ? .inline : .large)
                .navigationBarItems(trailing: BadgeView(report: $report))
        }.onAppear {
            coordinator.contentView = self
        }
    }
    
    private func commit() {
        withAnimation {
            searched = true
        }
        url = text
    }
}
