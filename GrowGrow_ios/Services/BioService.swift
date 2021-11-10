//
//  BioService.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/28.
//

import Firebase
import FirebaseAuth
import Foundation
import FirebaseFirestore

class BioService {
    
    static let db = Firestore.firestore()
    
    
    static func saveBio( date:String, description:String, onSuccess: @escaping (_ bio: Bio) -> Void, onError: @escaping(_ errorMessage: String) -> Void ){
        
        
        let userId = Auth.auth().currentUser!.uid
        let bioRef = db.collection("Users").document(userId).collection("Bios").document(date)
        let bio = Bio.init(date: date, description: description)
        
      
        
        guard let dict = try?bio.asDictionary() else {return}
        
        bioRef.setData(dict){
            (error) in
            
            if error != nil {
                onError(error!.localizedDescription)
            }
            
            
            
        }
        onSuccess(bio)
    }
    
    
  
    
    
    
    
    
    
}
