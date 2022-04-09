//
// Created by Pudovkin Dmitriy Olegovich on 08.04.2022.
//

import Foundation
import UIKit


final class PurchaseViewController: UIViewController, UICollectionViewDelegate{

    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")


    
    var participantCollectionView: UICollectionView?

    let namePurchaseLabel: UILabel = {
        let namePurchaseLabel: UILabel = UILabel()
        namePurchaseLabel.text =  "Название покупки"
        namePurchaseLabel.textAlignment = .left
        namePurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return namePurchaseLabel
    }()

    let totalLabel: UILabel = {
        let totalPurchaseLabel: UILabel = UILabel()
        totalPurchaseLabel.text = "Сумма покупки"
        totalPurchaseLabel.textAlignment = .left
        totalPurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return totalPurchaseLabel
    }()

    let iconLabel: UILabel = {
        let iconLabel: UILabel = UILabel()
        iconLabel.text = "Иконка"
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return iconLabel
    }()
    
    let emojiSelectLabel: UILabel = {
        let emojiSelectLabel: UILabel = UILabel()
        emojiSelectLabel.text = "✈️"
        emojiSelectLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 32) // TODO
        emojiSelectLabel.textAlignment = .center
        return emojiSelectLabel
    }()
    
    let nameTextField: UITextField = {
        let nameTextField: UITextField = UITextField()
        nameTextField.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18) // TODO
        nameTextField.placeholder = "Билеты на самолет)" // TODO
        nameTextField.textAlignment = .left
        return nameTextField
    }()
    
    let totalTextField: UITextField = {
        let totalTextField: UITextField = UITextField()
        totalTextField.font = UIFont(name: "GTEestiProDisplay-Medium", size: 18) // TODO
        totalTextField.placeholder = "1000"
        totalTextField.keyboardType = .numberPad
        return totalTextField
    }()
    
    let participantLabel: UILabel = {
        let participantLabel: UILabel = UILabel()
        participantLabel.text = "Участники"
        participantLabel.textAlignment = .left
        participantLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return participantLabel
    }()
    
    let addParticipantButton: UIButton = {
        let addParticipantButton: UIButton = UIButton()
        addParticipantButton.setTitle("Добавить", for: .normal)
        addParticipantButton.layer.cornerRadius = 25
        addParticipantButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return addParticipantButton
    }()
    
    let equalSplitButton: UIButton = {
        let equalSplitButton: UIButton = UIButton()
        equalSplitButton.setTitle("Поровну", for: .normal)
        equalSplitButton.layer.cornerRadius = 25
        equalSplitButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return equalSplitButton
    }()
    
    let saveButton: UIButton = {
        let saveButton: UIButton = UIButton()
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.layer.cornerRadius = 25
        saveButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return saveButton
    }()
    
     // TODO добавит кнопку delete Button
    
    
    let infoTextLabel: UILabel = {
        let textLabel: UILabel = UILabel()
        textLabel.text = "После сохранения покупки не забудьте выставить счета всем участникам"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return textLabel
    }()
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutCollectionView()
        setView()
        setLayout()
        
        let dataSource = ParticipantDataSource()
        participantCollectionView?.dataSource = dataSource
        participantCollectionView?.delegate = self
        
    }

    func configureNavigationItem(){
        navigationItem.title = "Создание покупки"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "GTEestiProDisplay-Bold", size: 20)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    func configureLayoutCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        participantCollectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height/2.5, width: view.frame.width, height: view.frame.height/3), collectionViewLayout: layout)
        participantCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ParticipantCell")
        participantCollectionView?.backgroundColor = backgroundFillColor
    }
    
    

    func setLayout(){
        
        let rootView = view!
        
        let contentWidth = rootView.frame.width
        
        // Row #1
        namePurchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePurchaseLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            namePurchaseLabel.heightAnchor.constraint(equalToConstant: 24),
            namePurchaseLabel.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 12),
            namePurchaseLabel.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.2),
            iconLabel.heightAnchor.constraint(equalToConstant: 24),
            iconLabel.leftAnchor.constraint(equalTo: namePurchaseLabel.rightAnchor, constant: 0),
            iconLabel.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 8)
        ])
        
        
        // Row #2
        nameTextField.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            nameTextField.topAnchor.constraint(equalTo: namePurchaseLabel.bottomAnchor, constant: 4)
        ])
        
        emojiSelectLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiSelectLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.2),
            emojiSelectLabel.heightAnchor.constraint(equalToConstant: 40),
            emojiSelectLabel.leftAnchor.constraint(equalTo: namePurchaseLabel.rightAnchor, constant: 0),
            emojiSelectLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #3
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            totalLabel.heightAnchor.constraint(equalToConstant: 24),
            totalLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            totalLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8)
        ])
    
        // Row #4
        totalTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalTextField.widthAnchor.constraint(equalToConstant: contentWidth*0.8),
            totalTextField.heightAnchor.constraint(equalToConstant: 40),
            totalTextField.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            totalTextField.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #5
        participantLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            participantLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            participantLabel.heightAnchor.constraint(equalToConstant: 24),
            participantLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            participantLabel.topAnchor.constraint(equalTo: totalTextField.bottomAnchor, constant: 8)
        ])
        
        
        // # Bottom
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoTextLabel.widthAnchor.constraint(equalToConstant: rootView.frame.width/1.5),
            infoTextLabel.heightAnchor.constraint(equalToConstant: 40),
            infoTextLabel.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            infoTextLabel.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])

        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: infoTextLabel.topAnchor, constant: -16)
        ])
        
        
    }

    func setView(){
        self.view.backgroundColor = backgroundFillColor
        self.navigationItem.title = "Создние покупки" // TODO
        self.navigationController?.navigationBar.prefersLargeTitles = true // TODO
    
        
        // Список элементов view
        [emojiSelectLabel,
         iconLabel,
         totalLabel,
         namePurchaseLabel,
         nameTextField,
         totalTextField,
         addParticipantButton,
         equalSplitButton,
         participantLabel,
         saveButton,
         infoTextLabel,
         participantCollectionView!].forEach{view.addSubview($0)}

        // Установка цвета для label
        iconLabel.textColor = labelColor
        totalLabel.textColor = labelColor
        namePurchaseLabel.textColor = labelColor
        emojiSelectLabel.textColor = labelColor
        
        // Установка цвета для secondaryLabel
        infoTextLabel.textColor = secondaryLabelColor
        
        // Установка цвета для textField
        nameTextField.textColor = labelColor
        totalTextField.textColor = labelColor
        
        // Установка цветов для кнопок
        addParticipantButton.backgroundColor = greenColor
        equalSplitButton.backgroundColor = blueColor
        saveButton.backgroundColor = blueColor
    }


}

