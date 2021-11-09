//
//  AuthService.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import Firebase
import FirebaseAuth
import Foundation
import FirebaseFirestore

class AuthService {
    
    static let db = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return db.collection("Users").document(userId)
    }
    
    static func signUp(fullname:String, username:String, email:String, password:String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authResult?.user.uid else {
                return
            }
            
            AuthService.saveUserInfo(userId: userId, fullname: fullname, username: username, email: email, onSuccess: onSuccess, onError: onError)
            
        
            
            
            
            
        }
        
        
    }
    
    static func saveUserInfo(userId:String,fullname:String,username:String,email:String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void ){
        
        let currentUserId = AuthService.getUserId(userId: userId)
        let user = User.init(fullname: fullname, username: username, uid: userId, summary: "한줄요약", depart: "", major: "전공", region: "지역", departIcon: "person.fill.questionmark")
        
        guard let dict = try?user.asDictionary() else {return}
        
        currentUserId.setData(dict){
            (error) in
            
            if error != nil {
                onError(error!.localizedDescription)
            } else {
                
                Auth.auth().currentUser?.sendEmailVerification{ error in
                    
                    if error != nil {
                        onError(error!.localizedDescription)
                    }
                    
                }
                
                
            }
            
            
            
        }
        onSuccess(user)
    }
    
    static func signIn(email:String, password:String, onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else {return}
            
            let currentUserId = getUserId(userId: userId)
            
            currentUserId.getDocument{ (document, error) in
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                    
                    onSuccess(decodedUser)
                }
            }
            
        }
    }
    
    
    
    
    
}
