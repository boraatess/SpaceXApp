//
//  DetailViewController.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
    var response : Launch?
    let screen = UIScreen.main.bounds
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(DetailTableviewCell.self, forCellReuseIdentifier: "detailCell")
        tableview.isHidden = true
        tableview.separatorStyle = .none
        tableview.layer.cornerRadius = 12
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout()
        self.tableview.isHidden = false
    }
    
}

extension DetailViewController {
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableviewCell
        cell.selectionStyle = .none
        guard let result = self.response else { return UITableViewCell() }
        cell.refreshWith(response: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screen.height
    }
    
}
