//
//  SessionStore.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SessionStore: ObservableObject {
    
    @Published var users = [AllUsers]()
    
    private var db = Firestore.firestore()
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            
            if let user = user {
                
                let currentUserId = AuthService.getUserId(userId: user.uid)
                currentUserId.getDocument{
                    (document, error ) in
                    if let dict = document?.data(){
                        guard let decodeUser = try? User.init(fromDictionary: dict) else {return}
                        self.session = decodeUser
                    }
                }
            }
            else {
                self.session = nil
            }
            
            
            
        })
    }
    
   
    
    func getUsers(){
        db.collection("Users").addSnapshotListener{ (querySnapshot, error ) in
            guard let documents = querySnapshot?.documents else {return}
            
            self.users = documents.map { (queryDocumentSnapshot) -> AllUsers in
                let data = queryDocumentSnapshot.data()
                let fullname = data["fullname"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let depart = data["depart"] as? String ?? ""
                let major = data["major"] as? String ?? ""
                let summary = data["summary"] as? String ?? ""
            
                
                
                return AllUsers(fullname: fullname, username: username, summary: summary, depart: depart, major: major)
                
            }
            
        }
        
        
    }
    
    
    func logout(){
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
    
    
    
        
    
    
}

