import SwiftUI

struct LoginView : View {
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isCreatingAccount = true
    @State private var missingInfo = false
    @State private var showErrorMessage = false
    @State private var navigateToHome = false
    
    var body : some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Image("EdSyncLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 10)
                        .frame(width: 75.0)
                    
                    VStack {
                        Text(isCreatingAccount ? "Create an Account" : "Sign in")
                            .foregroundStyle(.black)
                            .font(.title.lowercaseSmallCaps())
                            .bold()
                            .padding(.top, 70)
                        
                        if isCreatingAccount {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Full Name")
                                    .font(.caption)
                                    .foregroundStyle(.edSyncOrange)
                                
                                TextField("Enter your full name", text: $fullname)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(username.isEmpty && showErrorMessage ? .red : .clear)
                                    )
                            }
                            .padding(.top, 20)
                            .frame(width: 330.0)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Username")
                                .font(.caption)
                                .foregroundStyle(.edSyncOrange)
                            
                            TextField("Enter your username", text: $username)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(username.isEmpty && showErrorMessage ? .red : .clear)
                                )
                        }
                            .frame(width:330)
                            .padding(.top, isCreatingAccount ? 0 : 20)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Password")
                                .font(.caption)
                                .foregroundStyle(.edSyncOrange)
                            
                            SecureField("Enter your password", text: $password)
                                .padding(10)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(password.isEmpty && showErrorMessage ? .red : .clear)
                                )
                        }
                            .frame(width:330)
                        
                        if isCreatingAccount {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Confirm Password")
                                    .font(.caption)
                                    .foregroundStyle(.edSyncOrange)
                                
                                SecureField("Re-enter your password", text: $confirmPassword)
                                    .padding(10)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(confirmPassword.isEmpty && showErrorMessage ? .red : .clear)
                                    )
                            }
                                .frame(width:330)
                        }
                        
                        Button(action: {
                            isCreatingAccount.toggle()
                            clearFields()
                            showErrorMessage = false
                        }) {
                            Text(isCreatingAccount ? "Have an account? Sign in" : "Need an account? Sign up")
                        }
                        .foregroundStyle(.blue)
                        .font(.footnote)
                        .padding(.top, 10)
                        //.buttonStyle(.plain)
                        
                        Button(action: {
                            if isCreatingAccount {
                                AuthManager.createAccount(fullname: fullname, username: username, password: password, confirmPassword: confirmPassword, onSuccess: {
                                    navigateToHome = true
                                    print("SUCCESSFUL ACCOUNT CREATION")
                                }, onError: {
                                    print("ERROR CREATING ACCOUNT")
                                    showErrorMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        showErrorMessage = false
                                    })
                                })
                            } else {
                                AuthManager.signIn(username: username, password: password, onSuccess: {
                                    print("SUCCESSFUL SIGNING IN")
                                    navigateToHome = true
                                }, onError: {
                                    print("ERROR SIGNING IN")
                                    showErrorMessage = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                        showErrorMessage = false
                                    })
                                })
                            }
                        }) {
                            Text(isCreatingAccount ? "Sign up" : "Sign in")
                        }
                        .padding(.top, 20)
                        .frame(width: 200)
                        .disabled(
                            username.isEmpty || username.count > 20 || password.isEmpty || (isCreatingAccount && (fullname.isEmpty || fullname.count > 50 || confirmPassword.isEmpty))
                        )
                        
                        Spacer()
                        
                        if !isCreatingAccount {
                            Text("Sign-in functionality is under development")
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .padding()
                                .foregroundStyle(.gray)
                        }
                        
                        Text("Early prototype — features may be limited")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundStyle(.gray)
                        
                        NavigationLink(destination: HomeView().onAppear { clearFields() }, isActive: $navigateToHome) {
                            EmptyView()
                        }
                        
                        if showErrorMessage {
                            Group {
                                if isCreatingAccount {
                                    if missingInfo {
                                        Text("You're missing some information. Please try again.")
                                    } else if password != confirmPassword {
                                        Text("Passwords do not match. Please try again.")
                                    } else {
                                        Text("Something went wrong. Please try again.")
                                    }
                                } else {
                                    Text("Invalid username or password. Please try again.")
                                }
                            }
                            .foregroundStyle(.red)
                            .padding(.top, 10)
                        }
                    }
                }
                .textFieldStyle(.roundedBorder)
                .buttonStyle(.bordered)
            }
            .padding(.top, 50)
            .ignoresSafeArea(.all)
        }
    }
    
    private func clearFields() {
        fullname = ""
        username = ""
        password = ""
        confirmPassword = ""
    }
}

struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
