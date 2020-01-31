//
//  FirStorageManager.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 22/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase

//MARK: - 'asyncImagesCashArray' is a global varible cashed UIImage
var asyncImagesCashArray = NSCache<NSString, UIImage>()

class FirStorageManager: ObservableObject {
    // Singleton
    static let shared = FirStorageManager()

    // MARK: - Storage Reference's
    var baseRef: StorageReference = Storage.storage().reference()

    // MARK: - Data
    func upload(_ image: UIImage, completion: @escaping (_ url: URL?) -> Void) {
        let timestamp = NSDate().timeIntervalSince1970 // Epoch Time
        let imageName:String = String("\(timestamp).jpg")
        
        guard let userID = FirebaseService.shared.session?.uid else {
            completion(nil)
            return
        }
        
        let imagePath = baseRef.child(userID).child(imageName)
        
        if let uploadData = image.jpegData(compressionQuality: 0) {
            imagePath.putData(uploadData, metadata: nil) { metadata, error in
                if error != nil {
                    print("🐞 Storage Error: \(String(describing: error))")
                    completion(nil)
                } else {
                    imagePath.downloadURL { url, error in
                        completion(url!.absoluteURL)
                    }
                    
                }
            }
        }
    }
    
    func download(imageWithURL: String, completion: @escaping (_ image: UIImage?) -> Void) {
        // Check if image is already cashed locally
        if let cashedImage = asyncImagesCashArray.object(forKey: imageWithURL as NSString) {
            // Return it
            completion(cashedImage)
            return
        }
        
        // Else try to download it
        let imageStorageRef = Storage.storage().reference(forURL: imageWithURL)
        imageStorageRef.downloadURL { (url, error) in
            guard let imageURL = url, error == nil else {
                completion(nil)
                return
            }
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if error != nil {
                    print("🐞 Storage Error: \(String(describing: error))")
                    completion(nil)
                } else {
                    guard let image = UIImage(data: data!) else {
                        completion(nil)
                        return
                    }
                    asyncImagesCashArray.setObject(image, forKey: imageURL.absoluteString as NSString)
                    completion(image)
                }
            }.resume()
        }
    }
    
    func download(dataWithURL: String, completion: @escaping (_ data: Data?)-> Void) {
        let dataStorageRef = Storage.storage().reference(forURL: dataWithURL)
        dataStorageRef.downloadURL { (url, error) in
            guard let dataURL = url, error == nil else {
                completion(nil)
                return
            }
            URLSession.shared.dataTask(with: dataURL) { data, response, error in
                if error != nil {
                    print("🐞 Storage Error: \(String(describing: error))")
                    completion(nil)
                } else {
                    completion(data)
                }
            }.resume()
        }
    }
    
    func delete(fileWithURL: String, completion: @escaping (_ result: Bool)-> Void) {
        let fileStorageRef = Storage.storage().reference(forURL: fileWithURL)
        fileStorageRef.delete { error in
            if error != nil {
                print("🐞 Storage Error: \(String(describing: error))")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
