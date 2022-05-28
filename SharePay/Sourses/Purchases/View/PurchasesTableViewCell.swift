//
//  PurchasesTableViewCell.swift
//  SharePay
//
//  Created by User on 10.04.2022.
//
import UIKit

class PurchasesTableViewCell: UITableViewCell {
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    
    var actionCompletion: (()->Void)?
    
   let logo: UILabel = {
       let logo = UILabel()
       logo.layer.borderWidth = 1
       logo.textAlignment = .center
       logo.font = UIFont(name: "GTEestiProDisplay-Regular", size: 36)
       logo.clipsToBounds = true
       logo.translatesAutoresizingMaskIntoConstraints = false
       logo.layer.cornerRadius = 30
       return logo
    }()
    
    let nameLabel = UILabel(text: "", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Medium")
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.text = "PurchasesViewController.Type.Title".localized()
        label.font = UIFont(name: "GTEestiProDisplay-Bold", size: 14)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sumLabel = UILabel(text: "", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Medium")
    
    let dateLabel = UILabel(text: "", color: "GreyColor", size: 14, name: "GTEestiProDisplay-Regular")
    
    let tapButton: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
     }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(){
        logo.backgroundColor = secondaryFillColor
        logo.layer.borderColor = weakAccentColor?.cgColor
        logo.layer.borderWidth = 1
        nameLabel.textColor = labelColor
        sumLabel.textColor = labelColor
        dateLabel.textColor = secondaryLabelColor
        tapButton.tintColor = secondaryLabelColor
        typeLabel.backgroundColor = labelColor
    }

    func setConstraints() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(logo)
        let firstStackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        firstStackView.axis = .vertical
        firstStackView.spacing = 10
        firstStackView.alignment = .leading
        
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstStackView)

        let secondStackView = UIStackView(arrangedSubviews: [sumLabel, dateLabel])
        secondStackView.axis = .vertical
        secondStackView.spacing = 10
        secondStackView.alignment = .trailing
        
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(secondStackView)
        
        self.addSubview(tapButton)

        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logo.heightAnchor.constraint(equalToConstant: 60),
            logo.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            firstStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            firstStackView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            secondStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
        ])
        
        NSLayoutConstraint.activate([
            tapButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func setData(purchase: PurchaseItem){
        logo.text = purchase.emoji
        nameLabel.text =  purchase.name
        dateLabel.text =  purchase.created_at.decodeToRussianString()
        sumLabel.text = "\(purchase.amount) \(purchase.currency.toCurrencySign())"
        if !purchase.isDraft {
            typeLabel.backgroundColor = greenColor
            typeLabel.text = "PurchasesViewController.Type.Title2".localized()
        } else{
            typeLabel.backgroundColor = UIColor(named: "DarkBlueColor")
            typeLabel.text = "PurchasesViewController.Type.Title".localized()
        }
    }
    
    func setAction(completion: @escaping ()->Void){
        self.actionCompletion = completion
        tapButton.gestureRecognizers?.removeAll()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapButton))
        tapButton.addGestureRecognizer(tap)
        tapButton.isUserInteractionEnabled = true
    }
    
    @objc func didTapButton(sender: UITapGestureRecognizer){
        self.actionCompletion?()
    }
}
