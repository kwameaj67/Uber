//
//  SettingsVC.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/28/23.
//

import UIKit

class SettingsVC: UIViewController {

    private let authManager = FirebaseAuthManager.shared
    private let userDefaultManager = UserDefaultsManager.shared
    lazy var sections = Section.sectionArray
    lazy var username: String = ""
    lazy var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        view.backgroundColor = .white
        username = userDefaultManager.getUserFullname()
        email = userDefaultManager.getUserEmail()
    }
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: Properties
    lazy var cancelButton: UberButton = {
        let cb = UberButton()
        let image = UIImage(named: "uber-exit")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(weight: .heavy))
        cb.setBackgroundImage(image, for: .normal)
        cb.backgroundColor = .none
        cb.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var smallTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Settings"
        lb.textColor = .black
        lb.alpha = 0
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var headerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var settingTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseableID)
        tv.register(SettingFooterView.self, forHeaderFooterViewReuseIdentifier: SettingFooterView.reuseableID)
        tv.register(SettingHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingHeaderView.reuseableID)
        tv.register(OptionHeaderView.self, forHeaderFooterViewReuseIdentifier: OptionHeaderView.reuseableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 50
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    // MARK: Selectors -
    @objc func didTapCancel(){
        dismiss(animated: true)
        self.removeFromParent()
        playHaptic(style: .medium)
    }
    
    func setupViews(){
        view.addSubview(headerView)
        headerView.addSubview(cancelButton)
        headerView.addSubview(smallTitleLbl)
        view.addSubview(settingTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 32),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 16),
            cancelButton.widthAnchor.constraint(equalToConstant: 16),
            
            smallTitleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            smallTitleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            settingTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            settingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource-
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].sectionItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingHeaderView.reuseableID) as! SettingHeaderView
            view.contentView.backgroundColor = .white
            view.nameLbl.text = username
            view.emailLbl.text = email
            return view
        }
        else if (section == 1 || section == 2) {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionHeaderView.reuseableID) as! OptionHeaderView
            view.titleLbl.text = sections[section].sectionName
            view.contentView.backgroundColor = .white
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(165)
        }
        else if (section == 1 || section == 2 || section == 3) {
            return CGFloat(45)
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseableID, for: indexPath) as! SettingCell
        let item = sections[indexPath.section].sectionItems[indexPath.row]
        cell.data = item
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
            case 0, 1:
                return nil
            case 2:
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingFooterView.reuseableID) as! SettingFooterView
                let bg_view = UIView(frame: footerView.bounds)
                bg_view.backgroundColor = .white
                footerView.backgroundView = bg_view
                footerView.delegate = self
                return footerView
            default:
                return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 1{
            return CGFloat()
        }
        if section == 1 || section == 2{
            return CGFloat(70)
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.backgroundColor = Color.grey_bg2
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        cell.backgroundColor = .white
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let v = y/210
        let value = Double(round(100*v)/100)
        if value > 0.15 {
            UIView.animate(withDuration: 0.2) {
                self.smallTitleLbl.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.smallTitleLbl.alpha = 0
            }
        }
    }
}


extension SettingsVC: DidTapSignOutDelegate{
    func didTapSignOut() {
        playHaptic(style: .medium)
        userDefaultManager.removeUserInfo()
        authManager.logOutUser { [weak self] results in
            guard let self = self else { return }
            switch results{
            case .success():
                let onboardingVC = UINavigationController(rootViewController: OnboardVC())
                self.smoothControllerTransition(for: onboardingVC)
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
            }
        }
    }
}
