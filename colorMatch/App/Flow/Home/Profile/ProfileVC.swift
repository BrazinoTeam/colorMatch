//
//  ProfileVC.swift

import Foundation
import UIKit

final class ProfileVC: UIViewController {

    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
  

    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)

    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

