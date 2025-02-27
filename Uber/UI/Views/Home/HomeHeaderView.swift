//
//  HomeViewHeader.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/12/2022.
//

import UIKit


protocol HomeHeaderViewDelegate: AnyObject {
    func didTapFeatureOption(featureType: UberFeatureType)
}
class HomeHeaderView: UITableViewHeaderFooterView {
    
    private let options = UberFeatureOption.data
    static let reuseableID = "HomeHeaderView"
    
    weak var delegate: HomeHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: HomeHeaderView.reuseableID)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let promoView: UIView = {
        let v = PromoAdView()
        return v
    }()
    
    // shortcut buttons
    lazy var imageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: true)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .none
        cv.register(UberOptionCollectionCell.self, forCellWithReuseIdentifier: UberOptionCollectionCell.reusableID)
        cv.allowsSelection = true
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        cv.allowsMultipleSelection = false
        cv.showsVerticalScrollIndicator = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var searchView: SearchLocationView = {
        let v = SearchLocationView()
        v.layer.cornerRadius = 60/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    func setupViews(){
        addSubview(promoView)
        addSubview(imageCollectionView)
        addSubview(searchView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: topAnchor),
            promoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            promoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            promoView.heightAnchor.constraint(equalToConstant: 138),
            
            imageCollectionView.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: 18),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 210),
            
            searchView.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: 20),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 55)
            
        ])
    }
}

extension HomeHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UberOptionCollectionCell.reusableID, for: indexPath) as! UberOptionCollectionCell
        cell.data = options[indexPath.row]
        
        let bgView = UIView(frame: cell.bounds)
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10
        cell.selectedBackgroundView = bgView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width-30)/4, height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = options[indexPath.row]
        playHaptic(style: .medium)
        delegate?.didTapFeatureOption(featureType: item.type)
    }
    
}
