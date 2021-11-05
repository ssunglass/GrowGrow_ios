//
//  UserDetailView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/31.
//

import SwiftUI
import FirebaseFirestore

struct UserDetailView: View {
    
     var uid: String
    @StateObject private var viewModel = SessionStore()
    @EnvironmentObject var session: SessionStore
    @State var isSaved: Bool = false
    @State var isCurrentUser: Bool = false
    
    
    
    func currentUserCheck(){
        
        if self.session.session!.uid == uid {
            
            self.isCurrentUser = true
            
            
        }
        
        
        
        
        
    }
    
    func saveUser(){
        
        if !isSaved {
            self.isSaved.toggle()
            self.viewModel.saveUser(saveUid: uid)
            
            
            
        } else {
            self.isSaved.toggle()
            self.viewModel.unSaveUser(saveUid: uid)
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    func savedUserCheck(){
        
        Firestore.firestore().collection("Users")
            .document(self.session.session!.uid)
            .collection("SavedUsers")
            .document(uid).getDocument {(document, error) in
                
                if document!.exists {
                    
                    self.isSaved = true
                    
                    
                    
                }
                
                
                
            }
        
        
        
        
        
    }
    
    
    var body: some View {
        VStack{
            
            
            Group {
                
                HStack{
                    
                    VStack{
                        
                        Text(viewModel.fullname)
                        Text("@\(viewModel.username)")
                    }
                    
                    if !isCurrentUser {Button(action: {
                        
                        saveUser()
                        
                    }){
                        Image(systemName: "bookmark.square.fill")
                            //.tint(Color.gray)
                            .foregroundColor( isSaved ? Color.yellow : Color.gray)
                        
                    }
                    
                    }
                    
                }
                
                
                
            }
        }.onAppear(){
            self.currentUserCheck()
            self.savedUserCheck()
            self.viewModel.getUserDoc(uid: uid)
            
            
        }
    }
}


