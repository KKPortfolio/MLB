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
    var alertMaker = ErrorAlerts()
    var alreadyFavorite: Bool = false
    
    func saveFavorite(playerName: String, playerID: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoritePlayer", in: managedContext)!
        let player = NSManagedObject(entity: entity, insertInto: managedContext)
        player.setValue(playerName, forKey: "playerName")
        player.setValue(true, forKey: "flag")
        player.setValue(playerID, forKey: "playerID")
        
        do {
            try managedContext.save()
            favoritePlayer.favoritePlayers.append(player)
//            print("save complete")
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
//            print("load complete")
        } catch let error as NSError {
            print("Could Not Fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllFavorites(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePlayer")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Delete Failed. \(error), \(error.userInfo)")
        }
    }
    
    func checkDuplicateEntry(playerName: String, playerID: Int){
        alreadyFavorite = false
        loadFavorite()
        if favoritePlayer.favoritePlayers.count == 0 {
            saveFavorite(playerName: playerName, playerID: playerID)
            return
        } else {
            for i in 0...favoritePlayer.favoritePlayers.count-1{
                favoritePlayer.playerID.append(favoritePlayer.favoritePlayers[i].value(forKey: "playerID") as! Int)
            }
        }
        if let index = favoritePlayer.playerID.firstIndex(of: playerID){
            alreadyFavorite = true
        } else {
            saveFavorite(playerName: playerName, playerID: playerID)
        }
    }
}


