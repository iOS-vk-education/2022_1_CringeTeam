//
//  ParticipantDataSource.swift
//  SharePay
//
//  Created by Pudovkin Dmitriy Olegovich on 09.04.2022.
//

import Foundation
import UIKit


final class ParticipantDataSource: NSObject, UICollectionViewDataSource{
    
    
   // TODO добавить данные и конструктор
    
    override init(){
        super.init()
    }
    
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
