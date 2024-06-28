import Foundation
import UIKit
import SnapKit

class AchiView: UIView {
    
    private(set) lazy var achiImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Profile", font: .customFont(font: .squadaOne, style: .regular, size: 24), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
 
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Achievements", font: .customFont(font: .inter, style: .light, size: 14), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    init(frame: CGRect, image: UIImage, title: String, subTitle: String) {
        super.init(frame: frame)
        achiImage.image = image
        titleLabel.text = title
        subTitleLabel.text = subTitle

        setupUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [achiImage, titleLabel, subTitleLabel].forEach(addSubview(_:))
    }
    
    private func setUpConstraints() {
        achiImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(achiImage.snp.right).offset(20)
            make.top.equalToSuperview().offset(8)
        }
       
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(achiImage.snp.right).offset(20)
        }
    }
}


