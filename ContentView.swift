import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WebView()
                .navigationBarTitle(.init("Safer"), displayMode: .large)
                .navigationBarItems(trailing: BadgeView())
        }
    }
}
