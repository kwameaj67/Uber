//
//  HomeVC+Delegates.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.reuseableID) as! HomeHeaderView
        header.searchView.locationActivationView.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeFooterView.reuseableID) as! HomeFooterView
        view.mapView.addAnnotation(annotation)
        view.mapView.setRegion(region, animated:true)
        view.mapView.userTrackingMode = .follow
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentLocationCell.reusableID, for: indexPath) as!  RecentLocationCell
        cell.data = places[indexPath.row]
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        
        if indexPath.row == 2{
            cell.border.isHidden = true
            cell.border.alpha = 0
        }
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = Color.textField_bg
        cell.selectedBackgroundView = bgView
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 370.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300.0
    }
}

extension HomeVC: SearchLocationDelegate{
    func presentMapViewVC(){
        let vc = MapViewVC()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func presentLocationInputView() {
        print("DEBUG: Handling present location view...")
        presentMapViewVC()
    }
}
