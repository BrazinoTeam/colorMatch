//
//  HomeVC.swift

import Foundation
import UIKit
import SnapKit
import MessageUI
import StoreKit

final class HomeVC: UIViewController, MFMailComposeViewControllerDelegate {

    private var fullScreenViewBonus: UIView?
    private let appID = "123456789"

    private var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCoints()
        removeBall()
    }
    
    private func updateCoints() {
        contentView.subTitleLabel.text = "\(UD.shared.scoreCoints)"
        contentView.bonusesLabel.text = "\(UD.shared.scoreBonuses)"
        contentView.playedLabel.text = "\(UD.shared.scorePlayed)"
    }
    
    private func tappedButtons() {
        contentView.playBtn.addTarget(self, action: #selector(goGame), for: .touchUpInside)
        contentView.leadBtn.addTarget(self, action: #selector(goLeaders), for: .touchUpInside)
        contentView.infoBtn.addTarget(self, action: #selector(goInfo), for: .touchUpInside)
        contentView.profileBtn.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        contentView.bonusBtn.addTarget(self, action: #selector(goBonus), for: .touchUpInside)
        contentView.settingBtn.addTarget(self, action: #selector(goSettings), for: .touchUpInside)

    }
    
    
    private func removeBall() {
        self.contentView.imgBallLead.layer.removeAllAnimations()
        self.contentView.imgBallLead.center = CGPoint(x: self.contentView.leadBtn.bounds.width / 2, y: self.contentView.leadBtn.bounds.height / 2 - 52)
        
        self.contentView.imgBallInfo.layer.removeAllAnimations()
        self.contentView.imgBallInfo.center = CGPoint(x: self.contentView.infoBtn.bounds.width / 2, y: self.contentView.infoBtn.bounds.height / 2 - 52)

        self.contentView.imgBallProfile.layer.removeAllAnimations()
        self.contentView.imgBallProfile.center = CGPoint(x: self.contentView.profileBtn.bounds.width / 2, y: self.contentView.profileBtn.bounds.height / 2 - 52)

        self.contentView.imgBallBonus.layer.removeAllAnimations()
        self.contentView.imgBallBonus.center = CGPoint(x: self.contentView.bonusBtn.bounds.width / 2, y: self.contentView.bonusBtn.bounds.height / 2 - 52)

        self.contentView.imgBallSettings.layer.removeAllAnimations()
        self.contentView.imgBallSettings.center = CGPoint(x: self.contentView.settingBtn.bounds.width / 2, y: self.contentView.settingBtn.bounds.height / 2 - 52)

    }
    
    @objc func goGame() {
        let vc = GameVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goLeaders() {
        let animationDuration: CFTimeInterval = 0.5
        let dropDistance: CGFloat = 180
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = self.contentView.imgBallLead.layer.position.y
        animation.toValue = self.contentView.imgBallLead.layer.position.y + dropDistance
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.contentView.imgBallLead.layer.add(animation, forKey: "position.y")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let vc = LeadersVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.contentView.imgBallLead.layer.position.y += dropDistance
            self.contentView.imgBallLead.frame.origin.y += dropDistance
        }
    }

    @objc func goInfo() {
        let animationDuration: CFTimeInterval = 0.5
        let dropDistance: CGFloat = 180
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = self.contentView.imgBallInfo.layer.position.y
        animation.toValue = self.contentView.imgBallInfo.layer.position.y + dropDistance
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.contentView.imgBallInfo.layer.add(animation, forKey: "position.y")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let vc = InfoVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.contentView.imgBallInfo.layer.position.y += dropDistance
            self.contentView.imgBallInfo.frame.origin.y += dropDistance
        }   
    }
    
    @objc func goProfile() {
        let animationDuration: CFTimeInterval = 0.5
        let dropDistance: CGFloat = 180
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = self.contentView.imgBallProfile.layer.position.y
        animation.toValue = self.contentView.imgBallProfile.layer.position.y + dropDistance
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.contentView.imgBallProfile.layer.add(animation, forKey: "position.y")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let vc = ProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.contentView.imgBallProfile.layer.position.y += dropDistance
            self.contentView.imgBallProfile.frame.origin.y += dropDistance
        }   
    }
    
    @objc func goBonus() {
        let animationDuration: CFTimeInterval = 0.5
        let dropDistance: CGFloat = 180
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = self.contentView.imgBallBonus.layer.position.y
        animation.toValue = self.contentView.imgBallBonus.layer.position.y + dropDistance
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.contentView.imgBallBonus.layer.add(animation, forKey: "position.y")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let vc = BonusVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            self.contentView.imgBallBonus.layer.position.y += dropDistance
            self.contentView.imgBallBonus.frame.origin.y += dropDistance
        }
    }
    
    @objc func goSettings() {
        let animationDuration: CFTimeInterval = 0.5
        let dropDistance: CGFloat = 180
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = self.contentView.imgBallSettings.layer.position.y
        animation.toValue = self.contentView.imgBallSettings.layer.position.y + dropDistance
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.contentView.imgBallSettings.layer.add(animation, forKey: "position.y")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.presentSetingsView()

            self.contentView.imgBallSettings.layer.position.y += dropDistance
            self.contentView.imgBallSettings.frame.origin.y += dropDistance
        }
    }
    
    func presentSetingsView() {
       if fullScreenViewBonus == nil {
           fullScreenViewBonus = UIView(frame: self.view.bounds)
           fullScreenViewBonus!.backgroundColor = .cDarkBlue.withAlphaComponent(0.8)
           fullScreenViewBonus!.alpha = 0
           
           let imageView = UIImageView(image: .imgContSettings)
           imageView.contentMode = .scaleAspectFit
           imageView.layer.shadowColor = UIColor.cYellow.cgColor
           imageView.layer.shadowOpacity = 1
           imageView.layer.shadowRadius = 44
           imageView.layer.shadowOffset = CGSize(width: 0, height: 0)

           fullScreenViewBonus!.addSubview(imageView)
           
           let titleLabel = UILabel()
           titleLabel.text = "Settings"
           titleLabel.font = .customFont(font: .squadaOne, style: .regular, size: 36)
           titleLabel.textColor = .white
           titleLabel.numberOfLines = 0
           titleLabel.textAlignment = .center
           imageView.addSubview(titleLabel)
           
           let btnRateUs = UIButton()
           btnRateUs.setImage(.btnRateUs, for: .normal)
           btnRateUs.addTarget(self, action: #selector(tappedRateUs), for: .touchUpInside)
           fullScreenViewBonus!.addSubview(btnRateUs)
           
           let rateUsLabel = UILabel()
           rateUsLabel.text = "Rate Us".uppercased()
           rateUsLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
           rateUsLabel.textColor = .white
           rateUsLabel.numberOfLines = 0
           rateUsLabel.textAlignment = .center
           imageView.addSubview(rateUsLabel)
           
           let btnWriteUs = UIButton()
           btnWriteUs.setImage(.btnWriteUs, for: .normal)
           btnWriteUs.addTarget(self, action: #selector(tappedWriteUs), for: .touchUpInside)
           fullScreenViewBonus!.addSubview(btnWriteUs)
           
           let writeUsLabel = UILabel()
           writeUsLabel.text = "Write US".uppercased()
           writeUsLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
           writeUsLabel.textColor = .white
           writeUsLabel.numberOfLines = 0
           writeUsLabel.textAlignment = .center
           imageView.addSubview(writeUsLabel)

           let btnHome = UIButton()
           btnHome.setImage(.btnHome, for: .normal)
           btnHome.setImage(.btnHomeTapped, for: .highlighted)
           btnHome.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
           fullScreenViewBonus!.addSubview(btnHome)
          
           
           imageView.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.centerY.equalToSuperview()
           }
           
           titleLabel.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.top.equalTo(imageView.snp.top).offset(40)
           }
           
           btnRateUs.snp.makeConstraints { make in
               make.centerX.equalToSuperview().offset(-76)
               make.top.equalTo(titleLabel.snp.bottom).offset(40)
           }
         
           rateUsLabel.snp.makeConstraints { make in
               make.centerX.equalTo(btnRateUs)
               make.top.equalTo(btnRateUs.snp.bottom)
           }
           
           btnWriteUs.snp.makeConstraints { make in
               make.centerX.equalToSuperview().offset(76)
               make.top.equalTo(titleLabel.snp.bottom).offset(40)
           }
         
           writeUsLabel.snp.makeConstraints { make in
               make.centerX.equalTo(btnWriteUs)
               make.top.equalTo(btnWriteUs.snp.bottom)
           }
           
           btnHome.snp.makeConstraints { make in
               make.centerX.equalToSuperview()
               make.top.equalTo(writeUsLabel.snp.bottom).offset(40)
           }
          
           
           self.view.addSubview(fullScreenViewBonus!)
       }
       UIView.animate(withDuration: 0.5, animations: {
           self.fullScreenViewBonus!.alpha = 1
       })
   }
   
    @objc func tappedRateUs() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        } else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func tappedWriteUs() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["developer@example.com"]) // Replace with your developer email
            mail.setSubject("Feedback on \(Settings.appTitle) App")
            mail.setMessageBody("<p>Dear Developer,</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // Show alert informing the user
            let alert = UIAlertController(title: "Error", message: "Mail services are not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
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

