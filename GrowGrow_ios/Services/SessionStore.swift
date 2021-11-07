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
import SwiftUI

class SessionStore: ObservableObject {
    
    @Published var users = [AllUsers]()
    @Published var bios = [AllBios]()
  //  @Published var keywords = [String]()
    @Published var keywordsForChips = [[String]]()
    @Published var searchedUsers = [AllUsers]()
    @Published var savedUsers = [AllUsers]()
    
    @Published var fullname: String = ""
    @Published var username: String = ""
    @Published var depart: String = ""
    @Published var major: String = ""
    @Published var summary: String = ""
    @Published var region: String = ""
    @Published var uid: String = ""
    
    
    private let db = Firestore.firestore()
    // private let currentUser = Auth.auth().currentUser!.uid
    
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
                let uid = data["uid"] as? String ?? ""
                let region = data["region"] as? String ?? ""
                
                
                
                
            
                
                
                return AllUsers(fullname: fullname, username: username, uid: uid ,summary: summary, depart: depart, major: major,region: region)
                
            }
            
        }
        
        
    }
    
    func getSavedUsers(){
        db.collection("Users")
            .document(Auth.auth().currentUser!.uid)
            .collection("SavedUsers")
            .addSnapshotListener{ (querySnapshot, error ) in
                
            guard let documents = querySnapshot?.documents else {return}
            
            self.savedUsers = documents.map { (queryDocumentSnapshot) -> AllUsers in
                let data = queryDocumentSnapshot.data()
                let fullname = data["fullname"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let depart = data["depart"] as? String ?? ""
                let major = data["major"] as? String ?? ""
                let summary = data["summary"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let region = data["region"] as? String ?? ""
            
                
                
                return AllUsers(fullname: fullname, username: username, uid: uid ,summary: summary, depart: depart, major: major,region: region)
                
            }
            
        }
        
        
    }
    
    
    
    
    func getSearchedUser(keyword:String, depart:[String], region:String){
        
        @State var query: Query
        
        if depart.isEmpty && region == "" {
            
          query = db.collection("Users").whereField("keywords_search", arrayContains: keyword)
            
        } else if !depart.isEmpty && region == "" {
            
            query =  db.collection("Users")
                .whereField("keywords_search", arrayContains: keyword)
                .whereField("depart", in: depart)
            
        } else if depart.isEmpty && region != "" {
            
            query =  db.collection("Users")
                .whereField("keywords_search", arrayContains: keyword)
                .whereField("region", isEqualTo: region)
            
        } else {
            
            query =  db.collection("Users")
                .whereField("keywords_search", arrayContains: keyword)
                .whereField("depart", in: depart)
                .whereField("region", isEqualTo: region)
    
        }
        
        print(query)
        
        query.addSnapshotListener{ (querySnapshot, error ) in
            guard let documents = querySnapshot?.documents else {return}
            
            self.searchedUsers = documents.map { (queryDocumentSnapshot) -> AllUsers in
                let data = queryDocumentSnapshot.data()
                let fullname = data["fullname"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let depart = data["depart"] as? String ?? ""
                let major = data["major"] as? String ?? ""
                let summary = data["summary"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let region = data["region"] as? String ?? ""
            
                
                
                return AllUsers(fullname: fullname, username: username, uid: uid ,summary: summary, depart: depart, major: major,region: region)
                
            }
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    func saveUser(saveUid:String){
        
        
        db.collection("Users").document(saveUid)
            .addSnapshotListener{ (documentSnapshot, error) in
                
                guard let document = documentSnapshot else {
                  print("Error fetching document: \(error!)")
                  return
                }
                guard let data = document.data() else {
                  print("Document data was empty.")
                  return
                }
                
                let savedFullname = data["fullname"] as? String ?? ""
                let savedUsername = data["username"] as? String ?? ""
                let savedDepart = data["depart"] as? String ?? ""
                let savedMajor = data["major"] as? String ?? ""
                let savedSummary = data["summary"] as? String ?? ""
                let savedRegion = data["region"] as? String ?? ""
                
                let savedUser = User.init(fullname: savedFullname, username: savedUsername, uid: saveUid, summary: savedSummary, depart: savedDepart, major: savedMajor, region: savedRegion)
                
                
                guard let dict = try?savedUser.asDictionary() else {return}
                
                
                self.db.collection("Users")
                    .document(Auth.auth().currentUser!.uid)
                    .collection("SavedUsers")
                    .document(saveUid)
                    .setData(dict)
            
            }
        
        
        
        
      
        
        
        
        
    }
    
    func unSaveUser(saveUid:String){
        
        db.collection("Users")
            .document(Auth.auth().currentUser!.uid)
            .collection("SavedUsers")
            .document(saveUid)
            .delete()
        
        
        
        
        
        
    }
    
    func getUserDoc(uid:String){
        
        db.collection("Users").document(uid)
            .addSnapshotListener{ (documentSnapshot, error) in
                
                guard let document = documentSnapshot else {
                  print("Error fetching document: \(error!)")
                  return
                }
                guard let data = document.data() else {
                  print("Document data was empty.")
                  return
                }
                
                self.fullname = data["fullname"] as? String ?? ""
                self.username = data["username"] as? String ?? ""
                self.depart = data["depart"] as? String ?? ""
                self.major = data["major"] as? String ?? ""
                self.summary = data["summary"] as? String ?? ""
                self.region = data["region"] as? String ?? ""
            
        }
        
    }
    
    func getKeywords(uid:String){
        
        db.collection("Users").document(uid)
            .addSnapshotListener{ documentSnapshot, error in
                  guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                  }
                  guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                  }
                 
                let keywords = data["keywords"] as? [String] ?? [""]
                
                var tempItems: [String] = [String]()
                var width: CGFloat = 0
                var groupedItems: [[String]] = [[String]]()
                
               // self.keywords = keywords
              //  self.keywordsForChips = [keywords]
                
                for keyword in keywords {
                    let label = UILabel()
                    label.text = keyword
                    label.sizeToFit()
                    
                    let labelWidth = label.frame.size.width + 42
                    
                    if (width + labelWidth + 55 ) < UIScreen.main.bounds.width {
                        width += labelWidth
                        tempItems.append(keyword)
                        
                        
                    } else {
                        width = labelWidth
                        groupedItems.append(tempItems)
                        tempItems.removeAll()
                        tempItems.append(keyword)
                        
                    }
                }
                
                groupedItems.append(tempItems)
                self.keywordsForChips = groupedItems
    
            
        }
        
    }
    
    func getBios(uid:String){
        
        db.collection("Users").document(uid).collection("Bios").order(by: "date")
            .addSnapshotListener { (querySnapshot, error ) in
                
            guard let documents = querySnapshot?.documents else {return}
            
                
            self.bios = documents.map { (queryDocumentSnapshot) -> AllBios in
                let data = queryDocumentSnapshot.data()
                let date = data["date"] as? String ?? ""
                let description = data["description"] as? String ?? ""
              
            
                
                
                return AllBios(date: date, description: description)
                
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

