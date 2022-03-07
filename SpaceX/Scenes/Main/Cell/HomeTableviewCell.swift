//
//  HomeTableviewCell.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class HomeTableviewCell: UITableViewCell {
    
    let screen = UIScreen.main.bounds
    
    private let viewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let launchName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func refreshCellWith(response: Launch) {
        launchName.text = response.missionName
        let url = URL(string: response.links.missionPatchSmall ?? "")
        imgView.kf.setImage(with: url)
        yearLabel.text = response.launchYear
    }
    
    func layout() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(screen.width)
            make.height.equalTo(screen.width/2)
        }
        viewContent.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        viewContent.addSubview(launchName)
        launchName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(self.imgView.snp.leading).offset(120)
        }
        viewContent.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
