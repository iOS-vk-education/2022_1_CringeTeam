//
//  ParticipantTableViewCell.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 08.04.2022.
//

import Foundation
import UIKit


final class ParticipantCell: UICollectionViewCell{
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text =  "Алиса" // hardcode
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 16)
        return nameLabel
    }()
    
    let letterNameLabel: UILabel = {
        let letterName = UILabel()
        letterName.text = "А" // hardcode
        letterName.textAlignment = .center
        letterName.font = UIFont(name: "GTEestiProDisplay-Bold", size: 18)
        letterName.layer.cornerRadius = 18
        letterName.layer.masksToBounds = true
        return letterName
    }()
    
    let totalTextField: UITextField = {
        let totalTextField = UITextField(cornerRadius: 20)
        totalTextField.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18) // TODO
        //totalTextField.placeholder = "1000" // TODO
        totalTextField.keyboardType = .numberPad
        return totalTextField
    }()
    
    let removeButton: UIButton = {
        let removeButton = UIButton()
        removeButton.setTitle("-", for: .normal)
        removeButton.layer.cornerRadius = 18
        removeButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 24)
        return removeButton
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = backgroundFillColor
        setupViews()
        setupLayout()
    }
    
    private func setupViews(){
        
        [nameLabel,
        letterNameLabel,totalTextField,
         removeButton].forEach{self.contentView.addSubview($0)}
        
        nameLabel.textColor = labelColor
        
        totalTextField.textColor = labelColor
        
        letterNameLabel.textColor = .white
        letterNameLabel.backgroundColor = secondaryLabelColor
        
        removeButton.backgroundColor = magentaColor
        
    }
    
    private func setupLayout(){
        
        let contentWidth = contentView.frame.width // Проверить возможно width = 0
        
        // # Left side
        letterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            letterNameLabel.widthAnchor.constraint(equalToConstant: 40),
            letterNameLabel.heightAnchor.constraint(equalToConstant: 40),
            letterNameLabel.leftAnchor.constraint(equalTo:  contentView.leftAnchor, constant: 12),
            letterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.37),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leftAnchor.constraint(equalTo:  letterNameLabel.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
        
        // # Right side
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.widthAnchor.constraint(equalToConstant: 36),
            removeButton.heightAnchor.constraint(equalToConstant: 36),
            removeButton.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -8),
            removeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
        totalTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalTextField.widthAnchor.constraint(equalToConstant: contentWidth*0.25),
            totalTextField.heightAnchor.constraint(equalToConstant: 40),
            totalTextField.rightAnchor.constraint(equalTo:  removeButton.leftAnchor, constant: -8),
            totalTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
