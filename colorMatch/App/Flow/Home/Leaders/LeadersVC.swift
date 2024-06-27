//
//  LeadersVC.swift

import Foundation
import UIKit

final class LeadersVC: UIViewController {

    
    private var contentView: LeadersView {
        view as? LeadersView ?? LeadersView()
    }
    
    override func loadView() {
        view = LeadersView()
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

