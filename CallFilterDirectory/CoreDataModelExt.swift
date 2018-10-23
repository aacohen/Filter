//
//  CoreDataModelExt.swift
//  CallFilterDirectory
//
//  Created by Ariela Cohen on 10/22/18.
//  Copyright © 2018 Ariela Cohen. All rights reserved.
//

import Foundation
import CoreData
import CallKit

class CoreDataModelExt {
    
static let shared = CoreDataModelExt()

    var blockedList: [CXCallDirectoryPhoneNumber] = []
    
private static let name = "TeltechFilter"



var context: NSManagedObjectContext {
    return persistentContainer.viewContext
}

var persistentContainer: CustomPersistentContainer = {
    let container = CustomPersistentContainer(name: CoreDataModelExt.name)
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

func createPhoneCall(number: Int64) {
    let entity = NSEntityDescription.entity(forEntityName: "PhoneCall", in: context)
    let newPhoneCall = NSManagedObject(entity: entity!, insertInto: context)
    newPhoneCall.setValue(number, forKey: "phoneNumber")
    
    do {
        try context.save()
    } catch {
        print("Error saving")
        // handle error
    }
}

func fetch() {
    
       let request = NSFetchRequest<NSFetchRequestResult>(entityName:"PhoneCall")
                    request.returnsObjectsAsFaults = false
    
    do {
    let result = try context.fetch(request)
    
                for data in result as! [NSManagedObject]{
                    guard let number = data.value(forKey: "phoneNumber") else { return }
    
                    blockedList.append(number as! CXCallDirectoryPhoneNumber)
                }
    } catch {
    print("error")
    }
}

func convertNumber(number: String) -> Int64 {
    //        1_253_950_1212
    
    var newNumber = number
    newNumber.insert("_", at: newNumber.index(newNumber.startIndex, offsetBy: 2))
    newNumber.insert("_", at: newNumber.index(newNumber.startIndex, offsetBy: 5))
    newNumber.insert("_", at: newNumber.index(newNumber.startIndex, offsetBy: 9))
    
    return Int64(newNumber) ?? 1_000_000_0000
    
}
    
//    func convertToCXNumber() -> [CXCallDirectoryPhoneNumber] {
//        var newArray: [CXCallDirectoryPhoneNumber] = []
//        for call in blockedList {
//            let cxNumber = call.phoneNumber as CXCallDirectoryPhoneNumber
//            newArray.append(cxNumber)
//        }
//        return newArray
//    }

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
