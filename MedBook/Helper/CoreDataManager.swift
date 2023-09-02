//
//  CoreDataManager.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import CoreData
import CryptoKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MedBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    typealias Handler = (Bool) -> Void
    
    func saveUser(email: String, password: String, completion: @escaping Handler) {
        let context = persistentContainer.viewContext
        
        // Hash the password using SHA256
        if let passwordData = password.data(using: .utf8) {
            let hashed = SHA256.hash(data: passwordData)
            let hashedPasswordData = Data(hashed)
            
            // Create a new entity
            if let entity = NSEntityDescription.entity(forEntityName: "User", in: context) {
                let user = NSManagedObject(entity: entity, insertInto: context)
                user.setValue(email, forKey: "username")
                user.setValue(hashedPasswordData, forKey: "hashedPassword")
                
                do {
                    try context.save()
                    print("User saved successfully")
                    completion(true)
                } catch {
                    print("Failed to save user: \(error)")
                    completion(false)
                }
            } else {
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (LoginStatus) -> Void) {
        let context = persistentContainer.viewContext
        
        // Fetch the user with the provided email
        guard let fetchedUser = fetchUser(withEmail: email, inContext: context) else {
            completion(.userNotFound)
            return
        }
        
        // Hash the provided password
        guard let hashedPasswordData = hashPassword(password) else {
            completion(.passwordHashFail)
            return
        }
        
        // Retrieve the hashed password from the fetched user
        guard let userHashedPassword = fetchedUser.value(forKey: "hashedPassword") as? Data else {
            completion(.noHashPasswordAttribute)
            return
        }
        
        // Compare hashed passwords
        if userHashedPassword == hashedPasswordData {
            completion(.success) // Passwords match, login successful
        } else {
            completion(.passwordMismatch) // Passwords do not match
        }
    }
    
    // Function to fetch a user with the provided email
    func fetchUser(withEmail email: String, inContext context: NSManagedObjectContext) -> NSManagedObject? {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", email)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
    
    // Function to hash the provided password
    func hashPassword(_ password: String) -> Data? {
        if let passwordData = password.data(using: .utf8) {
            let hashed = SHA256.hash(data: passwordData)
            return Data(hashed)
        }
        return nil
    }
    
}
