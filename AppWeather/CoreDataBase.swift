//
//  CoreDataBase.swift
//  AppWeather
//
//  Created by Can Bas on 11/15/18.
//  Copyright © 2018 Can Bas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataBase{
    
    static func createData(latitude: Double, longitude: Double){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(latitude, forKeyPath: "latitude")
        user.setValue(longitude, forKey: "longitude")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func retrieveData(callback: (([Weather])-> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var weatherArray = [Weather]()
            
            for data in result as! [NSManagedObject] {
                if let lat = data.value(forKey: "latitude") as? Double, let lon = data.value(forKey: "longitude") as? Double {
                    weatherArray.append(Weather(latitude: lat, longitude: lon))
                }
            }
            callback(weatherArray)
        } catch {
            
            print("Failed")
        }
    }
    
    static func deleteData(at index: Int){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[index] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
    }
    
}
