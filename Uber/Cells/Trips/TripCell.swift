//
//  TripCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 1/31/23.
//

import UIKit

class TripCell: UITableViewCell {

   static let reusableId = "TripCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TripCell.reusableId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.light.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.light.rawValue, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    func setupViews(){
        
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
        
        ])
    }
}
