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
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountOptionCell.reusableID, for: indexPath) as!  AccountOptionCell
        cell.data = options[indexPath.row]
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
    
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = Color.textField_bg
        cell.selectedBackgroundView = bgView
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70.0)
    }
    
}
