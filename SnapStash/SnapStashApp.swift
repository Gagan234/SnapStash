import SwiftUI
import Firebase

@main
struct SnapStashApp: App {
    // Initializer to configure Firebase when the app starts
    init() {
        FirebaseApp.configure() // This sets up Firebase
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView() // Starting view of your app
        }
    }
}

