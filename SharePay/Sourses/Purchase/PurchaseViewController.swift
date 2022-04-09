//
// Created by Pudovkin Dmitriy Olegovich on 08.04.2022.
//

import Foundation
import UIKit
import EmojiPicker


final class PurchaseViewController: UIViewController, UICollectionViewDelegate{

    // Инициализация цветов
    let blueColor: UIColor? = UIColor(named: "BlueAccentColor")
    let labelColor: UIColor? = UIColor(named: "Label")
    let magentaColor: UIColor? = UIColor(named: "MagentaAccentColor")
    let greenColor: UIColor? = UIColor(named:"GreenAccentColor")
    let secondaryLabelColor: UIColor? = UIColor(named: "SecondaryLabel")
    let backgroundFillColor: UIColor? = UIColor(named: "Fill")


    
    var participantCollectionView: UICollectionView?
    
    let emojiPickerVC = EmojiPicker.viewController


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
        addParticipantButton.layer.cornerRadius = 20
        addParticipantButton.titleLabel?.font = UIFont(name: "GTEestiProDisplay-Medium", size: 16)
        return addParticipantButton
    }()
    
    let equalSplitButton: UIButton = {
        let equalSplitButton: UIButton = UIButton()
        equalSplitButton.setTitle("Поровну", for: .normal)
        equalSplitButton.layer.cornerRadius = 20
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
    
    let infoTextLabel: UILabel = {
        let textLabel: UILabel = UILabel()
        textLabel.text = "После сохранения покупки не забудьте выставить счета всем участникам"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return textLabel
    }()
    
    let datePurchaseLabel: UILabel = {
        let datePurchaseLabel: UILabel = UILabel()
        datePurchaseLabel.text = "Дата покупки"
        datePurchaseLabel.textAlignment = .left
        datePurchaseLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return datePurchaseLabel
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let applyBillLabel: UILabel = {
        let applyBillLabel: UILabel = UILabel()
        applyBillLabel.text = "Выставить счета после сохранения покупки"
        applyBillLabel.numberOfLines = 2
        applyBillLabel.textAlignment = .left
        applyBillLabel.font = UIFont(name: "GTEestiProDisplay-Medium", size: 14)
        return applyBillLabel
    }()
    
    let billSwitch: UISwitch = {
        let billSwitch: UISwitch = UISwitch()
        return billSwitch
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutCollectionView()
        setView()
        setLayout()
        
        //let dataSource = ParticipantDataSource()
        participantCollectionView?.dataSource = self
        participantCollectionView?.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PurchaseViewController.selectEmoji))
        emojiSelectLabel.isUserInteractionEnabled = true
        emojiSelectLabel.addGestureRecognizer(tap)
    }
    
    @objc func selectEmoji(sender:UITapGestureRecognizer) {
        present(emojiPickerVC, animated: true, completion: nil)
        print("click")
    }
    
    
    func configureLayoutCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 50)
        
        participantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        participantCollectionView?.register(ParticipantCell.self, forCellWithReuseIdentifier: "ParticipantCell")
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
        
        // Row #6
        participantCollectionView?.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            participantCollectionView!.topAnchor.constraint(equalTo:  participantLabel.bottomAnchor, constant: 4),
            participantCollectionView!.widthAnchor.constraint(equalToConstant: view.frame.width),
            participantCollectionView!.heightAnchor.constraint(equalToConstant: view.frame.height/4),
            participantCollectionView!.leftAnchor.constraint(equalTo: rootView.leftAnchor)
           ])
        
        
        // Row #6
        addParticipantButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addParticipantButton.topAnchor.constraint(equalTo: participantCollectionView!.bottomAnchor,constant: 16),
            addParticipantButton.widthAnchor.constraint(equalToConstant: rootView.frame.width/3),
            addParticipantButton.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 12),
            addParticipantButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        equalSplitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equalSplitButton.topAnchor.constraint(equalTo: participantCollectionView!.bottomAnchor,constant: 16),
            equalSplitButton.widthAnchor.constraint(equalToConstant: rootView.frame.width/4),
            equalSplitButton.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -48),
            equalSplitButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        // Row #7
        datePurchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePurchaseLabel.widthAnchor.constraint(equalToConstant: contentWidth*0.7),
            datePurchaseLabel.heightAnchor.constraint(equalToConstant: 24),
            datePurchaseLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            datePurchaseLabel.topAnchor.constraint(equalTo: addParticipantButton.bottomAnchor, constant: 8)
        ])
        
        // Row #8
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            datePicker.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            datePicker.topAnchor.constraint(equalTo: datePurchaseLabel.bottomAnchor, constant: 4)
        ])
        
        // Row #9
        applyBillLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            applyBillLabel.widthAnchor.constraint(lessThanOrEqualToConstant: rootView.frame.width*0.8),
            applyBillLabel.heightAnchor.constraint(equalToConstant: 32),
            applyBillLabel.leftAnchor.constraint(equalTo:  rootView.leftAnchor, constant: 12),
            applyBillLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12)
        ])
        
        billSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            billSwitch.rightAnchor.constraint(equalTo:  rootView.rightAnchor, constant: -12),
            billSwitch.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12)
            ])
        
        
        
        
        // # Bottom
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoTextLabel.widthAnchor.constraint(equalToConstant: rootView.frame.width/1.2),
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
         datePurchaseLabel,
         datePicker,
         applyBillLabel,
         billSwitch,
         participantCollectionView!].forEach{view.addSubview($0)}

        // Установка цвета для label
        iconLabel.textColor = labelColor
        totalLabel.textColor = labelColor
        namePurchaseLabel.textColor = labelColor
        emojiSelectLabel.textColor = labelColor
        datePurchaseLabel.textColor = labelColor
        applyBillLabel.textColor = labelColor
        
        // Установка цвета для secondaryLabel
        infoTextLabel.textColor = secondaryLabelColor
        
        // Установка цвета для textField
        nameTextField.textColor = labelColor
        totalTextField.textColor = labelColor
        
        // Установка цветов для кнопок
        addParticipantButton.backgroundColor = greenColor
        equalSplitButton.backgroundColor = blueColor
        saveButton.backgroundColor = blueColor
        
        emojiPickerVC.delegate = self
        emojiPickerVC.size = CGSize(width: 300, height: 400)
        emojiPickerVC.dismissAfterSelected = true
    }


}



// TODO
extension PurchaseViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let participantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipantCell", for: indexPath) as? ParticipantCell else {
            return UICollectionViewCell()
        }
        return participantCell
    }
}

extension PurchaseViewController: EmojiPickerViewControllerDelegate{
    func emojiPickerViewController(_ controller: EmojiPickerViewController, didSelect emoji: String) {
        emojiSelectLabel.text = emoji
    }
}

