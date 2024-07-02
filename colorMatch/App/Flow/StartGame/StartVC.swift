//
//  StartVC.swift


import Foundation
import UIKit

final class StartVC: UIViewController {

    private let auth = AuthService.shared
    private let post = PostService.shared
    private let ud = UD.shared

    private var contentView: StartView {
        view as? StartView ?? StartView()
    }
    
    override func loadView() {
        view = StartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.spinner.startAnimation(delay: 0.04, replicates: 18)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                  self.loadHomeVC()
            self.contentView.spinner.stopAnimation()
              }
    }

    func loadHomeVC() {
        if UD.shared.firstLaunchDate == nil {
            UD.shared.firstLaunchDate = Date()
             }
            Task {
                do {
                    try await auth.authenticate()
                    checkToken()
                    createUserIfNeededUses()
                    let vc = HomeVC()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    
    private func createUserIfNeededUses() {
        if ud.userID == nil {
            let uuid = UUID().uuidString
            Task {
                do {
                    let player = try await post.createPlayerUser(username: uuid)
                    ud.userID = player.id
                } catch {
                    print("Ошибка создания пользователя: \(error.localizedDescription)")
                }
            }
        }
    }

    private func checkToken() {
        guard let token = auth.token else {
            return
        }
    }
}

