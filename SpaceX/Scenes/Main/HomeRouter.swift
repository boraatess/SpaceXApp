//
//  HomeRouter.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import UIKit

class HomeRouter {
    let screen = UIScreen.main.bounds
    var view = HomeViewController()
    func prepareView() ->  UIViewController {
        view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // view.gameName = gameName
        view.hidesBottomBarWhenPushed = true
        let label = UILabel(frame: CGRect(x: screen.width+50, y: 0, width: screen.width, height: 44))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text =  "Ana Sayfa"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        self.view.navigationItem.titleView = label
        return view
    }
}
