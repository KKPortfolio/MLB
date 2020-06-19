//
//  CoreDataHandler.swift
//  MLBPlayerSearch
//
//  Created by Kurt Kim on 2020-06-17.
//  Copyright © 2020 KK. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    
    var favoritePlayer = FavoritePlayerObject()
    
    func saveFavorite(playerName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoritePlayer", in: managedContext)!
        let player = NSManagedObject(entity: entity, insertInto: managedContext)
        player.setValue(playerName, forKey: "playerName")
        
        do {
            try managedContext.save()
            favoritePlayer.favoritePlayers.append(player)
            print("save complete")
        } catch let error as NSError {
            print("Could Not Save. \(error), \(error.userInfo)")
        }
    }
    
    func loadFavorite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritePlayer")
        
        do {
            favoritePlayer.favoritePlayers = try managedContext.fetch(fetchRequest)
            print("load complete")
        } catch let error as NSError {
            print("Could Not Fetch. \(error), \(error.userInfo)")
        }
    }
}


