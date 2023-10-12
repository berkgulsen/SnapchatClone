//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 11.10.2023.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }

    @objc func imageViewTapped() {
        showImagePicker()
    }

    func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestore = Firestore.firestore()
                            
                            let snapDictionary = [
                                "imageUrl": imageUrl!,
                                "snapOwner": UserSingleton.sharedUserInfo.username,
                                "Date": FieldValue.serverTimestamp()
                            ]
                            
                            firestore.collection("Snaps").addDocument(data: snapDictionary) { error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                                } else {
                                    self.tabBarController?.selectedIndex = 0
                                    self.imageView.image = UIImage(named: "taphere")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
