import Foundation
import UIKit

class LeadersVC: UIViewController {

    var users = [User]()

    let getService = GetService.shared

    private var contentView: LeadersView {
        view as? LeadersView ?? LeadersView()
    }
    
    override func loadView() {
        view = LeadersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tappedButtons()
        loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func configureTableView() {
        contentView.leaderTableView.dataSource = self
        contentView.leaderTableView.delegate = self
        contentView.leaderTableView.register(LeadersCell.self, forCellReuseIdentifier: LeadersCell.reuseId)
        
    }
    
    func sorterScoreUsers() {
        users.sort {
            $1.balance ?? 0 < $0.balance ?? 0
        }
    }
    
    func loadUsers() {
        getService.fetchData { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.sorterScoreUsers()
            self.contentView.leaderTableView.reloadData()
            }
    errorCompletion: { [weak self] error in
            guard self != nil else { return }
            }
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeadersCell.reuseId, for: indexPath)
        
        guard let leaderCell = cell as? LeadersCell else {
            return cell
        }
        
        let leader = users[indexPath.row]
        
        if indexPath.row < 3 {
            leaderCell.setTopThreeAppearance()
        } else {
            leaderCell.setDefaultAppearance()
        }
        
        setupCell(leadCell: leaderCell, number: indexPath.row + 1, user: leader)
        
        return leaderCell
    }
    
    func formatNumber(_ number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
    func setupCell(leadCell: LeadersCell, number: Int, user: User) {
        leadCell.numberLabel.text = "\(number)"
        let formattedBalance = formatNumber(user.balance ?? 0)
        leadCell.scoreLabel.text = formattedBalance ?? "\(user.balance ?? 0)"
        leadCell.nameLabel.text = user.name == nil ? "USER #\(user.id ?? 0)" : user.name
        
        if leadCell.backImg.image == .imgContLeadOther {
            if user.id == UD.shared.userID {
                leadCell.backImg.image = .imgContYouLead
            } else {
                leadCell.backImg.image = .imgContLeadOther
            }
        }
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
