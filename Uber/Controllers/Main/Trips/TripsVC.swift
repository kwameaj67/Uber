//
//  TripsVC.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 1/30/23.
//

import UIKit

class TripsVC: UIViewController {

    var trips = Trip.data
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
    }
    
    // MARK: Properties
    lazy var cancelButton: UIButton = {
        let cb = UIButton()
        let image = UIImage(named: "uber-exit")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(weight: .heavy))
        cb.setBackgroundImage(image, for: .normal)
        cb.backgroundColor = .none
        cb.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var filterButton: UIButton = {
        let cb = UIButton(frame: .zero)
        cb.setTitle("Past", for: .normal)
        cb.setTitleColor(.black, for: .normal)
        cb.titleLabel?.font = UIFont(name: Font.regular.rawValue, size: 14)
        cb.setImage(UIImage(named: "uber-down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cb.imageEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        cb.semanticContentAttribute = .forceRightToLeft
        cb.backgroundColor = Color.grey_bg
        cb.layer.cornerRadius = 35/2
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var titleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Your trips"
        lb.textColor = .black
        lb.font = UIFont(name: Font.medium2.rawValue, size: 36)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var tripTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(TripCell.self, forCellReuseIdentifier: TripCell.reusableId)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        tv.allowsMultipleSelection = false
        tv.allowsSelection = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: Selectors -
    @objc func didTapCancel(){
        playHaptic(style: .medium)
        dismiss(animated: true)
    }
    func setupViews(){
        view.addSubview(cancelButton)
        view.addSubview(filterButton)
        view.addSubview(titleLbl)
        view.addSubview(tripTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 14),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 18),
            cancelButton.widthAnchor.constraint(equalToConstant: 18),
            
            filterButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            filterButton.heightAnchor.constraint(equalToConstant: 35),
            filterButton.widthAnchor.constraint(equalToConstant: 85),
            
            titleLbl.topAnchor.constraint(equalTo: cancelButton.bottomAnchor,constant: 15),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tripTableView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            tripTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tripTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tripTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: --  UITableViewDelegate, UITableViewDataSource
extension TripsVC:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TripCell.reusableId, for: indexPath) as? TripCell else {
            fatalError("Cannot dequeue TripCell")
        }
        cell.data = trips[indexPath.row]
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(230.0)
    }
   
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TripCell
        cell.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TripCell
        cell.backgroundColor = .white
    }
    
}
