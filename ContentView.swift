import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var url = ""
    @State private var searched = false
    @State private var rating = Rating.unknown
    
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
                if searched {
                    WebView(url: $url)
                } else {
                    Text("Enter.url")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }.navigationBarTitle(.init("Safer"), displayMode: searched ? .inline : .large)
                .navigationBarItems(trailing: BadgeView(rating: $rating))
        }
    }
    
    private func commit() {
        withAnimation {
            searched = true
        }
        url = text
    }
}
