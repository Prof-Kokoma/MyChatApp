//
//  PictureInterface.swift
//  MyChatApp
//
//  Created by Prof K on 09/07/2023.
//

import UIKit

protocol PictureInterface: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var profilePicture: UIImageView { get set }
    func presentPhotoActionSheet(vc: UIViewController, conformer: PictureInterface)
    func presentCamera(delegate: PictureInterface, presenter: UIViewController)
    func presentPhotoPicker(delegate: PictureInterface, presenter: UIViewController)
}

extension PictureInterface {
    func presentPhotoActionSheet(vc: UIViewController, conformer: PictureInterface) {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would your like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera(delegate: conformer, presenter: vc)
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker(delegate: conformer, presenter: vc)
        }))
        vc.present(actionSheet, animated: true)
    }
    
    func presentCamera(delegate: PictureInterface, presenter: UIViewController) {
        print("Will be presenting camera here")
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = delegate
        vc.allowsEditing = true
        presenter.present(vc, animated: true)
    }
    func presentPhotoPicker(delegate: PictureInterface, presenter: UIViewController) {
        print("Will be presenting photo library here")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = delegate
        vc.allowsEditing = true
        presenter.present(vc, animated: true)
    }
}
