//
//  AccountActionsCell.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 25/12/2022.
//

import UIKit

class AccountActionHeader: UITableViewHeaderFooterView {

    private let options = AccountActionOption.data
    static let reuseableID = "AccountActionsCell"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: AccountActionHeader.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -

    lazy var imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 115, height: 95)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: true)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .red
        cv.register(AccountActionCollectionCell.self, forCellWithReuseIdentifier: AccountActionCollectionCell.reusableID)
        cv.allowsSelection = true
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let border: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    func setupViews(){
        addSubview(imageCollectionView)
        addSubview(border)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 110),
            
            border.topAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 8),
        ])
    }
}
extension AccountActionHeader: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountActionCollectionCell.reusableID, for: indexPath) as! AccountActionCollectionCell
        cell.data = options[indexPath.row]
        
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = .systemGray4
        bgView.layer.cornerRadius = 15
        cell.selectedBackgroundView = bgView
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 95)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
              return 15
      }
}
