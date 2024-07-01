//
//  ProfileView.swift


import Foundation
import UIKit
import SnapKit

class ProfileView: UIView, UITextFieldDelegate {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgClassic
        return imageView
    }()
    
    private(set) lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBack, for: .normal)
        btn.setImage(.btnBackTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Profile", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel.createLabel(withText: "\(UD.shared.userName ?? "User Name")", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var profileTextField: UITextField = {
        let textField = UITextField()
        let font = UIFont.customFont(font: .squadaOne, style: .regular, size: 36)
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        
        let placeholderText = NSAttributedString(string: "User Name", attributes: placeholderAttributes)
        textField.attributedPlaceholder = placeholderText
        
        if let savedUserName = UD.shared.userID {
            textField.placeholder = "user#\(savedUserName)"
        }
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
        textField.font = UIFont.customFont(font: .squadaOne, style: .regular, size: 36)
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
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
    
    private(set) lazy var btnEditName: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnEditName, for: .normal)
        btn.setBackgroundImage(.btnEditNameTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var btnEditPhoto: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnEditPhoto, for: .normal)
        btn.setBackgroundImage(.btnEditPhotoTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var achiLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Achievements", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private(set) lazy var achiOne: AchiView = {
        let view = AchiView(frame: .zero, image: .imgAchiOne, title: "Beginner".uppercased(), subTitle: "Close the first number\non the playing field")
        return view
    }()
    
    private(set) lazy var achiTwo: AchiView = {
        let view = AchiView(frame: .zero, image: .imgAchiTwo, title: "Sharpshooter".uppercased(), subTitle: "Hit the ball into the center\nzone of the target")
        return view
    }()
    
    private(set) lazy var achiThree: AchiView = {
        let view = AchiView(frame: .zero, image: .imgAchiThree, title: "Collecting combo".uppercased(), subTitle: "Close 3 numbers in\na row without mistakes")
        return view
    }()
    
    private(set) lazy var achiFour: AchiView = {
        let view = AchiView(frame: .zero, image: .imgAchiFour, title: "Dedicated".uppercased(), subTitle: "Score 500 points\nin one game")
        return view
    }()
    
    private(set) lazy var achiFive: AchiView = {
        let view = AchiView(frame: .zero, image: .imgAchiFive, title: "Point Giant".uppercased(), subTitle: "Score 10,000 points\nin a single game career")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        displayFirstLaunchDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [backImage, backBtn, titleLabel, containerInfo, btnEditName, btnEditPhoto, achiLabel, scrollView] .forEach(addSubview(_:))
        containerInfo.addSubview(imgUser)
        containerInfo.addSubview(profileTextField)
        containerInfo.addSubview(sinceLabel)
        containerInfo.addSubview(dateLabel)
        containerInfo.addSubview(lineLeftView)
        containerInfo.addSubview(lineRightView)

        containerInfo.addSubview(bonusLabel)
        containerInfo.addSubview(bonusesLabel)

        containerInfo.addSubview(gamesPlayedLabel)
        containerInfo.addSubview(playedLabel)
        
        scrollView.addSubview(contentView)
        
        contentView.addArrangedSubview(achiOne)
//        contentView.addArrangedSubview(achiTwo)
        contentView.addArrangedSubview(achiThree)
        contentView.addArrangedSubview(achiFour)
        contentView.addArrangedSubview(achiFive)
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        containerInfo.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(259)
        }
        
        imgUser.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(80)
        }
        
        profileTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgUser)
            make.left.equalTo(imgUser.snp.right).offset(12)
            make.width.equalTo(200)
        }
        
        sinceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgUser.snp.bottom).offset(18)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(sinceLabel.snp.bottom).offset(8)
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
            make.right.equalTo(lineLeftView.snp.left).offset(-15)
            make.top.equalTo(imgUser.snp.bottom).offset(18)
        }
        
        playedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(gamesPlayedLabel)
            make.top.equalTo(gamesPlayedLabel.snp.bottom).offset(8)
        }
        
        bonusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineRightView.snp.right).offset(6)
            make.top.equalTo(imgUser.snp.bottom).offset(18)
        }
        
        bonusesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(bonusLabel)
            make.top.equalTo(bonusLabel.snp.bottom).offset(8)
        }
        
        btnEditName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-84)
            make.top.equalTo(bonusesLabel.snp.bottom).offset(26)
        }
        
        btnEditPhoto.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(84)
            make.top.equalTo(bonusesLabel.snp.bottom).offset(26)
        }
        
        achiLabel.snp.makeConstraints { (make) in
            make.top.equalTo(containerInfo.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(achiLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        achiOne.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
//        achiTwo.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview().inset(20)
//        }
        
        achiThree.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        achiFour.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        achiFive.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func saveName() {
        if let savedUserName = UD.shared.userName {
            profileTextField.text = savedUserName
        }
    }
    
    private func displayFirstLaunchDate() {
        if let firstLaunchDate = UD.shared.firstLaunchDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateLabel.text = dateFormatter.string(from: firstLaunchDate)
        }
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        UD.shared.userName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Клавиатура спрятана")
//        RatingService.shared.updateUser(userId: Memory.shared.userID ?? 0, name: Memory.shared.userName ?? "User# \(Memory.shared.userID ?? 0)")
        return true
    }
}


