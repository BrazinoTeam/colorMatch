//
//  LeadersVC.swift

import Foundation
import UIKit

class LeadersVC: UIViewController {
    
    
    private var leadersData: [Leader] = [
        Leader(name: "Ivan", score: 100),
        Leader(name: "John", score: 200),
        Leader(name: "Sarah", score: 300),
        Leader(name: "Sarah", score: 400),
        Leader(name: "Sarah", score: 500),
        Leader(name: "Sarah", score: 600),
        Leader(name: "Sarah", score: 700),
        Leader(name: "Sarah", score: 800),
        Leader(name: "Sarah", score: 900),
        Leader(name: "Sarah", score: 1000)
    ]
    
    private var contentView: LeadersView {
        view as? LeadersView ?? LeadersView()
    }
    
    override func loadView() {
        view = LeadersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        sortLeadersData()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func configureTableView() {
        contentView.leaderTableView.dataSource = self
        contentView.leaderTableView.delegate = self
        contentView.leaderTableView.register(LeadersCell.self, forCellReuseIdentifier: LeadersCell.reuseId)
        
    }
    
    private func sortLeadersData() {
          leadersData.sort { $0.score > $1.score }
      }
    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension LeadersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeadersCell.reuseId, for: indexPath)
        
        guard let leaderCell = cell as? LeadersCell else {
            return cell
        }
        
        let leader = leadersData[indexPath.row]
        leaderCell.configure(with: leader, index: indexPath.row + 1)
        
        if indexPath.row < 3 {
            leaderCell.setTopThreeAppearance()
        } else {
            leaderCell.setDefaultAppearance()
        }
        
        return leaderCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row < 3 ? 96 : 68
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

