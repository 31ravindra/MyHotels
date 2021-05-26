//
//  DataManagerViewModel.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 25/05/21.
//

import Foundation
import CoreData
import UIKit

protocol manageDataMethods {
    func getData(forEntity: String, andSaveToArray entityArray: inout [NSManagedObject], completion: @escaping (_ success:Bool) -> Void)
    func save(hotelData: HotelModel, useEntity nameOfEntity: String, useArray entityArray: inout [NSManagedObject], completion: @escaping (_ success:Bool) -> Void)
    func updateData(forEntity: String, objectId: NSManagedObjectID, updateValueTo updatedValue: HotelModel, andSaveToArray entityArray: inout [NSManagedObject], completion: @escaping (_ success:Bool) -> Void)
    func deleteData(deleteHotel: NSManagedObject ,forEntity: String, completion: @escaping (_ success:Bool) -> Void)
}

class DataManagerViewModel: manageDataMethods {
    
    func getData(forEntity: String, andSaveToArray entityArray: inout [NSManagedObject], completion: @escaping (Bool) -> Void) {
        //Get managedContext, refrence to AppDelegate, and prepare fetchRequest
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(forEntity)")

        //Get saved data
        do {
            entityArray = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func save(hotelData: HotelModel, useEntity nameOfEntity: String, useArray entityArray: inout [NSManagedObject], completion: @escaping (_ success:Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: nameOfEntity, in: managedContext)!
        let genericItem = NSManagedObject(entity: entity, insertInto: managedContext)
        genericItem.setValue(hotelData.name, forKeyPath: "name")
        genericItem.setValue(hotelData.address, forKey: "address")
        genericItem.setValue(hotelData.rating, forKey: "rating")
        genericItem.setValue(hotelData.roomRate, forKey: "roomrate")
        genericItem.setValue(hotelData.imgData, forKey: "img")
        genericItem.setValue(hotelData.stayDate, forKey: "staydate")
        genericItem.setValue(hotelData.isFav, forKey: "isfavourite")
        genericItem.setValue(hotelData.isVisited, forKey: "isVisited")
        
        do { //Save context and add to array
            try managedContext.save()
            entityArray.append(genericItem)
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func updateData(forEntity: String, objectId: NSManagedObjectID, updateValueTo updatedValue: HotelModel, andSaveToArray entityArray: inout [NSManagedObject], completion: @escaping (_ success:Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "\(forEntity)")
        let predicate = NSPredicate(format: "self == %@", objectId)

        fetchRequest.predicate = predicate


        do {
            let fetched = try managedContext.fetch(fetchRequest)
            let objectUpdate = fetched.last!

            //Update value
            objectUpdate.setValue(updatedValue.name, forKeyPath: "name")
            objectUpdate.setValue(updatedValue.address, forKey: "address")
            objectUpdate.setValue(updatedValue.rating, forKey: "rating")
            objectUpdate.setValue(updatedValue.roomRate, forKey: "roomrate")
            objectUpdate.setValue(updatedValue.imgData, forKey: "img")
            objectUpdate.setValue(updatedValue.stayDate, forKey: "staydate")
            objectUpdate.setValue(updatedValue.isFav, forKey: "isfavourite")
            objectUpdate.setValue(updatedValue.isVisited, forKey: "isVisited")

            do { //Save context
                try managedContext.save()
                completion(true)
            }
            catch {
                print(error)
                completion(false)
            }
        }
        catch {
            completion(false)
            print(error)
        }
    }
    func deleteData(deleteHotel: NSManagedObject ,forEntity: String, completion: @escaping (_ success:Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(deleteHotel)

            do { //Save context
                try managedContext.save()
                completion(true)
            }
            catch {
                print(error)
                completion(false)
            }
      }
    
}
