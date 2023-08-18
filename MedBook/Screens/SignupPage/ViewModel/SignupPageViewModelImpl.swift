//
//  SignupPageViewModelImpl.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

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
}

class SignupPageViewModelImpl: SignupPageViewModelProtocol {
    
    ///data binding using closure method
    var eventHandler: State?
    var countryList: [Country]?
    private var email: String = ""
    private var password: String = ""
    private let coreDataManager: CoreDataManager
    
    init(eventHandler: State? = nil, coreDataManager: CoreDataManager) {
        self.eventHandler = eventHandler
        self.coreDataManager = coreDataManager
    }
    
    func onViewDidLoad() {
        fetchCountryList()
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
        ApiManager.shared.fetchCountryList { response in
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
