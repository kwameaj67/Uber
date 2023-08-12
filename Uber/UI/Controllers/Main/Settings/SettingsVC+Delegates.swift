//
//  SettingsVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 8/11/23.
//

import Foundation
import UIKit

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
        let alert = UIAlertController()
        presentAlertDialog(title: "Logout", message: "Are you really sure you want to logout of your account?") { results in
            switch results {
            case .yes:
                self.logOut()
            case .no:
                alert.dismiss(animated: true)
            }
        }
    }
    
    func logOut(){
        userDefaultManager.removeUserInfo()
        authManager.logOutUser { [weak self] results in
            guard let self = self else { return }
            switch results{
            case .success():
                let onboardingVC = UINavigationController(rootViewController: OnboardVC())
                self.smoothControllerTransition(for: onboardingVC)
            case .failure(let error):
                self.presentAlertError(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
