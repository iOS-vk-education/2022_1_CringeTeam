//
//  PhoneNumberViewController.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 04.04.2022.


import Foundation
import UIKit
import PhoneNumberKit

final class PhoneNumberViewController: UIViewController{

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
        titleLabel.text = NSLocalizedString("PhoneNumberViewController.Label.Title", comment: "")
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    let subtitleLabel: UILabel = {
        let subtitleLabel =  UILabel()
        subtitleLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = NSLocalizedString("PhoneNumberViewController.Label.Subtitle", comment: "")
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
        getCodeButton.setTitle(NSLocalizedString("PhoneNumberViewController.Button.Continue", comment: ""), for: .normal)
        getCodeButton.layer.cornerRadius = 25
        getCodeButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        getCodeButton.addTarget(self, action: #selector(tap(sender:)), for: .touchUpInside)
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
    
    @objc private func tap(sender: UIButton) {
        let navVC = UINavigationController(rootViewController: SMSCodeViewController())
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }

}
