//
//  PaymentBadge.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.04.2022.
//

import Foundation
import UIKit

enum PaymentBadgeMode {
    case Pay
    case Remind
}

class PaymentBadge: UIView{
    
    // TODO добавить валюту
    // TODO добавить подтверждение оплаты
    
    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")
    let secondaryFillColor: UIColor? = UIColor(named: "SecondaryFill")
    let weakAccentColor: UIColor? = UIColor(named: "WeakAccentColor")
    
    var mode: PaymentBadgeMode = PaymentBadgeMode.Pay
    
    
    let totalDebtTitleLabel: UILabel = {
        let totalDebtTitleLabel = UILabel()
        totalDebtTitleLabel.text = "Суммарная задолженность" // TODO
        totalDebtTitleLabel.textAlignment = .left
        totalDebtTitleLabel.font = UIFont(name: "GTEestiProDisplay-Regular", size: 16)
        return totalDebtTitleLabel
    }()
    
    let totalDebtLabel: UILabel = {
        let totalDebtLabel = UILabel()
        totalDebtLabel.text =  "-9000 Р" // сумма задолженности
        totalDebtLabel.textAlignment = .left
        totalDebtLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        return totalDebtLabel
    }()
    
    let paymentAmountField: UITextField = {
        let paymentAmountField = UITextField()
        paymentAmountField.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        paymentAmountField.textAlignment = .center
        paymentAmountField.placeholder = "Сумма оплаты"
        paymentAmountField.keyboardType = .numberPad
        return paymentAmountField
    }()
    
    let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.setTitle("action button", for: .normal)
        actionButton.layer.cornerRadius = 20
        actionButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return actionButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    init() {
        super.init(frame: .zero)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    public func setMode(mode: PaymentBadgeMode){
        self.mode = mode
        onModeChange() // TODO
    }
    
    private func setLayout(){
        
        
        totalDebtTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalDebtTitleLabel.topAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.topAnchor,constant:  16),
            totalDebtTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            totalDebtTitleLabel.heightAnchor.constraint(equalToConstant: 20),
           ])
        
        totalDebtLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            totalDebtLabel.topAnchor.constraint(equalTo:  totalDebtTitleLabel.bottomAnchor,constant:  4),
            totalDebtLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            totalDebtLabel.heightAnchor.constraint(equalToConstant: 24),
           ])
        
        
        actionButton.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo:  self.bottomAnchor,constant:  -16),
            actionButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(equalToConstant: 120)
           ])
        
        
        paymentAmountField.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            paymentAmountField.bottomAnchor.constraint(equalTo:  self.bottomAnchor,constant:  -16),
            paymentAmountField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            paymentAmountField.heightAnchor.constraint(equalToConstant: 40),
            paymentAmountField.rightAnchor.constraint(equalTo: actionButton.leftAnchor, constant: -8)
           ])
        
    }
    
    private func setView(){
        
        self.backgroundColor = secondaryFillColor
        self.layer.cornerRadius = 25
        self.layer.borderColor = secondaryLabelColor?.cgColor
        self.layer.borderWidth = 1.0
    
        [totalDebtLabel,
         totalDebtTitleLabel,
         paymentAmountField,
         actionButton].forEach{self.addSubview($0)}
        
        totalDebtLabel.textColor = labelColor
        
        actionButton.backgroundColor = magentaColor
        
        setLayout()
    }
    
    func onModeChange(){
        switch self.mode{
        case PaymentBadgeMode.Pay:
            actionButton.backgroundColor = magentaColor
            paymentAmountField.isHidden = false
        case PaymentBadgeMode.Remind:
            actionButton.backgroundColor = greenColor
            paymentAmountField.isHidden = true
        }
    }
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    
}
