//
//  ImagePicker.swift
//  Poritos
//
//  Created by Gerson Lima on 15/10/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> UIImagePickerCoordinator {
        return UIImagePickerCoordinator(image: $image)
    }
}

class UIImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: Image?

    init(image: Binding<Image?>) {
        _image = image
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            image = Image(uiImage: uiImage)
        }

        picker.dismiss(animated: true, completion: nil)
    }
}

