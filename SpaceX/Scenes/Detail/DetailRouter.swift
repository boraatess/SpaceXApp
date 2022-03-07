//
//  DetailRouter.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import UIKit

class DetailRouter {
    let screen = UIScreen.main.bounds
    var view = DetailViewController()
    func prepareView(response: Launch) ->  UIViewController {
        view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Geri", style: .plain, target: nil, action: nil)
        // view.gameName = gameName
        view.response = response
        view.hidesBottomBarWhenPushed = true
        view.navigationController?.navigationBar.backgroundColor = .systemGray
        let label = UILabel(frame: CGRect(x: screen.width-20, y: 0, width: screen.width, height: 44))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text =  "Detay Sayfası"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        self.view.navigationItem.titleView = label
        return view
    }
}
