//
//  DetailTableviewCell.swift
//  SpaceX
//
//  Created by bora ateş on 7.03.2022.
//

import Kingfisher
import UIKit
import SnapKit

class DetailTableviewCell: UITableViewCell {
    
    private let imageViewCover: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let reasonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Watch on YouTube", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    var launches: Launch?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func refreshWith(response: Launch) {
        self.launches = response
        let url = URL(string: response.links.missionPatch ?? "")
        imageViewCover.kf.setImage(with: url)
        labelTitle.text = response.missionName
        let launchDate = response.launchDateLocal
        yearLabel.text = "Launch Date: " + launchDate
        let reason = response.launchFailureDetails?.reason ?? "NO DATA"
        let details = response.details ?? "NO DATA"
        reasonLabel.text = "Reason: " + reason
        detailsLabel.text = "Details: " + details
    }
    
    func layout() {
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(16)
            maker.trailing.equalToSuperview().inset(16)
            maker.top.equalToSuperview().offset(20)
        }
        contentView.addSubview(imageViewCover)
        imageViewCover.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(self.labelTitle.snp.bottom).offset(20)
            maker.height.equalTo(UIScreen.main.bounds.width)
        }
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageViewCover.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        contentView.addSubview(reasonLabel)
        reasonLabel.snp.makeConstraints { make in
            make.top.equalTo(self.yearLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        contentView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(self.reasonLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        contentView.addSubview(videoButton)
        videoButton.snp.makeConstraints { make in
            make.top.equalTo(self.detailsLabel.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        videoButton.addTarget(self, action: #selector(videoButtonClick), for: .touchUpInside)
    }
    
    @objc func videoButtonClick() {
        if let url = URL(string: launches?.links.videoLink ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
