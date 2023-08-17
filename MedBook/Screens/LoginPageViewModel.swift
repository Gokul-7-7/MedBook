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
    func login(email: String, password: String, completion: @escaping StatusHandler)
}

class LoginViewModelImpl: LoginPageViewModelProtocol {    
    
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
    
    func login(email: String, password: String, completion: @escaping StatusHandler) {
        coreDataManager.login(email: email, password: password) { loginStatus in
            DispatchQueue.main.async {
                completion(loginStatus)
            }
        }
    }
    
}
