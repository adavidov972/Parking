//
//  APIManager.swift
//  Parking
//
//  Created by Avi Davidov on 02/01/2018.
//  Copyright © 2018 Avi Davidov. SwiftOcrTest.com. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON


class APIManager {
    
    static let manager = APIManager()
    
    func uploadImageToAlpr (image : UIImage, complition : @escaping (NSDictionary?, Error?) -> Void) {
        
        let params : [String:String] = ["secret_key" : "sk_a173683074494aa49e7c726e", "recognize_vehicle" : "0", "country" : "eu", "return_image" : "0", "topn" : "10"]
        
        var paramString = ""
        for (key,val) in params{
            paramString += key
            paramString += "="
            paramString += val
            paramString += "&"
        }
        
        print(paramString)
        
        let url = "https://api.openalpr.com/v2/recognize?" + paramString
        
        Alamofire.upload(multipartFormData: { (data) in
            data.append(UIImageJPEGRepresentation(image, 1)!, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: url, method: .post) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    guard let responseDic = response.result.value as? [String:Any] else{
                        print(response.result.error?.localizedDescription ?? "unkown error")
                        return
                    }
                    let json = JSON (responseDic)
                    print(json)
                    
                    let monthlyCredit = json ["credits_monthly_used"].stringValue
                    
                    print("monthlyCredit is " + monthlyCredit)
                    
                    let resultsArray = json["results"].arrayObject
                    let resultArray = JSON(resultsArray)
                    let carPlateNumber = resultArray["plate"]
                    
                    print(resultArray)
                    
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
