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
    
    var expandCompletion: (()->Void)?
    
    
   let emojiLabel: UILabel = {
       let emojiLabel = UILabel()
       emojiLabel.layer.borderWidth = 2
       emojiLabel.textAlignment = .center
       emojiLabel.font = UIFont(name: "GTEestiProDisplay-Regular", size: 36)
       emojiLabel.clipsToBounds = true
       emojiLabel.layer.cornerRadius = 30
       return emojiLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18)
        return titleLabel
    }()
    
    let amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font =  UIFont(name: "GTEestiProDisplay-Medium", size: 20)
        return amountLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
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
        emojiLabel.layer.borderColor = weakAccentColor?.cgColor
    }
    
    func setLayout(){
        emojiLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            emojiLabel.widthAnchor.constraint(equalToConstant: 60),
            emojiLabel.heightAnchor.constraint(equalToConstant: 60),
            emojiLabel.leftAnchor.constraint(equalTo:  self.leftAnchor, constant: 12),
            emojiLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
                                    
        tapButton.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            tapButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            tapButton.heightAnchor.constraint(equalToConstant: 30),
            tapButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tapButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        let rightStackView = UIStackView(arrangedSubviews: [amountLabel, dateLabel])
        rightStackView.axis = .vertical
        rightStackView.spacing = 8
        rightStackView.alignment = .trailing
        
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rightStackView)
        
        NSLayoutConstraint.activate([
            rightStackView.rightAnchor.constraint(equalTo: self.tapButton.leftAnchor, constant: -24),
            rightStackView.heightAnchor.constraint(equalToConstant: 40),
            rightStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: emojiLabel.rightAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.rightAnchor.constraint(equalTo: rightStackView.leftAnchor, constant: -4),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

    }
    
    func setExpandAction(completion: @escaping ()->Void){
        expandCompletion = completion
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventCell.didTapButton))
        tapButton.gestureRecognizers?.removeAll()
        tapButton.addGestureRecognizer(tap)
        tapButton.isUserInteractionEnabled = true
    }
    
    @objc func didTapButton(){
        expandCompletion?()
    }
    
    func setData(event: Event){
        emojiLabel.text = event.emoji
        dateLabel.text = event.date.decodeToRussianString()
        titleLabel.text = event.name
    
        if event.type == PAYMENT_TYPE{
            tapButton.isHidden =  true //  На начальном этапе экранов транзакций нет
            titleLabel.text = NSLocalizedString("DebtViewController.EventCell.Payment", comment: "")
            emojiLabel.text = "💸"
        } else {
            tapButton.isHidden =  false
        }
    
        amountLabel.text = "\(event.amount) \(event.currency)"
        if event.amount < 0{
            amountLabel.textColor = magentaColor
        } else {
            amountLabel.textColor = greenColor
        }
    }
}
