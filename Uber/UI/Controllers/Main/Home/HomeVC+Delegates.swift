//
//  HomeVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit

// MARK: UITableViewDelegate, UITableViewDataSource - 
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.reuseableID) as! HomeHeaderView
        header.searchView.locationActivationView.delegate = self
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeFooterView.reuseableID) as! HomeFooterView
        view.delegate = self
        view.mapView.addAnnotation(annotation)
        view.mapView.setRegion(region, animated:true)
        region.span = spanDelta
        view.mapView.userTrackingMode = .follow
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentLocationCell.reusableID, for: indexPath) as!  RecentLocationCell
        cell.data = places[indexPath.row]
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        
        if indexPath.row == 2{
            cell.border.isHidden = true
            cell.border.alpha = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = places[indexPath.row]
        navigateToMapVC(locationQuery: item.location, showDestinationView: false)
    }
    
    // header & footer height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 440.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 250.0
    }
    
    // highlights
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecentLocationCell
        cell.backgroundColor = Color.grey_bg2
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecentLocationCell
        cell.backgroundColor = .white
    }
}

// MARK: SearchLocationDelegate -
extension HomeVC: SearchLocationDelegate {
    func presentMapVC(showDestinationView: Bool){
        navigateToMapVC(locationQuery: nil, showDestinationView: showDestinationView)
    }
    
    func didTapLocationActivationView() {
        print("DEBUG: Handling present map view...")
        playHaptic(style: .medium)
        presentMapVC(showDestinationView: true)
    }
}

// MARK: HomeHeaderViewDelegate -
extension HomeVC: HomeHeaderViewDelegate {
    func didTapFeatureOption(featureType: UberFeatureType) {
        if featureType == .ride {
            navigateToMapVC(locationQuery: nil, showDestinationView: true)
        }
    }
}

// MARK: HomeFooterViewDelegate -
extension HomeVC: HomeFooterViewDelegate {
    func didTapMapView() {
        playHaptic(style: .medium)
        presentMapVC(showDestinationView: false)
    }
}
