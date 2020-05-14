import SwiftUI

final class Scene: UIResponder, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo: UISceneSession, options: UIScene.ConnectionOptions) {
        let window = UIApplication.shared.delegate as! Window
        window.windowScene = scene as? UIWindowScene
        window.rootViewController = UIHostingController(rootView: ContentView())
        window.makeKeyAndVisible()
    }
}

@UIApplicationMain private final class Window: UIWindow, UIApplicationDelegate {
    
}
