//
//  CoreData.swift
//  MessagesFilter
//
//  Created by Ariela Cohen on 10/24/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import Foundation
import CoreData

class CoreDataModelExt2 {
    
    static let shared = CoreDataModelExt2()
    
    
    private static let name = "TeltechFilter"
    
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: CustomPersistentContainer = {
        let container = CustomPersistentContainer(name: CoreDataModelExt2.name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loadWordsForMessageExt() -> [String] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Text")
        
        var wordList:[String] = []
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                
                wordList.append(data.value(forKey: "keyWord") as! String)
            }
        } catch {
            print("error")
        }
        
        return wordList 
    }
    
}

// sublcass persistent container to point to file directory in shared app group
class CustomPersistentContainer: NSPersistentContainer {
    override open class func defaultDirectoryURL() -> URL {
        if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.screencallgroup") {
            return url
        }
        
        return super.defaultDirectoryURL()
    }
}

