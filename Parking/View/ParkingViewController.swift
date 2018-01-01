//
//  ParkingViewController.swift
//  Parking
//
//  Created by Avi Davidov on 02/11/2017.
//  Copyright © 2017 Avi Davidov. SwiftOcrTest.com. All rights reserved.
//

import UIKit

class ParkingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func TakeImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagePicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        FirebaseController.uploadImage(image: imagePicked)
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
