//
//  ActivityVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 22/12/2022.
//

import UIKit


extension ActivityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ActivityHeaderView.reuseableID) as! ActivityHeaderView
        view.locationLabel.text = currentTrip.location
        view.dateLabel.text = currentTrip.date
        view.priceLabel.text = currentTrip.status == .cancelled ? "GH₵ \(currentTrip.price.twoDecimalPlaces()) · Canceled" :  "GH₵ \(currentTrip.price.twoDecimalPlaces())"
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PastTripCell.reusableID, for: indexPath) as!  PastTripCell
        cell.data = trips[indexPath.row]
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(415.0)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PastTripCell
        cell.backgroundColor = Color.grey_bg2
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PastTripCell
        cell.backgroundColor = .white
    }
}
