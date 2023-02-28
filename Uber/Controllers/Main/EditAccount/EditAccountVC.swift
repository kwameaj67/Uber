//
//  EditAccountVC.swift
//  Uber
//
//  Created by Kwame Agyenim Boateng on 1/27/23.
//

import UIKit

class EditAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
        view.backgroundColor = .white
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
    
    lazy var smallTitleLbl: UILabel = {
        let lb = UILabel()
        lb.text = "Edit account"
        lb.textColor = .black
        lb.alpha = 0
        lb.font = UIFont(name: Font.medium.rawValue, size: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let headerView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var accountTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(EditAccountInfoCell.self, forCellReuseIdentifier: EditAccountInfoCell.reusableID)
        tv.register(EditAccountHeaderView.self, forHeaderFooterViewReuseIdentifier: EditAccountHeaderView.reuseableID)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
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
        dismiss(animated: true)
    }
    
    func setupViews(){
        view.addSubview(headerView)
        headerView.addSubview(cancelButton)
        headerView.addSubview(smallTitleLbl)
        view.addSubview(accountTableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 32),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 18),
            cancelButton.widthAnchor.constraint(equalToConstant: 18),
            
            smallTitleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            smallTitleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            accountTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource -
extension EditAccountVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: EditAccountHeaderView.reuseableID) as! EditAccountHeaderView
        view.contentView.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: .zero)
        footer.backgroundColor = Color.grey_bg2
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(225)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditAccountInfoCell.reusableID, for: indexPath) as! EditAccountInfoCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = Color.grey_bg2
        cell.selectedBackgroundView = bgView
        
        switch indexPath.row{
        case 0:
            cell.headingLbl.text = "First name"
            cell.dataLbl.text = "Kwame"
            toggleVerifiedLbl(isHidden: true, alpha: 0, cell: cell)
        case 1:
            cell.headingLbl.text = "Surname"
            cell.dataLbl.text = "Boateng"
            toggleVerifiedLbl(isHidden: true, alpha: 0, cell: cell)
        case 2:
            cell.headingLbl.text = "Phone number"
            cell.dataLbl.text = "+233 24 755 3965"
            toggleVerifiedLbl(isHidden: false, alpha: 1, cell: cell)
        case 3:
            cell.headingLbl.text = "Email address"
            cell.dataLbl.text = "kagyenimboateng65@gmail.com"
            toggleVerifiedLbl(isHidden: false, alpha: 1, cell: cell)
        case 4:
            cell.headingLbl.text = "Password"
            cell.dataLbl.text = "******"
            toggleVerifiedLbl(isHidden: true, alpha: 0, cell: cell)
        default:
            break
        }
        
        return cell
        
        
        func toggleVerifiedLbl(isHidden: Bool,alpha: CGFloat,cell: EditAccountInfoCell){
            cell.verifiedLbl.isHidden = isHidden
            cell.verifiedLbl.alpha = alpha
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let v = y/210
        let value = Double(round(100*v)/100)
        if value > 0.15 {
            UIView.animate(withDuration: 0.2) {
                self.smallTitleLbl.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.smallTitleLbl.alpha = 0
            }
        }
    }
    
}
