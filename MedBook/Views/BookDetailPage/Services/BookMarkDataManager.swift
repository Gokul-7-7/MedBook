//
//  DetailPageDB.swift
//  MedBook
//
//  Created by Gokul on 02/09/23.
//

import CoreData
import UIKit

enum BookMarkEvent: Error {
    case success
    case failure(Error)
}

final class BookMarkDataManager {
    static let shared = BookMarkDataManager()
    
    // Property to store the managed context globally
    private let managedContext: NSManagedObjectContext
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func isDocEntityPresent(withKey key: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DocEntity")
        
        // Set up a predicate to fetch the entity with the matching key
        fetchRequest.predicate = NSPredicate(format: "key == %@", key)
        
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch let error as NSError {
            print("Error checking entity presence: \(error.localizedDescription)")
            return false
        }
    }
    
    // Function to save a Doc instance to Core Data
    func saveDocToCoreData(doc: Doc, completion: @escaping (Bool) -> ()) {
        let entity = NSEntityDescription.entity(forEntityName: "DocEntity", in: managedContext)!
        
        let docEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set values from your Doc struct to the Core Data entity
        docEntity.setValue(doc.key, forKey: "key")
        docEntity.setValue(doc.title, forKey: "title")
        docEntity.setValue(doc.ratings_average, forKey: "ratings_average")
        docEntity.setValue(doc.author_name?.first, forKey: "author_name")
        docEntity.setValue(doc.cover_i, forKey: "cover_i")
        
        // Save the managed context
        do {
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            completion(false)
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    // Function to remove a Doc instance from Core Data
    func removeDocFromCoreData(docKey: String, completion: @escaping (Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(false) 
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DocEntity")
        
        // Set up a predicate to fetch the entity with the matching key
        fetchRequest.predicate = NSPredicate(format: "key == %@", docKey)
        
        do {
            if let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject], let docEntity = result.first {
                managedContext.delete(docEntity)
                // Save the managed context after deletion
                try managedContext.save()
                completion(true)
            } else {
                completion(false)
            }
        } catch let error as NSError {
            print("Error removing from Core Data: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // Function to fetch all Doc entities from Core Data
    func fetchAllDocsFromCoreData() -> [Doc]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DocEntity")
        
        do {
            if let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
                // Create an array to store the retrieved Doc instances
                var docs: [Doc] = []
                
                for docEntity in result {
                    // Create a Doc instance from the Core Data entity's attributes
                    let doc = Doc(
                        key: docEntity.value(forKey: "key") as? String,
                        title: docEntity.value(forKey: "title") as? String,
                        ratings_average: docEntity.value(forKey: "ratings_average") as? Double,
                        author_name: docEntity.value(forKey: "author_name") as? [String],
                        cover_i: docEntity.value(forKey: "cover_i") as? Int
                    )
                    
                    docs.append(doc)
                }
                
                return docs
            }
        } catch let error as NSError {
            print("Error fetching from Core Data: \(error.localizedDescription)")
        }
        
        return nil
    }
}
