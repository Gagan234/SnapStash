import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false
    @State private var errorMessage = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("SnapStash")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Log In") {
                    login()
                }
                .buttonStyle(.borderedProminent)

                Button("Don't have an account? Sign Up") {
                    showSignUp = true
                }
                .font(.footnote)

                Spacer()
            }
            .padding()
            .fullScreenCover(isPresented: $showSignUp) {
                SignUpView()
            }
            
            // Add the NavigationLink to navigate to HomeView after login
            NavigationLink("", destination: HomeView())
                .isDetailLink(false)
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeView()
                }
        }
    }

    func login() {
        errorMessage = ""

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            // Set isLoggedIn flag to true and navigate to HomeView
            isLoggedIn = true
            navigateToHome = true
        }
    }
}

