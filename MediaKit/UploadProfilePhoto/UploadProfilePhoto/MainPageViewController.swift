//
//  MainPageViewController.swift
//  UploadProfilePhoto
//
//  Created by Tommy Trojan on 12/21/15.
//  Copyright © 2015 Chris Mendez. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func uploadPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        //Present a User with an image picker
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MainPageViewController: UIImagePickerControllerDelegate{

    //A user has picked an image from their PhotoLibrary
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //This will take a selected image from info object as set it to our UIImageView
        profileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //Dismiss the image picker
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


extension MainPageViewController: UINavigationControllerDelegate{
    
}