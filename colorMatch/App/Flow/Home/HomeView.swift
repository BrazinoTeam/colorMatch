//
//  HomeView.swift

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        return imageView
    }()
    
    private lazy var containerInfo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .contInfo
        imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 12
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        return imageView
    }()

    private(set) lazy var imgUser: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgUserDef
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel.createLabel(withText: "\(UD.shared.userName ?? "User Name")", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private lazy var lineLeftView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .cPurple
        return view
    }()
    
    private lazy var lineRightView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .cPurple
        return view
    }()
    
    private lazy var sinceLabel: UILabel = {
        let label = UILabel.createLabel(withText: "In game since", font: .customFont(font: .inter, style: .light, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .customFont(font: .squadaOne, style: .regular, size: 24)
        return label
    }()
    
    private lazy var gamesPlayedLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Games played", font: .customFont(font: .inter, style: .light, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        return label
    }()
    
    private(set) lazy var playedLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UD.shared.scorePlayed)"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .customFont(font: .squadaOne, style: .regular, size: 24)
        return label
    }()
    
    private lazy var bonusLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Bonuses received", font: .customFont(font: .inter, style: .light, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        return label
    }()
    
    
    private(set) lazy var bonusesLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UD.shared.scoreBonuses)"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .customFont(font: .squadaOne, style: .regular, size: 24)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "TOTAL POINTS", font: .customFont(font: .inter, style: .light, size: 14), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let formattedScore = formatNumber(UD.shared.scoreCoints) ?? "\(UD.shared.scoreCoints)"
        let label = UILabel.createLabel(withText: formattedScore, font: .customFont(font: .squadaOne, style: .regular, size: 60), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 0.76)
        return label
    }()
    
    private(set) lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnPlay, for: .normal)
        btn.setImage(.btnPlayTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var leadBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnLeadTapped, for: .normal)
        btn.setImage(.btnLeadTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var imgBallLead: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBtnBall
        return imageView
    }()
    
    private(set) lazy var infoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnInfoTapped, for: .normal)
        btn.setImage(.btnInfoTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var imgBallInfo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBtnBall
        return imageView
    }()
    
    private(set) lazy var profileBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnProfileTapped, for: .normal)
        btn.setImage(.btnProfileTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var imgBallProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBtnBall
        return imageView
    }()
    
    private(set) lazy var bonusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBonusTapped, for: .normal)
        btn.setImage(.btnBonusTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var imgBallBonus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBtnBall
        return imageView
    }()
    
    private(set) lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnSettingsTapped, for: .normal)
        btn.setImage(.btnSettingsTapped, for: .highlighted)
        return btn
    }()

    private(set) lazy var imgBallSettings: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBtnBall
        return imageView
    }()

    private lazy var buttonStack: UIStackView = {
         let stackView = UIStackView(arrangedSubviews: [leadBtn, infoBtn, profileBtn, bonusBtn, settingBtn])
         stackView.axis = .horizontal
         stackView.alignment = .fill
         stackView.distribution = .equalSpacing
         stackView.spacing = 0
         return stackView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        displayFirstLaunchDate()
        setupUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func formatNumber(_ number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
    func getImgBallLead() -> UIImageView {
           return imgBallLead
       }
    
    private func setupUI() {
        [backImage, subTitleLabel, containerInfo, titleLabel, playBtn, buttonStack] .forEach(addSubview(_:))
        containerInfo.addSubview(imgUser)
        containerInfo.addSubview(nameLabel)
        containerInfo.addSubview(sinceLabel)
        containerInfo.addSubview(dateLabel)
        containerInfo.addSubview(lineLeftView)
        containerInfo.addSubview(lineRightView)

        containerInfo.addSubview(bonusLabel)
        containerInfo.addSubview(bonusesLabel)

        containerInfo.addSubview(gamesPlayedLabel)
        containerInfo.addSubview(playedLabel)

        leadBtn.addSubview(imgBallLead)
        infoBtn.addSubview(imgBallInfo)
        profileBtn.addSubview(imgBallProfile)
        bonusBtn.addSubview(imgBallBonus)
        settingBtn.addSubview(imgBallSettings)


    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerInfo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64.autoSize)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(183.autoSize)
        }
        
        imgUser.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(80.autoSize)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgUser)
            make.left.equalTo(imgUser.snp.right).offset(12.autoSize)
        }
        
        sinceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgUser.snp.bottom).offset(18.autoSize)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sinceLabel.snp.bottom).offset(8.autoSize)
        }
        
        lineLeftView.snp.makeConstraints { (make) in
            make.right.equalTo(sinceLabel.snp.left).offset(-20)
            make.top.equalTo(imgUser.snp.bottom).offset(18)
            make.height.equalTo(40)
            make.width.equalTo(1)
        }
        
        lineRightView.snp.makeConstraints { (make) in
            make.left.equalTo(sinceLabel.snp.right).offset(20)
            make.top.equalTo(imgUser.snp.bottom).offset(18)
            make.height.equalTo(40)
            make.width.equalTo(1)
        }
        
        gamesPlayedLabel.snp.makeConstraints { (make) in
            make.right.equalTo(lineLeftView.snp.left).offset(-15.autoSize)
            make.top.equalTo(imgUser.snp.bottom).offset(18.autoSize)
        }
        
        playedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(gamesPlayedLabel)
            make.top.equalTo(gamesPlayedLabel.snp.bottom).offset(8.autoSize)
        }
        
        bonusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineRightView.snp.right).offset(6.autoSize)
            make.top.equalTo(imgUser.snp.bottom).offset(18.autoSize)
        }
        
        bonusesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bonusLabel)
            make.top.equalTo(bonusLabel.snp.bottom).offset(8.autoSize)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerInfo.snp.bottom).offset(40.autoSize)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
            make.size.equalTo(388.autoSize)
        }
        
        buttonStack.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
            make.height.equalTo(190)
        }
        
        leadBtn.snp.makeConstraints { (make) in
            make.width.equalTo(68)
        }
        
        infoBtn.snp.makeConstraints { (make) in
            make.width.equalTo(68)
        }
        
        profileBtn.snp.makeConstraints { (make) in
            make.width.equalTo(68)
        }
        
        bonusBtn.snp.makeConstraints { (make) in
            make.width.equalTo(68)
        }
        
        settingBtn.snp.makeConstraints { (make) in
            make.width.equalTo(68)
        }
        
        imgBallLead.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        
        imgBallInfo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        
        imgBallProfile.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        
        imgBallBonus.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        
        imgBallSettings.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
    }
    
    private func displayFirstLaunchDate() {
        if let firstLaunchDate = UD.shared.firstLaunchDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            dateLabel.text = dateFormatter.string(from: firstLaunchDate)
        }
    }
}

