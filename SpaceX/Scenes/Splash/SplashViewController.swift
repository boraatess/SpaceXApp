//
//  SplashViewController.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import Lottie
import UIKit

class SplashViewController: UIViewController {
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
    }
    
    func setupAnimation() {
        view.backgroundColor = .black
        animationView.animation = Animation.named("spacex")
        animationView.frame = view.bounds
        animationView.backgroundColor = .black
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        fetchData()
    }
    
    func fetchData() {
        NetworkManager().getLaunchesList { response in
            if response.count > 0 {
                print("success")
                self.animationView.stop()
                self.startApp()
            }
            else {
                self.showAlert()
            }
        }
    }
    
    func startApp() {
        let vc = UINavigationController(rootViewController: HomeRouter().prepareView())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Lütfen internet bağlantınızı kontrol ediniz", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default) { action in
            
        }
        let cancel = UIAlertAction(title: "Kapat", style: .destructive) { action in
            
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}
