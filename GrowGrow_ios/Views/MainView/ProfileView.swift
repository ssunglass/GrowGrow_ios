//
//  ProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI
import FirebaseFirestore


struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @State private var showEditView = false
    @State private var showAddView = false
    @State var nativeAlert = false
    @State var keyword = ""
    
    
    func addKeyword(keyword:String){
        
        
        
        let keywordRef = Firestore.firestore().collection("Users").document(self.session.session!.uid)
        
    
        
        if !keyword.isEmpty {
            
            
            keywordRef.updateData([
                "keywords" : FieldValue.arrayUnion([keyword])
            ])
            
            var inputString = keyword
            let words = inputString.components(separatedBy: " ")
            
            for word in words {
                
                
                for separated in inputString.splitString() {
                    
                    keywordRef.updateData([
                        "keywords_search" : FieldValue.arrayUnion([separated])
                    ])
                    
                    
                }
                
               
                
                inputString = inputString.replacingOccurrences(of: "\(word) ", with: "")
                
            }
            
            
        }
        
       
        
        
        
    }
    
    
    var body: some View {
        
        VStack {
            
            Group {
                
                HStack{
                    
                    VStack{
                        
                        Text(self.session.session!.fullname)
                        Text(self.session.session!.username)
                    }
                    
                    Button(action: {showEditView.toggle()}){
                        Image(systemName: "house")
                        
                    }.sheet(isPresented: $showEditView, content: {EditProfileView(initfullname: self.session.session!.fullname, initusername: self.session.session!.username, initsummary: self.session.session!.summary)})
                    
                    
                }
                
                
                
            }
            Divider()

            HStack{
                
            
                
                Text(self.session.session!.depart)
                Text(self.session.session!.major)
                
                
            }
            Divider()
                
                Text(self.session.session!.summary)
            
            Divider()
            
            HStack{
                
                Button(action: {showAddView.toggle()}){
                    Image(systemName: "folder.badge.plus")
                    
                }.sheet(isPresented: $showAddView, content: {AddProfileView()})
                
                Button(action:{
                    alertView()
                }){
                    Image(systemName: "plus.rectangle.on.rectangle")
                    
                }
                
                
            }
                
          
                
            
            
            
        }
        
    
       
    }
    
    func alertView(){
        
        let alert = UIAlertController(title: "키워드 추가", message: "키워드", preferredStyle: .alert)
        
        alert.addTextField{ (pass) in
            
            pass.placeholder = "키워드"
            
        }
        
        let add = UIAlertAction(title: "추가", style: .default) { (_) in
            
            keyword = alert.textFields![0].text!
            addKeyword(keyword: keyword)
            
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive) { (_) in
            
            
        }
        alert.addAction(cancel)
        alert.addAction(add)
        
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
        
        
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

