//
//  TransfersTableViewCell.swift
//  SharePay
//
//  Created by User on 18.04.2022.
//
import UIKit

class TransfersTableViewCell: UITableViewCell {
    
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    
   let logo: UILabel = {
       let logo = UILabel()
       logo.layer.borderWidth = 1
       logo.layer.borderColor = UIColor(named: "LightGreyColor")?.cgColor
       logo.layer.backgroundColor = UIColor(named: "LightGreyColor")?.cgColor
       logo.textColor = UIColor(named: "WhiteColor")
       logo.textAlignment = .center
       logo.font = UIFont(name: "GTEestiProDisplay-Medium", size: 24)
       logo.clipsToBounds = true
       logo.translatesAutoresizingMaskIntoConstraints = false
       logo.layer.cornerRadius = 30
       return logo
    }()
    
    let nameLabel = UILabel(text: "Denis Kholod", color: "Label", size: 18, name: "GTEestiProDisplay-Medium")
    
    let sumLabel = UILabel(text: "+200 \u{20BD}", color: "GreenAccentColor", size: 18, name: "GTEestiProDisplay-Medium")
      
    let dateLabel = UILabel(text: "22.04.2022", color: "GreyColor", size: 14, name: "GTEestiProDisplay-Regular")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setConstraints()
    }
    
    let currencySign = "₽" // По умолчанию на первом этапе только рубль
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setConstraints() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(logo)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)

        let secondStackView = UIStackView(arrangedSubviews: [sumLabel, dateLabel])
        secondStackView.axis = .vertical
        secondStackView.spacing = 10
        secondStackView.alignment = .trailing
        
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondStackView)

        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logo.heightAnchor.constraint(equalToConstant: 60),
            logo.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            secondStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func setData(transfer: Transfer){
        nameLabel.text = transfer.name
        
        if transfer.amount >= 0{
            sumLabel.text = "+\(transfer.amount) \(currencySign)"
            sumLabel.textColor = greenColor
        } else {
            sumLabel.text = "\(transfer.amount) \(currencySign)"
            sumLabel.textColor = magentaColor
        }
        
        dateLabel.text = transfer.created_at.decodeToRussianString()
        
        let nameAttrs = transfer.name.components(separatedBy: .whitespacesAndNewlines)
        guard var letters = nameAttrs.first?.prefix(1) else {
              return
        }

        if nameAttrs.count>1 && nameAttrs[1].count>0{
            letters+=nameAttrs[1].prefix(1)
        }
        
        self.logo.text = String(letters)
    }
    
}
