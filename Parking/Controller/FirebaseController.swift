//
//  FirebaseController.swift
//  Uber
//
//  Created by Avi Davidov on 11/09/2017.
//  Copyright © 2017 Avi Davidov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Alamofire


class FirebaseController: NSObject {
    
    static let shared = FirebaseController()
    static let reference = Database.database().reference().child("uberRequests")
    static let uid : String = (Auth.auth().currentUser?.uid)!
    static let username = Auth.auth().currentUser?.email

    func getSnap() {
       
        
        
    }
    
    class func uploadImage(image : UIImage) {
        
        let carStorageRef = Storage.storage().reference().child("images").child("carPlateImages")
        guard let imageData = UIImageJPEGRepresentation(image, 0.3) else {
            print("Error with converting imge to data")
            return
        }
        let imageref = carStorageRef.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                //Some problem with upload the image

                print(error.localizedDescription)
            }else {
            
                if metadata != nil {
                    
                    
                    if let imageUrl = metadata?.downloadURL()?.absoluteString{
                        
                        let url = "https://api.openalpr.com/v2/recognize_url?image_url=\(imageUrl) &secret_key=sk_a173683074494aa49e7c726e&recognize_vehicle=0&country=usa&return_image=0&topn=10"

                        Alamofire.request(url, method:.post, parameters: [:], encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { (dataResponse) in
                            
                            if let response = dataResponse.value {
                                
                                print(response)
                            }else{
                                
                                //error
                            }
                        })
                    }
                    

                }
            }
            
        }
    }
}
