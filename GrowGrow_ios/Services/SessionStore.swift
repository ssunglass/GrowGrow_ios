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

class SessionStore: ObservableObject {
    
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

