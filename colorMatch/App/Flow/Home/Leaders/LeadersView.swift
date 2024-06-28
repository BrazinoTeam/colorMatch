//
//  LeadersView.swift

import Foundation
import UIKit
import SnapKit

class LeadersView: UIView {
    
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
        let label = UILabel.createLabel(withText: "Leaders", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var leaderTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.register(LeadersCell.self, forCellReuseIdentifier: LeadersCell.reuseId)
        tableView.separatorStyle = .none
        return tableView
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
        [backImage, backBtn, titleLabel, leaderTableView] .forEach(addSubview(_:))

       
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
        
        leaderTableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

