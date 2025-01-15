//
//  OverlayRideActionView.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 2/1/23.
//

import UIKit
import MapKit

class OverlayRideActionView: UIView {
    var rides:[Ride] = Ride.data
    
    var destination: MKPlacemark? {
        didSet{
            // we could show the destination label 
            //addresLbl.attributedText = setupAttributedText(destination?.name ?? "No location", destination?.title ?? "No address")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
        
        let lbl = rides[0].name
        confirmBtn.setTitle("Choose \(lbl)", for: .normal)
        
        ridesTableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var border: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey_bg
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Choose a ride"
        lbl.textColor = .black
        lbl.font = UIFont(name: Font.medium.rawValue, size: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var confirmBtn: UberButton = {
        let btn = UberButton()
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 16)
        btn.backgroundColor = .black
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var reserveBtn: UberButton = {
        let btn = UberButton()
        let image = UIImage(named: "uber-calender")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        let resizedImage = image?.resize(to: CGSize(width: 16, height: 16))
        btn.setImage(resizedImage, for: .normal)
        btn.backgroundColor = Color.grey_bg
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var ridesTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(RideCell.self, forCellReuseIdentifier: RideCell.reusableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
        tv.rowHeight = 94.0
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 10
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    
    func setupViews(){
        addConstrainedSubviews(headingLbl, border, ridesTableView, stackView)
        stackView.addArrangedSubview(confirmBtn)
        stackView.addArrangedSubview(reserveBtn)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            headingLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            border.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 12),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 2),
            
            ridesTableView.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 8),
            ridesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ridesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ridesTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 52),
            
            confirmBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.74),
        ])
    }
    
    func setupAttributedText (_ name: String,_ location: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: name, attributes: [.foregroundColor: UIColor.black,.font:UIFont(name: Font.medium.rawValue, size: 17)!]))
        text.append( NSAttributedString(string: "\n\(location)", attributes: [.foregroundColor: Color.text_grey,.font:UIFont(name: Font.regular.rawValue, size: 17)!]))
        return text
    }
}


extension OverlayRideActionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RideCell.reusableID, for: indexPath) as? RideCell else {
            fatalError("Cannot dequeue cell")
        }
        cell.data = rides[indexPath.row]
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rides[indexPath.row]
        playHaptic(style: .medium)
        confirmBtn.setTitle("Choose \(item.name)", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(94)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        TripAnimator.animate(cell: cell, indexPath: indexPath)
    }
    
}
