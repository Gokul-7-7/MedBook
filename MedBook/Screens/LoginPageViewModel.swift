//
//  LoginPageViewModel.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

protocol LoginPageViewModelProtocol: AnyObject {
    var email: String? { get set }
    var password: String? { get set }
    func updateEmail(_ text: String)
    func updatePassword(_ text: String)
    typealias StatusHandler = (LoginStatus) -> Void
    func saveAuthToken()
    func login(email: String, password: String, completion: @escaping StatusHandler)
}

final class LoginViewModelImpl: LoginPageViewModelProtocol {    
    
    private let coreDataManager: CoreDataManager
    var email: String?
    var password: String?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func updateEmail(_ text: String) {
        email = text
    }
    
    func updatePassword(_ text: String) {
        password = text
    }
    
    func saveAuthToken() {
        let authToken = AuthTokenManager.generateRandomToken()
        // Save the auth token securely in the Keychain
        if AuthTokenManager.saveAuthToken(authToken) {
            print("Auth token saved successfully")
        } else {
            print("Failed to save auth token")
        }
    }
    
    func login(email: String, password: String, completion: @escaping StatusHandler) {
        coreDataManager.login(email: email, password: password) { loginStatus in
            DispatchQueue.main.async {
                completion(loginStatus)
            }
        }
    }
    
}
