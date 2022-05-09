//
//  PaymentBadge.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 21.04.2022.
//

import Foundation
import UIKit
import PhoneNumberKit

enum PaymentBadgeMode {
    case Pay
    case Remind
}

class PaymentBadge: UIView{
    
    // На первом этапе валюта - рубль
    
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
        totalDebtTitleLabel.text = NSLocalizedString("PaymentBadge.Label.TotalAmount", comment: "")
        totalDebtTitleLabel.textAlignment = .left
        totalDebtTitleLabel.font = UIFont(name: "GTEestiProDisplay-Regular", size: 16)
        return totalDebtTitleLabel
    }()
    
    let totalDebtLabel: UILabel = {
        let totalDebtLabel = UILabel()
        totalDebtLabel.textAlignment = .left
        totalDebtLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        return totalDebtLabel
    }()
    
    let paymentAmountField: UITextField = {
        let paymentAmountField = UITextField()
        paymentAmountField.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        paymentAmountField.textAlignment = .right
        paymentAmountField.placeholder = "0"
        paymentAmountField.keyboardType = .numberPad
        return paymentAmountField
    }()
    
    let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.setTitle(NSLocalizedString("PaymentBadge.Label.Pay", comment: ""), for: .normal)
        actionButton.layer.cornerRadius = 20
        actionButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return actionButton
    }()
    
    let currencyLabel: UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        currencyLabel.textAlignment =  .left
        return currencyLabel
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
    
    public func setAmount(amount: Int, currrency: String){
        // Если сумма брльше нуля значит мы должна
        // Если сумма меньше нуля значит нам должны
        if amount>0{
            self.mode = .Pay
        } else {
            self.mode = .Remind
        }
        currencyLabel.text = currrency
        totalDebtLabel.text = "\(amount) \(currrency)"
        onModeChange()
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
            paymentAmountField.widthAnchor.constraint(equalToConstant: 72)
           ])
        
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyLabel.bottomAnchor.constraint(equalTo:  self.bottomAnchor,constant:  -16),
            currencyLabel.leftAnchor.constraint(equalTo: paymentAmountField.rightAnchor, constant: 4),
            currencyLabel.heightAnchor.constraint(equalToConstant: 40),
            currencyLabel.rightAnchor.constraint(equalTo: actionButton.leftAnchor, constant: -8)
           ])
        
    }
    
    private func setView(){
        
        self.backgroundColor = secondaryFillColor
        self.layer.cornerRadius = 25
        self.layer.borderColor = secondaryLabelColor?.cgColor
        self.layer.borderWidth = 2.0
    
        [totalDebtLabel,
         totalDebtTitleLabel,
         paymentAmountField,
         actionButton,
        currencyLabel].forEach{self.addSubview($0)}
        
        totalDebtLabel.textColor = labelColor
        currencyLabel.textColor = labelColor
        
        actionButton.backgroundColor = magentaColor
        
        setLayout()
    }
    
    private func onModeChange(){
        switch self.mode{
        case PaymentBadgeMode.Pay:
            actionButton.setTitle(NSLocalizedString("PaymentBadge.Label.Pay", comment: ""), for: .normal)
            actionButton.backgroundColor = magentaColor
            paymentAmountField.isHidden = false
            currencyLabel.isHidden = false
        case PaymentBadgeMode.Remind:
            actionButton.setTitle(NSLocalizedString("PaymentBadge.Label.Remind", comment: ""), for: .normal)
            actionButton.backgroundColor = greenColor
            currencyLabel.isHidden = true
            paymentAmountField.isHidden = true
        }
    }
    
    public func setActions(payCompletion: @escaping (Int)-> Void, notifyCompletion: @escaping ()-> Void){
        actionButton.removeTarget(nil, action: nil, for: .allEvents)
        
        actionButton.addAction(for: .touchUpInside) { [weak self] in
            guard let strongSelf = self else{
                return
            }
            switch strongSelf.mode{
                case PaymentBadgeMode.Pay:
                    guard let payAmountStr = self?.paymentAmountField.text else{
                        return
                    }
                    let payAmount = Int(payAmountStr) ?? 0
                    if payAmount>0{
                        payCompletion(payAmount)
                        self?.paymentAmountField.text = ""
                    }
                case PaymentBadgeMode.Remind:
                    notifyCompletion()
            }
        }
    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
}
