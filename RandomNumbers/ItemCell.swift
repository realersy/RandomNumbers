//
//  ItemCell.swift
//  RandomNumbers
//
//  Created by Ersan Shimshek on 02.03.2024.
//

import Foundation
import UIKit

final class ItemCell: UICollectionViewCell {
    
    //MARK: Параметры
    public static var cellId = "itemCell"
    
    let button = UIButton()
    
    //MARK: Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        let pressGesture = UILongPressGestureRecognizer()
        button.addGestureRecognizer(pressGesture)
        pressGesture.addTarget(self, action: #selector(tapGesture))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
//MARK: Setup Button
extension ItemCell {
    func setup(){
        
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configButton(){
        button.titleLabel?.textColor = .white
        button.setTitle(String(Int.random(in: 1..<11)), for: [])
        button.backgroundColor = .systemBlue
        button.titleLabel?.textAlignment = .center
    }
    
    func configItem(num: Int){
        button.setTitle(String(num), for: [])
    }
}

//MARK: GestureRecognizer
extension ItemCell {
    @objc func tapGesture(sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            UIView.animate(withDuration: 0.3) {
                self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.button.transform = .identity
            }
        }
    }
}


