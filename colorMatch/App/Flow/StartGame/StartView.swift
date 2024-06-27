//
//  StartView.swift

import Foundation
import UIKit
import SnapKit

class StartView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLoading
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Loading...", font: .customFont(font: .inter, style: .regular, size: 18), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.83)
        return label
    }()
    
    private(set) lazy var spinner: CustomSpinnerSimple = {
            let spinner = CustomSpinnerSimple(squareLength: 93)
            spinner.spinnerColor = .gray
            return spinner
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
        [backImage, titleLabel, spinner] .forEach(addSubview(_:))
    }
    
    private func setUpConstraints(){
        
        backImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-184)
            }
        
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.size.equalTo(93)
            }
        }
    }

