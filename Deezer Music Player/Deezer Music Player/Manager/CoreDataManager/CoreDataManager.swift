//
//  CoreDataManager.swift
//  Deezer Music Player
//
//  Created by Emincan Antalyalı on 10.05.2023.
//


import CoreData
import UIKit

class CoreDataManager{
    static let shared = CoreDataManager()
    
    
    //MARK: - save
    func saveCoreData(withModel: SongsResponseDatum){
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            
            let entityDescription = NSEntityDescription.insertNewObject(forEntityName: "SongData", into: context)
            

            entityDescription.setValue(withModel.id, forKey: "id")
            entityDescription.setValue(withModel.preview, forKey: "preview")
            entityDescription.setValue(withModel.title, forKey: "title")
            entityDescription.setValue(withModel.diskNumber, forKey: "diskNumber")
            entityDescription.setValue(withModel.duration, forKey: "duration")
            entityDescription.setValue(withModel.explicitContentCover, forKey: "explicitContentCover")
            entityDescription.setValue(withModel.explicitContentLyrics, forKey: "explicitContentLyrics")
            entityDescription.setValue(withModel.explicitLyrics, forKey: "explicitLyrics")
            entityDescription.setValue(withModel.isrc, forKey: "isrc")
            entityDescription.setValue(withModel.link, forKey: "link")
            entityDescription.setValue(withModel.md5Image, forKey: "md5Image")
            entityDescription.setValue(withModel.rank, forKey: "rank")
            entityDescription.setValue(withModel.readable, forKey: "readable")
            entityDescription.setValue(withModel.titleShort, forKey: "titleShort")
            entityDescription.setValue(withModel.titleVersion, forKey: "titleVersion")
            entityDescription.setValue(withModel.trackPosition, forKey: "trackPosition")
            entityDescription.setValue(withModel.type, forKey: "type")
            // for artist
            entityDescription.setValue(withModel.artist.id, forKey: "artistID")
            entityDescription.setValue(withModel.artist.name, forKey: "artistName")
            entityDescription.setValue(withModel.artist.tracklist, forKey: "artistTracklist")
            entityDescription.setValue(withModel.artist.type, forKey: "artistType")
            entityDescription.setValue(withModel.imageUrl, forKey: "imageUrl")
            
            
            do{
                try context.save()
                print("Saved")
            }catch{
                print("Saving Error")
            }
        }
        
        
    }
    //MARK: - delete
    
    func deleteCoreData(with dataId: Int){
        
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"SongData")
            fetchRequest.returnsObjectsAsFaults = false
            
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(dataId)")
            
            do{
                let results = try context.fetch(fetchRequest)
                
                if results.count>0{
                    for result in results as! [NSManagedObject] {
                        
                        context.delete(result)
                   //     print("Delete?")
                        do {
                            try context.save()
                            print("Deleted")
                        } catch  {
                            print("error deleting")
                        }
                        
                    }
                }
            } catch {
                print("error deleting")
            }
            
        }
    }
    
    //MARK: - fetch
    func getDataForFavs(completion: @escaping ((Result<[SongsResponseDatum],Error>) -> Void)){
        var AnArray: [SongsResponseDatum] = []
        if let appDelegate = UIApplication.shared.delegate as?AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"SongData")
            fetchRequest.returnsObjectsAsFaults = false
            
            
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    AnArray.append(SongsResponseDatum(id: result.value(forKey: "id") as! Int,
                                                      readable: result.value(forKey: "readable") as? Bool ?? false,
                                                      title: result.value(forKey: "title") as! String,
                                                      titleShort: result.value(forKey: "titleShort") as? String,
                                                      titleVersion: result.value(forKey: "titleVersion") as? String,
                                                      isrc: result.value(forKey: "isrc") as? String,
                                                      link: result.value(forKey: "link") as! String,
                                                      duration: result.value(forKey: "duration") as! Int,
                                                      trackPosition: result.value(forKey: "trackPosition") as! Int,
                                                      diskNumber: result.value(forKey: "diskNumber") as! Int,
                                                      rank: result.value(forKey: "rank") as! Int,
                                                      explicitLyrics: result.value(forKey: "explicitLyrics") as? Bool ?? false,
                                                      explicitContentLyrics: result.value(forKey: "explicitContentLyrics") as! Int,
                                                      explicitContentCover: result.value(forKey: "explicitContentCover") as! Int,
                                                      preview: result.value(forKey: "preview") as! String,
                                                      md5Image: result.value(forKey: "md5Image") as! String,
                                            
                                                      // for artist
                                                      artist: Artist(id: result.value(forKey: "artistID") as? Int ?? 0,
                                                                     name: result.value(forKey: "artistName") as? String ?? "",
                                                                     tracklist: result.value(forKey: "artistTracklist") as? String ?? "",
                                                                     type: result.value(forKey: "artistType") as? String ?? "") ,
                                                      type: result.value(forKey: "type") as! String,
                                                      imageUrl: result.value(forKey: "imageUrl") as? String))
                }
                completion(.success(AnArray))
            } catch  {
                
            }
        }
        
    }
}
