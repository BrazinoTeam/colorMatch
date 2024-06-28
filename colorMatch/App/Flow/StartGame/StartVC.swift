//
//  StartVC.swift


import Foundation
import UIKit

final class StartVC: UIViewController {

    
    private var contentView: StartView {
        view as? StartView ?? StartView()
    }
    
    override func loadView() {
        view = StartView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.spinner.startAnimation(delay: 0.04, replicates: 18)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  self.loadHomeVC()
            self.contentView.spinner.stopAnimation()
              }
    }

   private func loadHomeVC() {
                    let vc = HomeVC()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
            }
        }
    
//    private func createUserIfNeeded() {
//        if ud.userID == nil {
//            let payload = CreateRequestPayload(name: nil, score: ud.scorePoints)
//            post.createPlayer(payload: payload) { [weak self] createResponse in
//                guard let self = self else { return }
//                ud.userID = createResponse.id
//            } errorCompletion: { error in
//                print("Ошибка получени данных с бека")
//            }
//        }
//    }
//    
//    private func checkToken() {
//        guard let token = auth.token else {
//            return
//        }
//    }
    
   

