//
//  ViewController.swift
//  RandomNumbers
//
//  Created by Ersan Shimshek on 02.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: Параметры
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    
    //MARK: Примечание: если количество вертикальных ячеек без верхней границы, то грузится очень долго
    //let upperLimit = Int.max()
    let upperLimit = 110
    
    var timer: Timer?
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
}

//MARK: Конфигурация
extension ViewController {
    func setup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellId)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}


//MARK: CollectionView Delegate/Data Source, UICollectionViewDelgateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 101..<upperLimit)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellId, for: indexPath)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-24, height: 80)
    }
}

extension ViewController {
    
    //MARK: Селектор для таймера
    @objc func fireTimer(){
        for cell in collectionView.visibleCells {
            guard let cell = cell as? CustomCollectionViewCell else {
                continue
            }
            cell.configInterface()
        }
    }
}
