//
//  NationalCardViewController.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 4/28/23.
//

import UIKit
import PhotosUI

class NationalCardViewController: UIViewController {
    private var nationalCardView: NationalCardViewProtocol = NationalCardView()
        
    var uploadingStatus = UploadingStatus.front
    var nationalCardPhoto: NationalCardPhotoProtocol = NationalCardPhoto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nationalCardView.flowNextDelegate = self
        self.nationalCardView.buttonsTouchUpInsideDelegate = self
    }
    
    override func loadView() {
        self.view = self.nationalCardView
    }
}

extension NationalCardViewController {
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { alertAction in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                
                self.present(imagePickerController, animated: true)
            } else {
                self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor.flameHawkfish!, message: "دسترسی به دوربین امکان‌پذیر نیست.")
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
}

extension NationalCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        switch self.uploadingStatus {
        case .front:
            self.nationalCardPhoto.setFront(image: image)
            self.nationalCardView.setFrontImageViewWith(image: image)
        case .back:
            self.nationalCardPhoto.setBack(image: image)
            self.nationalCardView.setBackImageViewWith(image: image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension NationalCardViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self,let image = image as? UIImage else { return }
                    
                    switch self.uploadingStatus {
                    case .front:
                        self.nationalCardPhoto.setFront(image: image)
                        self.nationalCardView.setFrontImageViewWith(image: image)
                    case .back:
                        self.nationalCardPhoto.setBack(image: image)
                        self.nationalCardView.setBackImageViewWith(image: image)
                    }
                }
            }
        }
    }
}

extension NationalCardViewController: RegistrationFlowNextDelegate {
    func next() {
        if self.nationalCardPhoto.hasFront() && self.nationalCardPhoto.hasBack() {
            self.performSegue(withIdentifier: "NationalCard_to_PostalAddress", sender: nil)
        } else if self.nationalCardPhoto.hasFront() && !self.nationalCardPhoto.hasBack() {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor.flameHawkfish!, message: "لطفا تصویر پشت کارت‌ملی خود را بارگزاری کنید.")
        } else if !self.nationalCardPhoto.hasFront() && self.nationalCardPhoto.hasBack() {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor.flameHawkfish!, message: "لطفا تصویر روی کارت‌ملی خود را بارگزاری کنید.")
        } else {
            self.presentUIAlertController(title: "عملیات ناموفق", titleColor: UIColor.flameHawkfish!, message: "لطفا تصویر پشت و روی کارت‌ملی خود را بارگزاری کنید.")
        }
    }
}

extension NationalCardViewController: UploadPhotoButtonsTouchUpInsideDelegate {
    func frontButtonDidTouchUpInside() {
        self.uploadingStatus = .front
        self.presentActionSheet()
    }
    
    func backButtonDidTouchUpInside() {
        self.uploadingStatus = .back
        self.presentActionSheet()
    }
}
