struct AuthManager {
    static func createAccount(fullname: String, username: String, password: String, confirmPassword: String, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        guard !fullname.isEmpty, !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, password == confirmPassword else {
            onError()
            return
        }
        
        let usernameSaved = KeychainManager.save(key: "user_\(username)", value: username)
        let passwordSaved = KeychainManager.save(key: "pass_\(username)", value: password)
        
        if usernameSaved && passwordSaved {
            onSuccess()
        } else {
            onError()
        }
    }
    
    static func signIn(username: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        guard let storedUsername = KeychainManager.get(key: "user_\(username)"), let storedPassword = KeychainManager.get(key: "pass_\(username)") else {
            onError()
            return
        }
        
        if username == storedUsername && password == storedPassword {
            onSuccess()
        } else {
            onError()
        }
    }
}
