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
    
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicLight: String = "Apple SD Gothic Neo Light"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    @State private var showEditProfileView = false
    @State private var showAddView = false
    @State private var showEditBioView = false
    @State var nativeAlert = false
    @State var keyword = ""
    // @State var keywords: [[Keyword]] = []
    let db = Firestore.firestore()
    
    @State var randomTextBase: Color = Color.black
    @State var random: Color = Color(hex: "#E5E5E5")
    
    let colors = [Color(hex: "#E5E5E5"),
                  Color(hex: "#C5C5C5"),
                  Color(hex: "#646464")]
   
    
    
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
       
        NavigationView{
        
            VStack(alignment: .leading){
      
            
            Group {
                
                HStack{
                    
                    VStack(alignment: .leading){
                        
                        Text(viewModel.fullname)
                            .font(.custom(appleGothicBold, size: 36))
                            .foregroundColor(Color.black)
                        
                        Text("@\(viewModel.username)")
                            .font(.custom(appleGothicLight, size: 14))
                            .foregroundColor(Color.black)
                        
                        
                    }
                    
                    Button(action: {showEditProfileView.toggle()}){
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .resizable()
                            .frame(width:23, height: 20)
                        
                    }.sheet(isPresented: $showEditProfileView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                    
                    Button(action:{
                        alertView()
                    }){
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .resizable()
                            .frame(width:23, height: 20)
                        
                    }
                    
                    
                    NavigationLink(destination: SavedUserListView()){
                        Image(systemName: "bookmark.square.fill")
                            .resizable()
                            .frame(width:23, height: 20)
                        
                    }
                    
                  
                    
                    
                }
                
                
                
            }.padding([.bottom])
            
      
                ScrollView(.vertical){
           
                   

               LazyVStack(alignment: .leading){
                
                
                 Divider()
                    .frame(width: 210)
                    .background(Color(hex: "#CBCBCB"))
                
                
            HStack{
            Text("\(viewModel.depart)계열")
                    .font(.custom(appleGothicBold, size: 18))
                    .foregroundColor(Color(hex: "#A7A7A7"))
            Text(viewModel.major)
                    .font(.custom(appleGothicBold, size: 18))
                    .foregroundColor(Color(hex: "#A7A7A7"))
            
            
            }.padding([.bottom])
                
                
            
                    
            Divider()
                    .frame(width: 210)
                    .background(Color(hex: "#CBCBCB"))
             
                
        Text(viewModel.summary)
                       .font(.custom(appleGothicMed, size: 18))
                       .foregroundColor(Color.black)
                       .tracking(-1.5)
                
            
        
                
                
               }.padding([.bottom])
           
    
            
                    LazyVStack(alignment: .leading) {
                        
                        Divider()
                           .frame(width: 210)
                           .background(Color(hex: "#CBCBCB"))
                
                
                
                ForEach(viewModel.keywordsForChips, id: \.self){ subItems in
                    HStack(spacing: 10){
                        ForEach(subItems, id:\.self){ word in
                            
                            ChipView(chipText: word)
    
                            
                           /* HStack(alignment: .center, spacing: 2){
                            
                            Text(word)
                                
                                .fixedSize()
                                .font(.custom(appleGothicMed, size: 16))
                                //.background(Color.gray)
                                .lineLimit(1)
                                .foregroundColor(randomTextBase)
                                //.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                
                                Image(systemName: "minus.circle")
                                        .onTapGesture {
                                           deleteKeyword(keyword: word)
                                        }
                            }
                            
                            
                            .onAppear(){
                           
                                
                                if colors.randomElement()! == Color(hex: "#646464") {
                                    
                                    randomTextBase = Color.white
                                    
                                    
                                } else {
                                    randomTextBase = Color.black
                                }
                            }
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .padding(.top, 2)
                            .padding(.bottom,1.5 )
                            .background(colors.randomElement()!)
                             .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous)) */
                            
                                
                        }
                        
                    }
                    
                }
                
            }.onAppear(){
                self.viewModel.getKeywords(uid: Auth.auth().currentUser!.uid)
                
              
            }
            
                    LazyVStack(spacing: 13){
               
                Divider()
                   .frame(width: 35,height: 6)
                   .background(Color.black)
                    
               HStack{
            
                   Button(action: {showAddView.toggle()}){
                       Image(systemName: "folder.badge.plus")
                       
                   }.sheet(isPresented: $showAddView, content: {AddBioView()})
                   
                   Text("Footprint")
                       .font(.custom(appleGothicBold, size: 36))
                       .foregroundColor(Color.black)
                       .tracking(-1.5)
                   
                 
                   
                   
                   Button(action: {showEditBioView.toggle()}){
                       
                       Image(systemName: "pencil.circle")
                       
                   }.sheet(isPresented: $showEditBioView, content: {EditBioView()})
                       
                   
                   
               }
                
                    
                
       }
           .padding(.top,60)
            

            
            
                
                LazyVStack(){
                     
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
            self.viewModel.getUserDoc(uid: self.session.session!.uid)
            
        }
        .padding(.leading,20)
        .padding([.trailing,.top,.bottom])
        .navigationBarHidden(true)
        }
        
        
        
        
      
    
        
    
       
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

struct ChipView: View {
    var chipText: String
    
    @EnvironmentObject var session: SessionStore
    @State var randomTextBase: Color = Color.black
    @State var random: Color = Color(hex: "#E5E5E5")
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    let colors = [Color(hex: "#E5E5E5"),
                  Color(hex: "#C5C5C5"),
                  Color(hex: "#646464")]
    
    let db = Firestore.firestore()
    
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
    
    var body: some View{
        
        
        HStack(alignment: .center, spacing: 5){
        
        Text(chipText)
            
            .fixedSize()
            .font(.custom(appleGothicMed, size: 16))
            //.background(Color.gray)
            .lineLimit(1)
            .foregroundColor(randomTextBase)
            //.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            Image(systemName: "minus.circle")
                    .onTapGesture {
                        self.deleteKeyword(keyword: chipText)
                       //deleteKeyword(keyword: word)
                    }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .padding(.top, 2)
        .padding(.bottom,1.5 )
        .background(random)
         .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
         .onAppear(){
        
             random = colors.randomElement()!
             
             if random == Color(hex: "#646464") {
                 
                 randomTextBase = Color.white
                 
                 
             } else {
                 randomTextBase = Color.black
             }
         }
        
        
    }
    
    
    
    
    
    
    
}



