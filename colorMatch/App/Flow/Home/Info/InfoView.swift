//
//  InfoView.swift


import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
    private lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLoading
        return imageView
    }()
    
    private(set) lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(.btnBack, for: .normal)
        btn.setImage(.btnBackTapped, for: .highlighted)
        return btn
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Info", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1)
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Welcome to\nColor Match!", font: .customFont(font: .squadaOne, style: .regular, size: 60), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var subtextLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Dive into the exciting world of numbers and colors,\nwhere your goal is to clear obstacles from the path of\nthe balls and score as many points as possible.", font: .customFont(font: .inter, style: .light, size: 14), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var howPlayLabel: UILabel = {
        let label = UILabel.createLabel(withText: "How to Play:", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bodyFieldInfo: UILabel = {
        let label = UILabel()
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineBreakMode = .byWordWrapping
        textStyle.lineHeightMultiple = 0.99
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: . inter, style: .light, size: 14),
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle
        ]
        
        let attributedText = NSMutableAttributedString(string: "1. BINGO Field:\n  \u{2022}At the top of the screen, you will see the BINGO field where balls with specific colors and numbers appear randomly.\n\n2. Game Balls:\n  \u{2022}Below the BINGO field are the balls that need to pass through the playing field and fall into the hole at the bottom.\n\n3. Playing Field:\n  \u{2022}Below the balls is the playing field filled with squares containing different numbers and colors. Your task is to clear these obstacles so the balls can freely fall down.\n\n4. Clearing Obstacles:\n \u{2022}Compare the numbers and colors of the balls in the BINGO field with the numbers and colors on the playing field.\n \u{2022}If they match, click on the corresponding square on the playing field to make it disappear.\n\n5. Ball Drop:\n  \u{2022}Once all obstacles in the path of a ball are cleared, the ball falls down through the playing field and reaches the hole at the bottom.\n\n6. Scoring Points:\n  \u{2022}You earn points for each cleared square and for each ball that reaches the hole. Keep track of your total score at the top of the screen.",
                                                       attributes: attributes)
        
        let titleFont = UIFont.customFont(font: .squadaOne, style: .regular, size: 24)
        let titleRanges = [
            "1. BINGO Field:",
            "2. Game Balls:",
            "3. Playing Field:",
            "4. Clearing Obstacles:",
            "5. Ball Drop:",
            "6. Scoring Points:"
        ].compactMap { title -> NSRange? in
            let range = (attributedText.string as NSString).range(of: title)
            return range.location != NSNotFound ? range : nil
        }
        
        for range in titleRanges {
            attributedText.addAttribute(.font, value: titleFont, range: range)
        }
        
        label.attributedText = attributedText
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var achiLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Achievements:", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private(set) lazy var achiSubLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Complete various achievements such as removing a certain number of obstacles, successfully dropping balls, and other tasks to earn additional points and increase your status in the game.", font: .customFont(font: .inter, style: .light, size: 14), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 0.99)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private(set) lazy var lastLabel: UILabel = {
        let label = UILabel.createLabel(withText: "Play Color Match and become a master of numbers and colors!", font: .customFont(font: .squadaOne, style: .regular, size: 36), textColor: .cYellow, paragraphSpacing: 1, lineHeightMultiple: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addArrangedSubview(subTitleLabel)
        contentView.addArrangedSubview(subtextLabel)
        contentView.addArrangedSubview(howPlayLabel)
        contentView.addArrangedSubview(bodyFieldInfo)
        contentView.addArrangedSubview(achiLabel)
        contentView.addArrangedSubview(achiSubLabel)
        contentView.addArrangedSubview(lastLabel)
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
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(325)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        subtextLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        howPlayLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        bodyFieldInfo.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        achiLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        achiSubLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
        
        lastLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

