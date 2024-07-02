//
//  BonusVC.swift

import Foundation
import UIKit
import SnapKit

final class BonusVC: UIViewController {
    
    private var fullScreenViewBonus: UIView?
    private let ud = UD.shared
    private var isTime: Bool = true
    private var bonusArray: [ Int ] = [500, 200, 1000, 100, 300, 400, 600, 800, 5000]
    private var contentView: BonusView {
        view as? BonusView ?? BonusView()
    }
    
    override func loadView() {
        view = BonusView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            goDailyScreen()
    }
    
    
    
    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        contentView.timeBackBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        contentView.goBonus.addTarget(self, action: #selector(goBonus), for: .touchUpInside)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goBonus() {
        let randomIndex = Int.random(in: 0..<bonusArray.count)
        let randomBonus = bonusArray[randomIndex]
        ud.scoreCoints += randomBonus
        presentPrizeView(coint: randomBonus)
        updateScore()
    }
    
     func presentPrizeView(coint: Int) {
        if fullScreenViewBonus == nil {
            fullScreenViewBonus = UIView(frame: self.view.bounds)
            fullScreenViewBonus!.backgroundColor = .cDarkBlue.withAlphaComponent(0.8)
            fullScreenViewBonus!.alpha = 0
            
            let imageView = UIImageView(image: .imgBonusCont)
            imageView.contentMode = .scaleAspectFit
            imageView.layer.shadowColor = UIColor.cYellow.cgColor
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowRadius = 44
            imageView.layer.shadowOffset = CGSize(width: 0, height: 0)

            fullScreenViewBonus!.addSubview(imageView)
            
            let titleLabel = UILabel()
            titleLabel.text = "Congratilations!"
            titleLabel.font = .customFont(font: .squadaOne, style: .regular, size: 36)
            titleLabel.textColor = .cYellow
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            imageView.addSubview(titleLabel)
            
            let subTitleLabel = UILabel()
            subTitleLabel.text = "You won".uppercased()
            subTitleLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
            subTitleLabel.textColor = .white
            subTitleLabel.numberOfLines = 0
            subTitleLabel.textAlignment = .center
            imageView.addSubview(subTitleLabel)
            
            let imageBonusView = UIImageView(image: .imgBonusBall)
            imageBonusView.contentMode = .scaleAspectFit
            imageView.addSubview(imageBonusView)
            
            let countLabel = UILabel()
            countLabel.text = "+\(coint)"
            countLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
            countLabel.textColor = .white
            countLabel.numberOfLines = 0
            countLabel.textAlignment = .center
            imageView.addSubview(countLabel)
            
            let thanksButton = UIButton()
            thanksButton.setImage(.btnThanks, for: .normal)
            thanksButton.setImage(.btnThanksTapped, for: .highlighted)
            thanksButton.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
            fullScreenViewBonus!.addSubview(thanksButton)
           
            
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageView.snp.top).offset(40)
            }
            
            subTitleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
            }
            
            imageBonusView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(subTitleLabel.snp.bottom).offset(-48)
            }
            
            countLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageBonusView.snp.bottom).offset(-48)
            }
            
            thanksButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(countLabel.snp.bottom).offset(20)
            }
           
            
            self.view.addSubview(fullScreenViewBonus!)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenViewBonus!.alpha = 1
        })
    }
    
    @objc func tappedCloseBuy() {
        ud.scoreBonuses += 1
        ud.lastBonusDate = Date()
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenViewBonus?.alpha = 0
        }) { _ in
            self.fullScreenViewBonus?.removeFromSuperview()
            self.fullScreenViewBonus = nil
            self.goDailyScreen()
        }
    }
}


extension BonusVC {
    
    func goDailyScreen() {
        if let lastVisitDate = UD.shared.lastBonusDate {
            let calendar = Calendar.current
            if let hours = calendar.dateComponents([.hour], from: lastVisitDate, to: Date()).hour, hours < 24 {
                isTime = true
                contentView.timeView.isHidden = false
                startCountdownTimer()
            } else {
                isTime = false
                contentView.timeView.isHidden = true
            }
        }
    }
    
    func startCountdownTimer() {
        let calendar = Calendar.current
        
        guard let lastVisitDate = UD.shared.lastBonusDate,
              let targetDate = calendar.date(byAdding: .day, value: 1, to: lastVisitDate) else {
            return
        }
        
        let now = Date()
        if now < targetDate {
            let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                let now = Date()
                if now >= targetDate {
                    UserDefaults.standard.set(now, forKey: "LastVisitDate")
                    self.dismiss(animated: true, completion: nil)
                    timer.invalidate()
                } else {
                    let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)
                    let timeString = String(format: "%02d:%02d:%02d", timeRemaining.hour ?? 0, timeRemaining.minute ?? 0, timeRemaining.second ?? 0)
                    self.contentView.timeCountLabel.text = "\(timeString)"
                }
            }
        } else {
            UserDefaults.standard.set(now, forKey: "LastVisitDate")
        }
    }
    
    func updateScore() {
        let payload = UpdatePayload(name: nil, balance: UD.shared.scoreCoints)
        PostService.shared.updateBalance(id: UD.shared.userID!, payload: payload) { result in
           DispatchQueue.main.async {
               switch result {
               case .success(_):
                   print("Success")
               case .failure(let failure):
                   print("Error - \(failure.localizedDescription)")
               }
           }
       }
   }
}
