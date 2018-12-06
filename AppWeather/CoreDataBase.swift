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
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(latitude, forKeyPath: "latitude")
        user.setValue(longitude, forKey: "longitude")
        
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    static func retrieveData(callback: (([Weather])-> Void)) {

        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            var weatherArray = [Weather]()
            for data in result as! [NSManagedObject] {
                //                 lat = (data.value(forKey: "latitude"))
                //                 lon = (data.value(forKey: "longitude"))
                
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
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
                let objectToDelete = test[index] as! NSManagedObject
                managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    static func updateData(callback: (([Weather]) -> ([Weather]))){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Location")
        
        var weatherArray = [Weather]()
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
//            objectUpdate.setValue("newName", forKey: "username")
//            objectUpdate.setValue("newmail", forKey: "email")
//            objectUpdate.setValue("newpassword", forKey: "password")

            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
}
