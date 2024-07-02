//
//  BonusView.swift


import Foundation
import UIKit
import SnapKit

class BonusView: UIView {
    
    private lazy var bonusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgGame
        return imageView
    }()
    
    private(set) lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBack, for: .normal)
        btn.setImage(.btnBackTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Daily Bonus", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private lazy var imgCenter: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgBonusMachine
        return imageView
    }()
    
    private(set) lazy var goBonus: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnGetBonus, for: .normal)
        btn.setImage(.btnGetBonusTapped, for: .highlighted)
        btn.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        return btn
    }()
    
    private(set) lazy var timeView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var timeBackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgBonus
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var timeBackBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBack, for: .normal)
        btn.setImage(.btnBackTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var timeTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Daily Bonus", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var timeSubTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "The next bonus will be\navailable through:", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var timeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cYellow
        label.font = .customFont(font: .squadaOne, style: .regular, size: 80)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bonusView)
        addSubview(timeView)

        bonusView.addSubview(backImage)
        bonusView.addSubview(backBtn)
        bonusView.addSubview(titleLabel)
        bonusView.addSubview(imgCenter)
        bonusView.addSubview(goBonus)
        
        timeView.addSubview(timeBackImage)
        timeView.addSubview(timeBackBtn)
        timeView.addSubview(timeTitleLabel)
        timeView.addSubview(timeSubTitleLabel)
        timeView.addSubview(timeCountLabel)


    }
    
    private func setUpConstraints(){
        
        bonusView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
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
        
        imgCenter.snp.makeConstraints { (make) in
            make.top.equalTo(backBtn.snp.bottom).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(407.autoSize)
            make.height.equalTo(716.autoSize)
        }
        
        goBonus.snp.makeConstraints { (make) in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            make.centerX.equalToSuperview()
        }
        
        timeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeBackImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeBackBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
        }
        
        timeTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        timeSubTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeTitleLabel.snp.bottom).offset(45.autoSize)
            make.centerX.equalToSuperview()
        }
        
        timeCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeSubTitleLabel.snp.bottom).offset(20.autoSize)
            make.centerX.equalToSuperview()
        }
    }
}

