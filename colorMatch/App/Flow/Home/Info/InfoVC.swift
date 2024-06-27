//
//  InfoVC.swift

import Foundation
import UIKit

final class InfoVC: UIViewController {

    
    private var contentView: InfoView {
        view as? InfoView ?? InfoView()
    }
    
    override func loadView() {
        view = InfoView()
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

