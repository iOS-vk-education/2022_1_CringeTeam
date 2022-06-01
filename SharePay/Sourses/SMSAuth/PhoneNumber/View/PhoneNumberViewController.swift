//
//  PhoneNumberViewController.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.04.2022.


import Foundation
import UIKit
import PhoneNumberKit

protocol PhoneNumberView: AnyObject{
    func onSuccess() -> Void
    func onInvalidNumber() -> Void
    func onServerFail() -> Void
}

final class PhoneNumberViewController: UIViewController{
    
    var presenter: PhoneNumberViewPresenter! // Ссылка на presenter

    let blueColor : UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? =   UIColor(named: "Label")
    let magentaColor : UIColor? = UIColor(named: "MagentaAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let fillColor: UIColor? = UIColor(named: "Fill")


    let welcomeImageView: UIImageView = {
        let image = UIImage(named: "welcomeImage")
        let welcomeImage = UIImageView(image: image!)
        return welcomeImage
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "GTEestiProDisplay-Bold", size: 24)
        titleLabel.text = "PhoneNumberViewController.Label.Title".localized()
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    let subtitleLabel: UILabel = {
        let subtitleLabel =  UILabel()
        subtitleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "PhoneNumberViewController.Label.Subtitle".localized()
        return subtitleLabel
    }()

    let phoneTextField: PhoneNumberTextField = {
        let phoneTextField = PhoneNumberTextField()
        phoneTextField.font =  UIFont(name: "GTEestiProDisplay-Medium", size: 32)
        phoneTextField.withFlag = true
        phoneTextField.withPrefix = true
        phoneTextField.withExamplePlaceholder = true
        return phoneTextField
    }()

    let continueButton: UIButton = {
        let getCodeButton = UIButton()
        getCodeButton.setTitle("PhoneNumberViewController.Button.Continue".localized(), for: .normal)
        getCodeButton.layer.cornerRadius = 25
        getCodeButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return getCodeButton
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = fillColor
        setView()
        setLayout()
        navigationItem.hidesBackButton = true;
        continueButton.addTarget(self, action: #selector(PhoneNumberViewController.didTapContinueButton), for: .touchUpInside)
        
    }
    
    @objc func didTapContinueButton(){
        continueButton.isEnabled =  false
        presenter.tapContinue(phoneNumber: phoneTextField.text ?? "")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setLayout(){

        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -5),
            welcomeImageView.heightAnchor.constraint(lessThanOrEqualToConstant: view.frame.height/3),
            welcomeImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 280)
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 8),
        ])

        subtitleLabel.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.75)
        ])

        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            phoneTextField.widthAnchor.constraint(equalToConstant: 280),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        continueButton.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            continueButton.widthAnchor.constraint(equalToConstant: 360),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }

    func setView(){
        [welcomeImageView,titleLabel,subtitleLabel, phoneTextField, continueButton].forEach{view.addSubview($0)}

        continueButton.backgroundColor =  blueColor

        titleLabel.textColor =  labelColor
        subtitleLabel.textColor = labelColor
        phoneTextField.textColor = labelColor

        welcomeImageView.contentMode = UIView.ContentMode.scaleAspectFit
    }

}

extension PhoneNumberViewController: PhoneNumberView{
    func onInvalidNumber() {
        continueButton.isEnabled =  true
        let alertController = UIAlertController(title:  "Common.Error".localized(), message:
        "PhoneNumberViewController.Alert.InvalidNumber".localized(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:  "Common.Ok".localized(), style: .default))
        self.present(alertController, animated: true, completion: nil)
        return
    }
    
    func onServerFail() {
        continueButton.isEnabled =  true
        let alertController = UIAlertController(title:  "Common.Error".localized(), message:
        "PhoneNumberViewController.Alert.ServerFail".localized(), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:  "Common.Ok".localized(), style: .default))
        self.present(alertController, animated: true, completion: nil)
        return
    }
    
    
    func onSuccess() {
        continueButton.isEnabled =  true
    }
}
