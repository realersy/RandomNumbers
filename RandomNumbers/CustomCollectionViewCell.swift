//
//  CustomCollectionViewCell.swift
//  RandomNumbers
//
//  Created by Ersan Shimshek on 02.03.2024.
//

import Foundation
import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: Параметры
    
    public static let cellId = "CustomCollectionViewCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    
    //MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configInterface(){
        guard let cell = collectionView.visibleCells.randomElement() as? ItemCell else {
            return
        }
        cell.configItem(num: Int.random(in: 10..<15))
    }
}

//MARK: Setup collectionView
extension CustomCollectionViewCell {
    func setup(){
        
        //CollectionView
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .lightGray
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CustomCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.cellId, for: indexPath) as! ItemCell
        cell.configButton()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 10..<15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (UIScreen.main.bounds.width / 6) - 24
        return CGSize(width: length, height: length)
    }
}
