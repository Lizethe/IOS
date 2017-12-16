//
//  ViewController.swift
//  ClientRegistration
//
//  Created by Lizeth Ovando on 12/11/17.
//  Copyright © 2017 com.client.registration. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var client:Client?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        name.delegate = self
        
        if let client = client {
            self.navigationItem.title = client.name
            self.name.text = client.name
            self.lastName.text = client.lastName
            self.photo.image = client.photo
            //self.phone.text = client.phone
            //self.birthday.text  = client.birthday
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photo.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        let isPresentingInAddClientMode = presentingViewController is UINavigationController
        if isPresentingInAddClientMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ClientViewController is not inside a navigation controller.")
        }
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
       if   let button = sender as? UIBarButtonItem, button === saveButton
        {
            
            let name = self.name.text ?? "No Name"
            let lastName = self.lastName.text!
            let phone = self.phone.text!
            let birthday = self.birthday.text!
            let address = self.address.text!
            let photo = self.photo.image
            
            
            let id = client != nil ? client?.id :  NSUUID().uuidString
            
            client = Client(id:id!, name: name, lastName: lastName, photo:photo, phone:phone, birthday: birthday, address: address)
        }
    }
    
    
}

