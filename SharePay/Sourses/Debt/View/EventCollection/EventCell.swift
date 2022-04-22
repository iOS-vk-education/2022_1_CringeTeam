//
//  EventCell.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 23.04.2022.
//

import Foundation
import UIKit


final class EventCell: UICollectionViewCell{
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    
    
   let emojiLabel: UILabel = {
       let emojiLabel = UILabel()
       emojiLabel.layer.borderWidth = 1
       emojiLabel.text = "🍎" // TODO
       emojiLabel.textAlignment = .center
       emojiLabel.font = UIFont(name: "GTEestiProDisplay-Regular", size: 24)
       emojiLabel.clipsToBounds = true
       emojiLabel.layer.cornerRadius = 30
       return emojiLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18)
        titleLabel.text =  "Билеты в турцию"
        return titleLabel
    }()
    
    let amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font =  UIFont(name: "GTEestiProDisplay-Medium", size: 20)
        amountLabel.text = "+2000 Р"
        return amountLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 12)
        dateLabel.text = "12.02.2021"
        return dateLabel
    }()
    
    let tapButton: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
     }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = backgroundFillColor
        setView()
        setLayout()
    }

    func setView(){
        [emojiLabel,
         titleLabel,
         amountLabel,
         dateLabel,
         tapButton].forEach{self.addSubview($0)}
        
        titleLabel.textColor = labelColor
        amountLabel.textColor = labelColor
        dateLabel.textColor = secondaryLabelColor
        tapButton.tintColor = secondaryLabelColor
        emojiLabel.backgroundColor = secondaryFillColor
        emojiLabel.layer.borderColor = secondaryLabelColor?.cgColor
    }
    
    func setLayout(){
        emojiLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            emojiLabel.widthAnchor.constraint(equalToConstant: 60),
            emojiLabel.heightAnchor.constraint(equalToConstant: 60),
            emojiLabel.leftAnchor.constraint(equalTo:  self.leftAnchor, constant: 12),
            emojiLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: emojiLabel.rightAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
                                    
        tapButton.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            tapButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            tapButton.heightAnchor.constraint(equalToConstant: 40),
            tapButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tapButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountLabel.rightAnchor.constraint(equalTo: self.tapButton.leftAnchor, constant: -24),
            amountLabel.heightAnchor.constraint(equalToConstant: 24),
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: amountLabel.leftAnchor),
            dateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 0),
            dateLabel.heightAnchor.constraint(equalToConstant: 12)
        ])

    }
    
}
