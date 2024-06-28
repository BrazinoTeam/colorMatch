import Foundation
import UIKit
import SnapKit

final class ProfileVC: UIViewController {

    private var fullScreenViewBonus: UIView?
    private let imagePicker = UIImagePickerController()

    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAchiv()
    }

    
    private func pickerDelegate() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    private func checkAchiv() {
        if UD.shared.beginner {
                contentView.achiOne.achiImage.image = .imgAchiOne
            } else {
                contentView.achiOne.achiImage.image = .imgAchiOneLock
                if let originalImage = contentView.achiOne.achiImage.image {
                    if let blurredImage = originalImage.applyBlurEffect(radius: 8, intensity: -0.7) {
                        contentView.achiOne.achiImage.image = blurredImage
                    }
                }
            }
        
        if UD.shared.sharpshooter {
                contentView.achiTwo.achiImage.image = .imgAchiTwo
            } else {
                contentView.achiTwo.achiImage.image = .imgAchiTwoLock
                if let originalImage = contentView.achiTwo.achiImage.image {
                    if let blurredImage = originalImage.applyBlurEffect(radius: 8, intensity: -0.7) {
                        contentView.achiTwo.achiImage.image = blurredImage
                    }
                }
            }
        
        if UD.shared.collectingCombo {
                contentView.achiThree.achiImage.image = .imgAchiThree
            } else {
                contentView.achiThree.achiImage.image = .imgAchiThreeLock
                if let originalImage = contentView.achiThree.achiImage.image {
                    if let blurredImage = originalImage.applyBlurEffect(radius: 8, intensity: -0.7) {
                        contentView.achiThree.achiImage.image = blurredImage
                    }
                }
            }
        
        if UD.shared.dedicated {
                contentView.achiFour.achiImage.image = .imgAchiFour
            } else {
                contentView.achiFour.achiImage.image = .imgAchiFourLock
                if let originalImage = contentView.achiOne.achiImage.image {
                    if let blurredImage = originalImage.applyBlurEffect(radius: 8, intensity: -0.7) {
                        contentView.achiFour.achiImage.image = blurredImage
                    }
                }
            }
        
        if UD.shared.pointGiant {
                contentView.achiFive.achiImage.image = .imgAchiFive
            } else {
                contentView.achiFive.achiImage.image = .imgAchiFiveLock
                if let originalImage = contentView.achiFive.achiImage.image {
                    if let blurredImage = originalImage.applyBlurEffect(radius: 8, intensity: -0.7) {
                        contentView.achiFive.achiImage.image = blurredImage
                    }
                }
            }
    }
    
    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        contentView.btnEditName.addTarget(self, action: #selector(tappeUpdateName), for: .touchUpInside)
        contentView.btnEditPhoto.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        
        let achiOneTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiOne))
        contentView.achiOne.addGestureRecognizer(achiOneTap)
        contentView.achiOne.isUserInteractionEnabled = true
        
        let achiTwoTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiTwo))
        contentView.achiTwo.addGestureRecognizer(achiTwoTap)
        contentView.achiTwo.isUserInteractionEnabled = true
        
        let achiThreeTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiThree))
        contentView.achiThree.addGestureRecognizer(achiThreeTap)
        contentView.achiThree.isUserInteractionEnabled = true
        
        let achiFourTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiFour))
        contentView.achiFour.addGestureRecognizer(achiFourTap)
        contentView.achiFour.isUserInteractionEnabled = true
        
        let achiFiveTap = UITapGestureRecognizer(target: self, action: #selector(tappedAchiFive))
        contentView.achiFive.addGestureRecognizer(achiFiveTap)
        contentView.achiFive.isUserInteractionEnabled = true

    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappeUpdateName() {
        contentView.profileTextField.becomeFirstResponder()
    }
    
    @objc func goTakePhoto() {
        let alert = UIAlertController(title: "Pick Library", message: nil, preferredStyle: .actionSheet)
        
        let actionLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc private func tappedAchiOne() {
        presentAchivView(image: .imgAchiOne, title: "Beginner", subTitle: "Close the first number\non the playing field")
      }
    
    @objc private func tappedAchiTwo() {
        presentAchivView(image: .imgAchiTwo, title: "Sharpshooter", subTitle: "Hit the ball into the center\nzone of the target")
      }
    
    @objc private func tappedAchiThree() {
        presentAchivView(image: .imgAchiThree, title: "Collecting combo", subTitle: "Close 3 numbers in\na row without mistakes")
      }
    
    @objc private func tappedAchiFour() {
        presentAchivView(image: .imgAchiFour, title: "Dedicated", subTitle: "Score 500 points\nin one game")
      }
    
    @objc private func tappedAchiFive() {
        presentAchivView(image: .imgAchiFive, title: "Point Giant", subTitle: "Score 10,000 points\nin a single game career")
      }
    
    func presentAchivView(image: UIImage, title: String, subTitle: String) {
       if fullScreenViewBonus == nil {
           fullScreenViewBonus = UIView(frame: self.view.bounds)
           fullScreenViewBonus!.backgroundColor = .cDarkBlue.withAlphaComponent(0.8)
           fullScreenViewBonus!.alpha = 0
           
           let imageView = UIImageView(image: .imgContPresentView)
           imageView.contentMode = .scaleAspectFit
           imageView.layer.shadowColor = UIColor.cYellow.cgColor
           imageView.layer.shadowOpacity = 1
           imageView.layer.shadowRadius = 44
           imageView.layer.shadowOffset = CGSize(width: 0, height: 0)

           fullScreenViewBonus!.addSubview(imageView)
           
           let imgAchi = UIImageView(image: image)
           imgAchi.contentMode = .scaleAspectFit
           imageView.addSubview(imgAchi)
           
           let titleLabel = UILabel()
           titleLabel.text = title
           titleLabel.font = .customFont(font: .squadaOne, style: .regular, size: 54)
           titleLabel.textColor = .cYellow
           titleLabel.numberOfLines = 0
           titleLabel.textAlignment = .center
           imageView.addSubview(titleLabel)

           let subTitleLabel = UILabel()
           subTitleLabel.text = subTitle
           subTitleLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
           subTitleLabel.textColor = .white
           subTitleLabel.numberOfLines = 0
           subTitleLabel.textAlignment = .center
           imageView.addSubview(subTitleLabel)
           
           let btnOK = UIButton()
           btnOK.setImage(.btnOK, for: .normal)
           btnOK.setImage(.btnOKTapped, for: .highlighted)
           btnOK.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
           fullScreenViewBonus!.addSubview(btnOK)
          
           
           imageView.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.centerY.equalToSuperview()
               make.height.equalTo(492)
           }
           
           imgAchi.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(40)
               make.centerX.equalToSuperview()
               make.size.equalTo(192)
           }
           
           titleLabel.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.top.equalTo(imgAchi.snp.bottom).offset(14)
           }
         
           subTitleLabel.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.top.equalTo(titleLabel.snp.bottom).offset(12)
           }
           
           btnOK.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.top.equalTo(subTitleLabel.snp.bottom).offset(28)
           }
          
           
           self.view.addSubview(fullScreenViewBonus!)
       }
       UIView.animate(withDuration: 0.5, animations: {
           self.fullScreenViewBonus!.alpha = 1
       })
   }
    
   @objc func tappedCloseBuy() {
       UIView.animate(withDuration: 0.5, animations: {
           self.fullScreenViewBonus?.alpha = 0
       }) { _ in
           self.fullScreenViewBonus?.removeFromSuperview()
           self.fullScreenViewBonus = nil
       }
   }
}

extension ProfileVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocal(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id  = UD.shared.userID {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
            try? data.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImageFromLocal() -> UIImage? {
        guard let id = UD.shared.userID else { return nil }
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            contentView.imgUser.image = image
            saveImageToLocal(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: UINavigationControllerDelegate {
    
}


extension UIImage {
    func applyBlurEffect(radius: Int, intensity: Float) -> UIImage? {
        let context = CIContext(options: nil)
        guard let imageToBlur = CIImage(image: self) else { return nil }
        
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(imageToBlur, forKey: kCIInputImageKey)
        
        guard let currentFilter = CIFilter(name: "CIGaussianBlur") else { return nil }
        currentFilter.setValue(clampFilter?.outputImage, forKey: kCIInputImageKey)
        currentFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        guard let exposureAdjustFilter = CIFilter(name: "CIExposureAdjust") else { return nil }
        exposureAdjustFilter.setValue(currentFilter.outputImage, forKey: kCIInputImageKey)
        exposureAdjustFilter.setValue(intensity, forKey: kCIInputEVKey)
        
        guard let output = exposureAdjustFilter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(output, from: imageToBlur.extent) else { return nil }
        
        let blurredImage = UIImage(cgImage: cgImage)
        
        // Crop to original size
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        blurredImage.draw(in: CGRect(origin: .zero, size: size))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage
    }
}
