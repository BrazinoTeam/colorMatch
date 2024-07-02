//
//  LeadersCell.swift

// LeadersCell.swift

import Foundation
import UIKit
import SnapKit


class LeadersCell: UITableViewCell {
    
    static let reuseId = String(describing: LeadersCell.self)

    private(set) lazy var backImg: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgContLeadOther
        return iv
    }()
    
    private(set) lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgUserDef
        return iv
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .inter, style: .regular, size: 18)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var pointImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgBallWin
        return iv
    }()
    
    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .squadaOne, style: .regular, size: 24)
        label.textColor = .cYellow
        return label
    }()
    
    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(font: .squadaOne, style: .regular, size: 24)
        label.textColor = .cYellow
        return label
    }()
    
    private(set) lazy var leadView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        scoreLabel.text = nil
        numberLabel.text = nil
    }
    
   
    
    func setTopThreeAppearance() {
        backImg.image = .imgContLeadTopThree
        nameLabel.font = .customFont(font: .squadaOne, style: .regular, size: 24)
        scoreLabel.font = .customFont(font: .squadaOne, style: .regular, size: 36)
        numberLabel.font = .customFont(font: .squadaOne, style: .regular, size: 60)
        nameLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(19)
         }
        userImage.snp.updateConstraints { (make) in
             make.size.equalTo(80)
         }
     }
     
     func setDefaultAppearance() {
         backImg.image = .imgContLeadOther
         userImage.snp.updateConstraints { (make) in
             make.size.equalTo(60)
         }
    
     }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(leadView)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        [backImg, nameLabel, scoreLabel, numberLabel, userImage, pointImage].forEach(leadView.addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        leadView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(68.autoSize)
            make.width.equalTo(345.autoSize)
        }

        backImg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        userImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.size.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(userImage.snp.right).offset(8)
        }
        
        pointImage.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(userImage.snp.right).offset(8)
            make.size.equalTo(28)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(pointImage)
            make.left.equalTo(pointImage.snp.right).offset(4)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-28)
        }
    }
}
