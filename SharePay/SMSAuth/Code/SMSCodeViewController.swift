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
    
    
    // TODO синхронизиировать цвета
    let blueColor : UIColor? = UIColor(hex: "#005DFF", alpha: CGFloat(255))
    let darkGrayColor : UIColor? =  UIColor(hex: "#142A42", alpha: CGFloat(255))
    let magentaColor : UIColor? = UIColor(hex: "#F90F54", alpha: CGFloat(255))
    let lightGrayColor : UIColor? = UIColor(hex: "#7E7E7E", alpha: CGFloat(255))
    
    
    let phoneNumber = "+79013511292" // TODO
    
    let continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.setTitle(NSLocalizedString("SMSCodeViewController.Button.Continue", comment: ""), for: .normal)
        continueButton.layer.cornerRadius = 25
        continueButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return continueButton
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        titleLabel.textAlignment = .center
        titleLabel.text = NSLocalizedString("SMSCodeViewController.Label.Title", comment: "")
        return titleLabel
    }()
    
    let subtitleLabel: UILabel = {
        let subtitleLabel =  UILabel()
        subtitleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        subtitleLabel.textAlignment = .center
        return subtitleLabel
    }()
    
    let pinField: KAPinField = {
        let pinField = KAPinField()
        pinField.properties.token = "-"
        pinField.properties.numberOfCharacters = 4
        pinField.properties.validCharacters = "0123456789"
        pinField.properties.animateFocus = true
        pinField.properties.isSecure = false
        pinField.appearance.font = .menloBold(30)
        pinField.appearance.keyboardType = UIKeyboardType.numberPad
        return pinField
    }()
    
    let errorCodeLabel: UILabel = {
        let errorCodeLabel = UILabel()
        errorCodeLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        errorCodeLabel.textAlignment = .center
        errorCodeLabel.text = NSLocalizedString("SMSCodeViewController.Label.errorCode", comment: "")
        return errorCodeLabel
    }()
    
    let notSentCodeLabel: UILabel = {
        let notSentCodeLabel = UILabel()
        notSentCodeLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        notSentCodeLabel.textAlignment = .center
        notSentCodeLabel.text = NSLocalizedString("SMSCodeViewController.Label.notSentCode", comment: "")
        return notSentCodeLabel
    }()
    
    let resendCodeLabel: UILabel = {
        let resendCodeLabel =  UILabel()
        resendCodeLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        resendCodeLabel.textAlignment = .center
        resendCodeLabel.text = NSLocalizedString("SMSCodeViewController.Label.resendCode", comment: "")
        return resendCodeLabel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pinField.becomeFirstResponder()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        view.backgroundColor = .white
        pinField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setLayout(){
        

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/10)
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
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: resendCodeLabel.bottomAnchor, constant: 24),
            continueButton.widthAnchor.constraint(equalToConstant: 360),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    func setView(){
        
        [continueButton,titleLabel,subtitleLabel, pinField, errorCodeLabel, notSentCodeLabel, resendCodeLabel].forEach{view.addSubview($0)}
        
        continueButton.backgroundColor = blueColor
        
        titleLabel.textColor = darkGrayColor
        subtitleLabel.textColor = lightGrayColor
        notSentCodeLabel.textColor = darkGrayColor
        resendCodeLabel.textColor = darkGrayColor
        
        errorCodeLabel.textColor = magentaColor
        errorCodeLabel.isHidden = true
        
        pinField.appearance.textColor = magentaColor
        pinField.appearance.tokenColor = darkGrayColor
        pinField.properties.delegate = self
        
        subtitleLabel.text = String(format: NSLocalizedString("SMSCodeViewController.Label.Subtitle", comment: ""),phoneNumber)
        
    }
    
    
}

extension SMSCodeViewController: KAPinFieldDelegate{
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        pinField.animateSuccess(with: "👍") // onSuccess
        // TODO action when finish input SMS code
        errorCodeLabel.isHidden = false // onFailure
    }
}
