//
//  DebtTableViewCell.swift
//  SharePay
//
//  Created by User on 17.04.2022.
//
import UIKit

class DebtsTableViewCell: UITableViewCell {
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    
    var actionCompletion: (()->Void)?
    
   let logo: UILabel = {
       let logo = UILabel()
       logo.layer.borderWidth = 1
       logo.layer.borderColor = UIColor(named: "LightGreyColor")?.cgColor
       logo.layer.backgroundColor = UIColor(named: "LightGreyColor")?.cgColor
       logo.textColor = UIColor(named: "WhiteColor")
       logo.textAlignment = .center
       logo.font = UIFont(name: "GTEestiProDisplay-Medium", size: 30)
       logo.clipsToBounds = true
       logo.translatesAutoresizingMaskIntoConstraints = false
       logo.layer.cornerRadius = 30
       return logo
    }()
    
    let nameLabel = UILabel(text: "", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Medium")
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.text = " " + NSLocalizedString("DebtsViewController.SecondButton.Title", comment: "") + " "
        label.font = UIFont(name: "GTEestiProDisplay-Regular", size: 14)
        label.backgroundColor = UIColor(named: "DarkBlueColor")
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textColor = UIColor(named: "WhiteColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sumLabel = UILabel(text: "", color: "DarkBlueColor", size: 18, name: "GTEestiProDisplay-Medium")
    
    let tapButton: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor(named: "GreyColor")
        return imageView
     }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        sumLabel.textAlignment = .right
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sumLabel)
        
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
            sumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
        ])
        
        NSLayoutConstraint.activate([
            tapButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func setData(item: DebtItem){
        sumLabel.text = "\(item.amount)"
        if item.amount > 0{
            sumLabel.textColor = greenColor
        } else {
            sumLabel.textColor = magentaColor
        }
        
        nameLabel.text = item.name
        
        let nameAttrs = item.name.components(separatedBy: .whitespacesAndNewlines)
        guard var letters = nameAttrs.first?.prefix(1) else {
              return
        }
        if nameAttrs.count>1 && nameAttrs[1].count>0{
            letters+=nameAttrs[1].prefix(1)
        }
        logo.text = String(letters)
    }
    
    func setAction(completion: @escaping () -> Void){
        self.actionCompletion = completion
        tapButton.gestureRecognizers?.removeAll()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapButton))
        tapButton.addGestureRecognizer(tap)
        tapButton.isUserInteractionEnabled = true
    }
    
    @objc func didTapButton(){
        self.actionCompletion?()
    }
}
