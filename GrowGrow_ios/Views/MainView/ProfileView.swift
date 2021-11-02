//
//  ProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Firebase
// import grpc


struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @StateObject private var viewModel = SessionStore()
    
    
    @State private var showEditProfileView = false
    @State private var showAddView = false
    @State private var showEditBioView = false
    @State var nativeAlert = false
    @State var keyword = ""
    // @State var keywords: [[Keyword]] = []
    let db = Firestore.firestore()
   
    
    
    func addKeyword(keyword:String){
        
        let keywordRef = db.collection("Users").document(self.session.session!.uid)
        
        if !keyword.isEmpty {
            keywordRef.updateData([
                "keywords" : FieldValue.arrayUnion([keyword])
            ])
            
            var inputString = keyword.lowercased()
            
            
            let trimmed = String(inputString.filter {!" \n\t\r".contains($0)})
            
            for word in trimmed.splitString() {
                
                keywordRef.updateData([
                    "keywords_search" : FieldValue.arrayUnion([word])
                ])
                
                
            }
            
            
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
    
    func deleteKeyword(keyword: String){
        
        let keywordRef = db.collection("Users").document(self.session.session!.uid)
        
        keywordRef.updateData([
            "keywords" : FieldValue.arrayRemove([keyword])
        ])
        
        keywordRef.updateData([
            "keywords_search" : FieldValue.delete()
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                
                keywordRef.addSnapshotListener{
                    
                    documentSnapshot, error in
                          guard let document = documentSnapshot else {
                            print("Error fetching document: \(error!)")
                            return
                          }
                          guard let data = document.data() else {
                            print("Document data was empty.")
                            return
                          }
                    
                    let keywords = data["keywords"] as? [String] ?? [""]
                    
                    for keyword in keywords {
                        var inputString = keyword.lowercased()
                        
                        let trimmed = String(inputString.filter {!" \n\t\r".contains($0)})
                        
                        for word in trimmed.splitString() {
                            
                            keywordRef.updateData([
                                "keywords_search" : FieldValue.arrayUnion([word])
                            ])
                            
                            
                        }
                        
                        
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
                
            }
        }
        
        
        
        
        
        
        
    }
    
   /* func getKeywords() {
        
        let userId = Auth.auth().currentUser!.uid
        
        keywords.removeAll()
        
        
        db.collection("Users").document(userId)
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
                
                let docKeywords = data["keywords"] as! [String]
                
                
                if keywords.isEmpty {
                    keywords.append([])
                }
                
               
            
                
                for keyword in docKeywords {
                    
                    keywords[keywords.count - 1].append(Keyword(keywordText: keyword))

                   
                }
        
                
                
            }
        
        
       
    } */
    
    
    var body: some View {
       
       VStack{
      
            
            Group {
                
                HStack{
                    
                    VStack{
                        
                        Text(viewModel.fullname)
                        Text("@\(viewModel.username)")
                    }
                    
                    Button(action: {showEditProfileView.toggle()}){
                        Image(systemName: "house")
                        
                    }.sheet(isPresented: $showEditProfileView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                    
                    
                }
                
                
                
            }
            
      
           ScrollView{
            Divider()

            HStack{
                Text(viewModel.depart)
                Text(viewModel.major)
                
                
            }
            Divider()
                
            Text(viewModel.summary)
            
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
                
               /* Button(action:{
                    
                    viewModel.getKeywords()
                    
                    
                }){
                    Image(systemName: "mic")
                    
                }
                */
                
            }
           
            
            VStack(alignment: .leading) {
                
                ForEach(viewModel.keywordsForChips, id: \.self){ subItems in
                    HStack{
                        ForEach(subItems, id:\.self){ word in
                            HStack(alignment: .center){
                            
                            Text(word)
                                //.padding()
                                .fixedSize()
                                .background(Color.gray)
                                .lineLimit(1)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                
                                Image(systemName: "trash")
                                        .onTapGesture {
                                           deleteKeyword(keyword: word)
                                        }
                            }.background(Color.blue)
                        }
                        
                    }
                    
                }
                
            }.onAppear(){
                self.viewModel.getKeywords(uid: Auth.auth().currentUser!.uid)
            }
            
           Group{
                Divider()
                    .background(Color.black)
                    .frame(height: 30)
                    
               HStack{
                   
                   Text("Footprint").font(.largeTitle)
                   Button(action: {showEditBioView.toggle()}){
                       
                       Image(systemName: "pencil.circle")
                       
                   }.sheet(isPresented: $showEditBioView, content: {EditBioView()})
                       
                   
                   
               }
                
                    
                
       }
            

            
            
                
                LazyVStack(alignment: .center){
                     
                     ForEach(viewModel.bios){bio in
                         VStack{
                             
                             BioView(date: bio.date, description: bio.description)
                         }
                         
                         
                     }
                 }.onAppear(){
                     self.viewModel.getBios(uid: Auth.auth().currentUser!.uid)
                 }
                
                
                
            }
            
         
            
        }
        .onAppear(){
            self.viewModel.getCurrentUser()
            
        }
        
        /* VStack(alignment:.leading){
            
            HStack{
                
                VStack{
                    
                    Text(viewModel.fullname)
                    Text("@\(viewModel.username)")
                }
                
                Button(action: {showEditView.toggle()}){
                    Image(systemName: "house")
                    
                }.sheet(isPresented: $showEditView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                
                
            }
    
            List{
                
                Divider()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: -20 , leading: 0, bottom: -20, trailing: 0))
                    
                
                HStack{
                    Text(viewModel.depart)
                    Text(viewModel.major)
                    Spacer()
                        
                    
                    
                }.listRowSeparator(.hidden)
                
                
                
                Divider()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: -20 , leading: 0, bottom: -20, trailing: 0))
                    
                Text(viewModel.summary)
                    .listRowSeparator(.hidden)
                   
                    
                
                Divider()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: -20 , leading: 0, bottom: -20, trailing: 0))
                
                HStack{
                    
                  
                    
                    Button(action: {showAddView.toggle()}){
                        Image(systemName: "folder.badge.plus")
                        
                    }.sheet(isPresented: $showAddView, content: {AddProfileView()})
                    
                    Button(action:{
                        alertView()
                    }){
                        Image(systemName: "plus.rectangle.on.rectangle")
                        
                    }
                    
                   /* Button(action:{
                        
                        viewModel.getKeywords()
                        
                        
                    }){
                        Image(systemName: "mic")
                        
                    }
                    */
                    
                }
                .listRowSeparator(.hidden)
                
                VStack(alignment: .leading) {
                    
                    ForEach(viewModel.keywordsForChips, id: \.self){ subItems in
                        HStack{
                            ForEach(subItems, id:\.self){ word in
                                HStack(alignment: .center){
                                
                                Text(word)
                                    //.padding()
                                    .fixedSize()
                                    .background(Color.gray)
                                    .lineLimit(1)
                                    .foregroundColor(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    
                                    Image(systemName: "trash")
                                            .onTapGesture {
                                                print(word)
                                            }
                                }.background(Color.blue)
                            }
                            
                        }
                        
                    }
                    
                }.onAppear(){
                    self.viewModel.getKeywords(uid: Auth.auth().currentUser!.uid)
                }
                
                Divider()
                    .background(Color.black)
                    .frame(height: 30)
                    .listRowSeparator(.hidden)
               
                Text("Footprint").font(.largeTitle)
                    .listRowSeparator(.hidden)
                    .modifier(CenterModifier())
                
                
                ForEach(viewModel.bios){bio in
                    
                        
    
                    
                        BioView(date: bio.date, description: bio.description)
                        .listRowSeparator(.hidden)
                        .swipeActions{
                            
                            Button(role: .destructive, action: {}, label: {Label("삭제",systemImage: "trash.circle.fill")})
                            
                            
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button(action: {}, label: {Label("수정",systemImage: "pencil.circle.fill")})
                                .tint(.blue)
                            
                            
                        }
                        
                        
                    
                    
                        
                }
                
                
            }
            .listStyle(PlainListStyle())
            .onAppear(){
                self.viewModel.getBios(uid: Auth.auth().currentUser!.uid)
                self.viewModel.getCurrentUser()
            }
     Spacer()
        } */
        // .frame(maxWidth:.infinity,maxHeight: .infinity)
        
        
      
    
        
    
       
    }
    
    func alertView(){
        
        let alert = UIAlertController(title: "키워드 추가", message: "키워드", preferredStyle: .alert)
        
        alert.addTextField{ (pass) in
            
            pass.placeholder = "키워드"
            
        }
        
        let add = UIAlertAction(title: "추가", style: .default) { (_) in
            
            keyword = alert.textFields![0].text!
            self.addKeyword(keyword: keyword)
            
            
            
            
            
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


