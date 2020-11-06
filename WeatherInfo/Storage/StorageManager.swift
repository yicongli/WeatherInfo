//
//  StorageManager.swift
//  WeatherInfo
//
//  Created by Yicong Li on 6/11/20.
//

import Foundation
import CoreData

class StorageManager {
    
    static let instance = StorageManager()
    
    struct Keys {
        static let containerName = "WeatherInfo"
        static let entryName = "CityID"
        static let defaultIDs = [4163971, 2147714, 2174003]
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: Keys.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // Merge the changes from other contexts automatically.
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        return container
    }()
}

// MARK: - Core Data Saving support
extension StorageManager {

    func getAllCitiesID(completionHandler: @escaping ([Int]) -> Void){
        DispatchQueue.global().async {
            let fetchRequest = NSFetchRequest<CityID>(entityName: Keys.entryName)
            do {
                let data = try self.persistentContainer.viewContext.fetch(fetchRequest)
                var cityIdList:[Int] = []
                
                for item in data {
                    cityIdList.append(Int(item.city_id))
                }
                
                if cityIdList.count == 0 {
                    cityIdList = Keys.defaultIDs
                    self.storeAllCitiesID(cityIDs: cityIdList) 
                }
                
                DispatchQueue.main.async { completionHandler(cityIdList) }
            } catch {
                print("Unresolved error \(error)")
                DispatchQueue.main.async { completionHandler([]) }
            }
        }
    }
    
    func storeAllCitiesID(cityIDs:[Int]) {
        
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Keys.entryName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        // store all city id into objects
        for id in cityIDs {
            guard let cityID = NSEntityDescription.insertNewObject(forEntityName: "CityID", into: context) as? CityID else {
                fatalError("Unresolved error: fail to create")
            }
            
            cityID.city_id = Int64(id)
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
