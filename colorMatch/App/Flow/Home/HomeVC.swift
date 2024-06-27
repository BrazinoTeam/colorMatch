//
//  HomeVC.swift

import Foundation
import UIKit

final class HomeVC: UIViewController {

    
    private var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCoints()
    }
    
    private func updateCoints() {
        contentView.subTitleLabel.text = "\(UD.shared.scoreCoints)"
        contentView.bonusesLabel.text = "\(UD.shared.scoreBonuses)"
        contentView.playedLabel.text = "\(UD.shared.scorePlayed)"
    }
    
    private func tappedButtons() {
        contentView.playBtn.addTarget(self, action: #selector(goGame), for: .touchUpInside)
        contentView.leadBtn.addTarget(self, action: #selector(goLeaders), for: .touchUpInside)
        contentView.infoBtn.addTarget(self, action: #selector(goInfo), for: .touchUpInside)
        contentView.profileBtn.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        contentView.bonusBtn.addTarget(self, action: #selector(goBonus), for: .touchUpInside)

    }
    
    @objc func goGame() {
        let vc = GameVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goLeaders() {
        let vc = LeadersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goInfo() {
        let vc = InfoVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goProfile() {
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goBonus() {
        let vc = BonusVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

