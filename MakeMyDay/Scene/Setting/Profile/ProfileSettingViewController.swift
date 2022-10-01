//
//  ProfileSettingViewController.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/25.
//

import UIKit

class ProfileSettingViewController: BaseViewController, UINavigationControllerDelegate {
    lazy var mainView = ProfileSettingView()
        
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        configureProfile()
        
        mainView.imagePicker.delegate = self
    }
    
    override func configure() {
        mainView.loadImageButton.addTarget(self, action: #selector(loadImageButtonTapped), for: .touchUpInside)
        mainView.resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    private func configureProfile() {
        let name = ImageFileManager.shared.profileImageName
        
        if User.profileImageBool {
            if let image: UIImage = ImageFileManager.shared.getSavedImage(named: name) {
                mainView.imageView.image = image
            }
        } else {
            mainView.imageView.image = themeType().profileImage
        }
        
        if User.profileNameBool {
            mainView.nicknameTextField.attributedPlaceholder = NSAttributedString(string: " \(User.profileName) (1~8글자)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        } else {
            mainView.nicknameTextField.attributedPlaceholder = NSAttributedString(string: " D (1~8글자)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        }
    }

    func setNavigationItem() {
        let doneButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        doneButtonItem.tintColor = themeType().tintColor
    
        self.navigationItem.rightBarButtonItems = [doneButtonItem]
    }
    
    @objc func loadImageButtonTapped() {
        present(mainView.imagePicker, animated: true)
    }
    
    @objc func saveButtonTapped() {
        saveImage()
        saveName()
        
        navigationController?.popViewController(animated: true)
    }
    
    func saveImage() {
        let name = ImageFileManager.shared.profileImageName
        if User.profileImageBool {
  
            if let image = mainView.imageView.image {
                User.profileImageBool = true
                
                ImageFileManager.shared
                    .saveImage(image: image,
                             name: name) { [weak self] onSuccess in
                  print("saveImage onSuccess: \(onSuccess)")
                }
            } else {
                User.profileImageBool = true
            }
        } else {
            
            if let image = mainView.imageView.image {
                User.profileImageBool = true
                
                ImageFileManager.shared
                    .saveImage(image: image,
                             name: name) { [weak self] onSuccess in
                  print("saveImage onSuccess: \(onSuccess)")
                }
            } else {
                User.profileImageBool = false
            }
        }
      
    }
    
    func saveName() {
        if User.profileNameBool {
            if let text = mainView.nicknameTextField.text {
                if text.count > 8  {
                    showAlert(title: "", message: "닉네임은 1~8글자만 가능합니다!", buttonTitle: "확인")
                } else if text.count < 1 {
                    User.profileNameBool = true
                } else {
                    User.profileNameBool = true
                    User.profileName = text
                }
            }
        } else {
            if let text = mainView.nicknameTextField.text {
                if text.count > 8  {
                    showAlert(title: "", message: "닉네임은 1~8글자만 가능합니다!", buttonTitle: "확인")
                } else if text.count < 1 {
                    User.profileNameBool = false
                } else {
                    User.profileNameBool = true
                    User.profileName = text
                }
            }
        }
    }
    
    @objc func resetButtonTapped() {
        User.profileNameBool = false
        User.profileImageBool = false
        navigationController?.popViewController(animated: true)
    }
    
}
extension ProfileSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           var newImage: UIImage? = nil // update 할 이미지
           
           if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
               newImage = possibleImage // 수정된 이미지가 있을 경우
           } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               newImage = possibleImage // 원본 이미지가 있을 경우
           }
           
        self.mainView.imageView.image = newImage // 받아온 이미지를 update
           picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
           
       }
}
