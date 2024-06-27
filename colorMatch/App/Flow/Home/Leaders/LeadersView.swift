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
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backImage)
        addSubview(backBtn)
       
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
        }
        
    }
}

