import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""

    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.title2)
                        .bold()

                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button("Sign Up") {
                        signUp()
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sign Up")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            // Use the new NavigationLink style
            NavigationLink("", destination: LoginView())
                .isDetailLink(false)
                .navigationDestination(isPresented: $navigateToLogin) {
                    LoginView()
                }
        }
        .onTapGesture {
            // Dismiss the keyboard if the user taps outside the text field
            UIApplication.shared.endEditing()
        }
    }

    func signUp() {
        errorMessage = ""

        guard !firstName.isEmpty, !lastName.isEmpty, !username.isEmpty,
              !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            guard let uid = result?.user.uid else {
                errorMessage = "Failed to get user ID."
                return
            }

            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "firstName": firstName,
                "lastName": lastName,
                "username": username,
                "email": email
            ]) { err in
                if let err = err {
                    errorMessage = "Failed to save user info: \(err.localizedDescription)"
                } else {
                    // On successful sign-up, trigger the navigation to LoginView
                    navigateToLogin = true
                }
            }
        }
    }
}

// Helper to dismiss keyboard
extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

