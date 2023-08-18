//
//  SignupPageViewModelImpl.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

enum AuthError: Error {
    case error(String)
}

protocol SignupPageViewModelProtocol: AnyObject {
    typealias State = (Event) -> Void
    var eventHandler: State? { get set }
    func onViewDidLoad()
    var countryList: [Country]? { get set }
    func updateEmail(_ text: String)
    func updatePassword(_ text: String)
    func isValidEmail() -> Bool
    func validateCharacterCount() -> Bool
    func validateUpperCaseLetters() -> Bool
    func validateSpecialCharacters() -> Bool
    func saveUser(email: String?, password: String?, completion: @escaping (Result<String, AuthError>) -> Void)
}

final class SignupPageViewModelImpl: SignupPageViewModelProtocol {
    
    ///data binding using closure method
    var eventHandler: State?
    var countryList: [Country]?
    private var email: String = ""
    private var password: String = ""
    private let coreDataManager: CoreDataManager
    private let apiManager: ApiManager
    
    init(
        coreDataManager: CoreDataManager = CoreDataManager(),
        apiManager: ApiManager = ApiManager.shared
    ) {
        self.coreDataManager = coreDataManager
        self.apiManager = apiManager
    }
    
    func onViewDidLoad() {
        DispatchQueue.main.async {
            self.fetchCountryList()
        }
    }
    
    private func saveAuthToken(completion: @escaping (Result<String, AuthError>) -> Void) {
        let authToken = AuthTokenManager.generateRandomToken()
        // Save the auth token securely in the Keychain
        if AuthTokenManager.saveAuthToken(authToken) {
            completion(.success(""))
            print("Auth token saved successfully after signup")
        } else {
            completion(.failure(.error("Error")))
            print("Failed to save auth token after signup")
        }
    }
    
    func saveUser(email: String?, password: String?, completion: @escaping (Result<String, AuthError>) -> Void) {
        guard let username = email, !username.isEmpty,
              let password = password, !password.isEmpty else {
            return
        }
        coreDataManager.saveUser(email: username, password: password) { [weak self] userSaved in
            guard let self else { return }
            if userSaved {
                self.saveAuthToken() { result in
                    switch result {
                    case .success(_):
                        completion(.success("Signup successful"))
                    case .failure:
                        completion(.failure(.error("Signup failed")))
                    }
                }
            } else {
                completion(.failure(.error("Signup failed")))
            }
        }
    }
}

extension SignupPageViewModelImpl {
    
    func updateEmail(_ text: String) {
        email = text
    }
    
    func updatePassword(_ text: String) {
        password = text
    }
    
    func isValidEmail() -> Bool {
        return email.isValidEmail
    }
    
    func validateCharacterCount() -> Bool {
        return password.hasEightCharacters
    }
    
    func validateUpperCaseLetters() -> Bool {
        return password.validateUppercaseLetters
    }
    
    func validateSpecialCharacters() -> Bool {
        return password.validateSpecialCharacters
    }
}

extension SignupPageViewModelImpl {
    func fetchCountryList() {
        eventHandler?(.loading)
        apiManager.fetchCountryList { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let countryListResponse):
                if let data = countryListResponse.data {
                    let countriesArray = Array(data.values)
                    self.countryList = countriesArray
                }
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
