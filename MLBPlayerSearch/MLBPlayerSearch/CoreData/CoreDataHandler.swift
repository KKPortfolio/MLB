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
    
    var favouritePlayer = FavouritePlayerObject()
    var flag: Bool = false
    
    func saveFavourite(playerName: String, playerID: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavouritePlayer", in: managedContext)!
        let player = NSManagedObject(entity: entity, insertInto: managedContext)
        player.setValue(playerName, forKey: "playerName")
        player.setValue(true, forKey: "flag")
        player.setValue(playerID, forKey: "playerID")
        
        do {
            try managedContext.save()
            favouritePlayer.favouritePlayers.append(player)
//            print("save complete")
        } catch let error as NSError {
            print("Could Not Save. \(error), \(error.userInfo)")
        }
    }
    
    func loadFavourite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouritePlayer")
        
        do {
            favouritePlayer.favouritePlayers = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could Not Fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllFavourites(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouritePlayer")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Delete Failed. \(error), \(error.userInfo)")
        }
    }
    
//    func checkDuplicateEntry(playerName: String, playerID: Int){
//        flag = false
//        loadFavourite()
//        if favouritePlayer.favouritePlayers.count == 0 {
//            saveFavourite(playerName: playerName, playerID: playerID)
//            
//            return
//        } else {
//            for i in 0...favouritePlayer.favouritePlayers.count-1 {
//                favouritePlayer.playerID.append(favouritePlayer.favouritePlayers[i].value(forKey: "playerID") as! Int)
//            }
//        }
//        
//        if let index = favouritePlayer.playerID.firstIndex(of: playerID){
//            
//        } else {
//            saveFavourite(playerName: playerName, playerID: playerID)
//            flag = true
//        }
//    }
    
    func checkDuplicateEntry(playerObject: PlayerCodable){
        loadFavourite()
        flag = false
        guard let playerName = playerObject.name_display_first_last else { return }
        guard let playerID = playerObject.player_id else { return }
        if favouritePlayer.favouritePlayers.count == 0 {
            saveFavourite(playerName: playerName, playerID: playerID)
            flag = true
            return
        } else {
            favouritePlayer.playerID.removeAll()
            for i in 0...favouritePlayer.favouritePlayers.count-1 {
                favouritePlayer.playerID.append(favouritePlayer.favouritePlayers[i].value(forKey: "playerID") as! Int)
            }
        }
        isFavourite(playerID: playerID)
        if !flag {
            saveFavourite(playerName: playerName, playerID: playerID)
            flag = true
        }
    }
    
    func isFavourite(playerID: Int){
        if let index = favouritePlayer.playerID.firstIndex(of: playerID){
            flag = true
        } else {
            flag = false
        }
    }
}


