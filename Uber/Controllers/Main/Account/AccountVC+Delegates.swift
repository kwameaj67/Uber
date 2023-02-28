//
//  AccountVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit


extension AccountVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountActionHeader.reuseableID) as! AccountActionHeader
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.reusableID, for: indexPath) as!  AccountOptionCell
        cell.selectionStyle = .none
        cell.data = options[indexPath.row]
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = options[indexPath.row]
        if item.iconType == .settings {
            let vc = SettingsVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(128.0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(62.0)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AccountOptionCell
        cell.backgroundColor = Color.grey_bg2
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AccountOptionCell
        cell.backgroundColor = .white
    }
    
}

// MARK: AccountActionHeaderDelegate -
extension AccountVC: AccountActionHeaderDelegate {
    func didTapTripCell() {
        let vc = TripsVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
