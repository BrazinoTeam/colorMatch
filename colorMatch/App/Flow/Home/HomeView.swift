//
//  HomeView.swift

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        return imageView
    }()
    
    
    private(set) lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.bgInfo, for: .normal)
        return btn
    }()
    
    private(set) lazy var leadBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("L", for: .normal)
        return btn
    }()
    
    private(set) lazy var infoBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("I", for: .normal)
        return btn
    }()
    
    private(set) lazy var profileBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("P", for: .normal)
        return btn
    }()
    
    private(set) lazy var bonusBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .yellow
        btn.setTitle("B", for: .normal)
        return btn
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
        [backImage, playBtn, leadBtn, infoBtn, profileBtn, bonusBtn] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            }
        
        playBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(220)
            }
        
        leadBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(180)
            make.width.equalTo(68)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            }
        
        infoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(leadBtn.snp.right)
            make.height.equalTo(180)
            make.width.equalTo(68)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            }
        
        profileBtn.snp.makeConstraints { (make) in
            make.left.equalTo(infoBtn.snp.right)
            make.height.equalTo(180)
            make.width.equalTo(68)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            }
        
        bonusBtn.snp.makeConstraints { (make) in
            make.left.equalTo(profileBtn.snp.right)
            make.height.equalTo(180)
            make.width.equalTo(68)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            }
        }
    }

