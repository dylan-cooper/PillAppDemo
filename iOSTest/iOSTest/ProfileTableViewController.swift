//
//  ProfileTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-02.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidLayoutSubviews() {
        imageContainer.layer.cornerRadius = imageContainer.frame.width/2
        imageContainer.layer.masksToBounds = true
    }
    
    @IBAction func didTapEditPictureButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        headerImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
