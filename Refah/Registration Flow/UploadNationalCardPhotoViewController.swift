//
//  UploadNationalCardPhotoViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit
import PhotosUI

class UploadNationalCardPhotoViewController: UIViewController {

    @IBOutlet weak var uploadFrontPhotoButton: UIButton!
    @IBOutlet weak var uploadBackPhotoButton: UIButton!
    @IBOutlet weak var frontPhotoImageView: UIImageView!
    @IBOutlet weak var backPhotoImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var frontPhotoWillBeUpload = true
    var frontPhotoUploaded = false
    var backPhotoUploaded = false
    
    @IBAction func uploadFrontPhotoButton(_ sender: UIButton) {
        self.frontPhotoWillBeUpload = true
        self.presentActionSheet()
    }
    
    @IBAction func uploadBackPhotoButtonPressed(_ sender: UIButton) {
        self.frontPhotoWillBeUpload = false
        self.presentActionSheet()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.frontPhotoUploaded && self.backPhotoUploaded {
            self.performSegue(withIdentifier: "nationalCardPhotoToPostalAddressSegue", sender: nil)
        } else if self.frontPhotoUploaded && !self.backPhotoUploaded {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا تصویر پشت کارت‌ملی خود را بارگزاری کنید.")
        } else if !self.frontPhotoUploaded && self.backPhotoUploaded {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا تصویر روی کارت‌ملی خود را بارگزاری کنید.")
        } else {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "لطفا تصویر پشت و روی کارت‌ملی خود را بارگزاری کنید.")
        }
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { alertAction in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                
                self.present(imagePickerController, animated: true)
            } else {
                self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor(named: "Flame Hawkfish")!, message: "دسترسی به دوربین امکان‌پذیر نیست.")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "گالری", style: .default, handler: { alertAction in
            var configuration = PHPickerConfiguration()
            configuration.filter = .images
            
            let phPicker = PHPickerViewController(configuration: configuration)
            phPicker.delegate = self
            self.present(phPicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "انصراف", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uploadFrontPhotoButton.layer.cornerRadius = 10
        self.uploadBackPhotoButton.layer.cornerRadius = 10
        
        self.nextButton.layer.cornerRadius = 20
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension UploadNationalCardPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if self.frontPhotoWillBeUpload {
                self.frontPhotoImageView.image = image
                self.frontPhotoUploaded = true
            } else {
                self.backPhotoImageView.image = image
                self.backPhotoUploaded = true
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension UploadNationalCardPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self,let image = image as? UIImage else { return }
                    
                    if self.frontPhotoWillBeUpload {
                        self.frontPhotoImageView.image = image
                        self.frontPhotoUploaded = true
                    } else {
                        self.backPhotoImageView.image = image
                        self.backPhotoUploaded = true
                    }
                }
            }
        }
    }
}
