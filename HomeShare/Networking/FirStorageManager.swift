//
//  FirStorageManager.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 22/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase

class FirStorageManager: ObservableObject {
    // Singleton
    static let shared = FirStorageManager()

    // MARK: - Storage Reference's
    var baseRef: StorageReference = Storage.storage().reference()
    var userRef: StorageReference {
        return baseRef.child("\(FirAuthManager.shared.session?.uid)")
    }

    // MARK: - Data
    func upload(_ image: UIImage, completion: @escaping (_ url: URL?) -> Void) {
        let timestamp = NSDate().timeIntervalSince1970 // Epoch Time
        let imageName:String = String("\(timestamp).jpg")
        let imagePath = userRef.child(imageName)
        
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
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
        let imageStorageRef = Storage.storage().reference(forURL: imageWithURL)
        imageStorageRef.downloadURL { (url, error) in
            guard let imageURL = url, error == nil else {
                completion(nil)
                return
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: imageURL) { data, response, error in
                if error != nil {
                    print("🐞 Storage Error: \(String(describing: error))")
                    completion(nil)
                } else {
                    let image = UIImage(data: data!)
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }

}
