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
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero

        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        cell.selectedBackgroundView = bgView
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(455.0)
    }
}
