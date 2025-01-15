//
//  TripCell.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 1/31/23.
//

import UIKit
import Cosmos

class TripCell: UITableViewCell {
    
    var data: Trip? {
        didSet{
            manageData()
        }
    }
    
    static let reusableId = "TripCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TripCell.reusableId)
        setupViews()
        setupContraints()
        arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3/2) // transform image to the right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: Properties -
    lazy var dateLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
        
    lazy var priceLbl: UILabel = {
        let lb = UILabel()
        lb.textColor = Color.black
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var cancelledLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Canceled"
        lb.textColor = Color.text_grey
        lb.font = UIFont(name: Font.regular.rawValue, size: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var mapView: UberMapView = {
        let mp = UberMapView()
        mp.isZoomEnabled = false
        mp.isScrollEnabled = false
        mp.showsUserLocation = false
        mp.layer.cornerRadius = 0
        return mp
    }()
    
    lazy var arrowImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "uber-down")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var ratingsView: CosmosView = {
        let cv = CosmosView()
        cv.settings.updateOnTouch = false
        cv.settings.fillMode = .precise
        cv.settings.starMargin = 5
        cv.settings.starSize = 12
        cv.rating = 5.0
        cv.settings.filledImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.black)
        cv.settings.emptyImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.black)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupViews(){
        contentView.addConstrainedSubviews(dateLbl, priceLbl, arrowImage, mapView, ratingsView, cancelledLbl)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            dateLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLbl.trailingAnchor.constraint(equalTo: priceLbl.leadingAnchor, constant: -20),
            
            priceLbl.centerYAnchor.constraint(equalTo: dateLbl.centerYAnchor),
            priceLbl.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -8),
            
            arrowImage.centerYAnchor.constraint(equalTo: dateLbl.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            arrowImage.heightAnchor.constraint(equalToConstant: 6),
            arrowImage.widthAnchor.constraint(equalToConstant: 6),
            
            ratingsView.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: 8),
            ratingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            ratingsView.heightAnchor.constraint(equalToConstant: 15),
            
            cancelledLbl.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: 5),
            cancelledLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            cancelledLbl.heightAnchor.constraint(equalToConstant: 15),
            
            mapView.topAnchor.constraint(equalTo: ratingsView.bottomAnchor, constant: 15),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func manageData(){
        guard let item = data else { return }
        dateLbl.text = item.date
        priceLbl.text = "GH₵\(item.price.twoDecimalPlaces())"
        if item.status == .cancelled {
            ratingsView.hide()
            cancelledLbl.show()
        }
        else {
            ratingsView.show()
            cancelledLbl.hide()
        }
    }
}
