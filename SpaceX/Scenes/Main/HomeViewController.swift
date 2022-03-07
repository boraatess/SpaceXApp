//
//  HomeViewController.swift
//  SpaceX
//
//  Created by bora ateş on 3.03.2022.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HomeTableviewCell.self, forCellReuseIdentifier: "homeCell")
        tableview.isHidden = true
        tableview.separatorStyle = .none
        tableview.layer.cornerRadius = 12
        return tableview
    }()
    
    var launchList: [Launch]?
    var yearList: [String] = []
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        self.layout()
        getData()
        generateYearList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableview.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableview.reloadData()
    }
    
    func getData() {
        NetworkManager().getLaunchesList { [weak self] (response) in
            self?.launchList = response
            self?.tableview.isHidden = false
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
    }

    func generateYearList() {
        let x = 2006
        for i in 0..<17 {
            let new = x + i
            yearList.append("\(new)")
        }
    }
    
    @objc func didTapToFilter() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}

extension HomeViewController {
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtre", style: .plain, target: self, action: #selector(didTapToFilter))
    }
    
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableviewCell
        cell.selectionStyle = .none
        guard let response = launchList?[indexPath.row] else { return UITableViewCell() }
        cell.refreshCellWith(response: response)

        let filtered = userDefaults.string(forKey: "filtered")
        if filtered != "" {
            if filtered == response.launchYear {
                cell.yearLabel.text = response.launchYear
                cell.launchName.text = response.missionName
            }
            else {
                cell.refreshCellWith(response: response)

            }
        }
        else {
            cell.refreshCellWith(response: response)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let result = launchList?[indexPath.row] else { return }
        let vc = DetailRouter().prepareView(response: result)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onDoneButtonTapped()
        let filtered = yearList[row]
        print(filtered)
        userDefaults.set(filtered, forKey: "filtered")
        NetworkManager().getLaunchesListWithYear(year: filtered) { response in
            print(response)
            self.launchList = response
            DispatchQueue.main.async {
                self.tableview.reloadData()
                // self.picker.reloadAllComponents()
            }
        }
    }
    
}
