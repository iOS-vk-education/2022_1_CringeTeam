//
//  SMSCodeViewController.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 28.03.2022.
//

import Foundation
import UIKit
import KAPinField


final class SMSCodeViewController: UIViewController {
    
    let continueButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let errorCodeLabel: UILabel = UILabel()
    let pinField: KAPinField = KAPinField()
    let notSentCodeLabel: UILabel = UILabel()
    let resendCodeLabel: UILabel = UILabel()
    
    let blueColor : UIColor? = UIColor(hex: "#005DFF", alpha: CGFloat(255))
    let darkGrayColor : UIColor? =  UIColor(hex: "#142A42", alpha: CGFloat(255))
    let magentaColor : UIColor? = UIColor(hex: "#F90F54", alpha: CGFloat(255))
    let lightGrayColor : UIColor? = UIColor(hex: "#7E7E7E", alpha: CGFloat(255))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setLayout(){
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            continueButton.widthAnchor.constraint(equalToConstant: 360),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.widthAnchor.constraint(equalToConstant: 260),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        pinField.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            pinField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            pinField.widthAnchor.constraint(equalToConstant: 260)
        ])
        
        errorCodeLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            errorCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorCodeLabel.bottomAnchor.constraint(equalTo: pinField.topAnchor, constant: -4),
            errorCodeLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
        
        notSentCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notSentCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notSentCodeLabel.topAnchor.constraint(equalTo: pinField.bottomAnchor, constant: 40),
            notSentCodeLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
        
        resendCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resendCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resendCodeLabel.topAnchor.constraint(equalTo: notSentCodeLabel.bottomAnchor, constant: 0),
            resendCodeLabel.widthAnchor.constraint(equalToConstant: 260)
        ])
        
    }
    
    func setView(){
        
        view.addSubview(continueButton)
        continueButton.backgroundColor = blueColor
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.layer.cornerRadius = 25
        continueButton.titleLabel?.font = UIFont(name: "GTEestiProText-Medium", size: 16)
        
        view.addSubview(titleLabel)
        titleLabel.textColor = darkGrayColor // Не работает цвет
        titleLabel.font = UIFont(name: "GTEestiProText-Bold", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.text = "Введите код подтверждения"
        
        view.addSubview(subtitleLabel)
        subtitleLabel.textColor = lightGrayColor
        subtitleLabel.font = UIFont(name: "GTEestiProText-Medium", size: 14)
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Код был отправлен на номер \n +7 963 680 56 41 по смс"
        
        view.addSubview(pinField)
        pinField.properties.delegate = self
        pinField.properties.token = "-"
        pinField.properties.numberOfCharacters = 4
        pinField.properties.validCharacters = "0123456789"
        pinField.properties.animateFocus = true
        pinField.properties.isSecure = false
        pinField.appearance.font = .menloBold(30)
        pinField.appearance.textColor = magentaColor
        pinField.appearance.tokenColor = darkGrayColor
        pinField.appearance.keyboardType = UIKeyboardType.numberPad
        
        view.addSubview(errorCodeLabel)
        errorCodeLabel.textColor = magentaColor
        errorCodeLabel.font = UIFont(name: "GTEestiProText-Medium", size: 14)
        errorCodeLabel.textAlignment = .center
        errorCodeLabel.text = "Неверный SMS код"
        errorCodeLabel.isHidden = true
        
        view.addSubview(notSentCodeLabel)
        notSentCodeLabel.textColor = darkGrayColor
        notSentCodeLabel.font = UIFont(name: "GTEestiProText-Medium", size: 14)
        notSentCodeLabel.textAlignment = .center
        notSentCodeLabel.text = "Не получили код?"
        
        view.addSubview(resendCodeLabel)
        resendCodeLabel.textColor = darkGrayColor
        resendCodeLabel.font = UIFont(name: "GTEestiProText-Medium", size: 14)
        resendCodeLabel.textAlignment = .center
        resendCodeLabel.text = "Повторно отправить SMS"
    }
    
}

extension SMSCodeViewController: KAPinFieldDelegate{
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        pinField.animateSuccess(with: "👍") // onSuccess
        // TODO action when finish input SMS code
        errorCodeLabel.isHidden = false // onFailure
    }
}
