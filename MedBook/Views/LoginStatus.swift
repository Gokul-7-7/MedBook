//
//  LoginStatus.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import Foundation

enum LoginStatus {
    case success
    case passwordMismatch
    case userNotFound
    case noHashPasswordAttribute
    case passwordHashFail
    case error(String)
}
