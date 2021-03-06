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
    @EnvironmentObject private var contentViewModel : ContentViewModel
    
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicLight: String = "Apple SD Gothic Neo Light"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    @State private var showEditProfileView = false
    @State private var showAddView = false
    @State private var showEditBioView = false
    @State private var showingAlert = false
    @State var nativeAlert = false
    @State var keyword = ""
    @State private var isBookActive = false
    @State private var isPdfPreviewActive = false
    @State private var isSettingActive = false
    @State private var keywordCount : Int = 0
    // @State var keywords: [[Keyword]] = []
    let db = Firestore.firestore()
    
    @State var randomTextBase: Color = Color.black
    @State var random: Color = Color(hex: "#E5E5E5")
    
    let colors = [Color(hex: "#E5E5E5"),
                  Color(hex: "#C5C5C5"),
                  Color(hex: "#646464")]
   
    
    
    func addKeyword(keyword:String){
        
        let keywordRef = db.collection("Users").document(self.session.session!.uid)
        
        keywordRef.addSnapshotListener { (documentSnapshot, error) in
            
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            
            let keywords = data["keywords"] as? [String] ?? [""]
            
            self.keywordCount = keywords.count
            
        }
        
        
        
    
        
        if !keyword.isEmpty && keywordCount < 10 {
            keywordRef.updateData([
                "keywords" : FieldValue.arrayUnion([keyword])
            ])
            
            var inputString = keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            
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
            
            
        } else {
            
            
            print("Can't add keyword anymore")
            
            
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
      
            
          /*  Group {
                
                HStack{
                    
                    VStack(alignment: .leading){
                        
                        Text(viewModel.fullname)
                            .font(.custom(appleGothicBold, size: 36))
                            .foregroundColor(Color.black)
                        
                        Text("@\(viewModel.username)")
                            .font(.custom(appleGothicLight, size: 14))
                            .foregroundColor(Color.black)
                        
                        
                    }
                    
                    Image(systemName: "person.crop.circle.badge.questionmark.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:23, height: 20)
                        .onTapGesture {
                            showEditProfileView.toggle()
                        }
                        .sheet(isPresented: $showEditProfileView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                    
                  /*  Button(action: {showEditProfileView.toggle()}){
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .resizable()
                            .frame(width:23, height: 20)
                           
                        
                    }
                    
                    .sheet(isPresented: $showEditProfileView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                    */
                  
                    
                    Image(systemName: "plus.rectangle.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width:23, height: 20)
                        .onTapGesture {
                            alertView()
                        }
                
                    
                    /*Button(action:{
                        alertView()
                    }){
                        Image(systemName: "plus.rectangle.on.rectangle")
                            .resizable()
                            .frame(width:23, height: 20)
                            
                        
                    }*/
                    
                    Image(systemName: "bookmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:23, height: 20)
                        .onTapGesture {
                            isBookActive.toggle()
                        }
                    
                    Spacer()
                   
                    
                    Image(systemName: "link")
                        .resizable()
                        .scaledToFit()
                        .frame(width:23, height: 20)
                        .onTapGesture {
                            isPdfPreviewActive.toggle()
                            contentViewModel.fullname = viewModel.fullname
                            contentViewModel.depart = "\(viewModel.depart), \(viewModel.major) 재학"
                            contentViewModel.summary = viewModel.summary
                            
                            contentViewModel.bios = viewModel.bios
                           
                        }
                        //.padding(.leading, 15)
                    
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width:23, height: 20)
                        .onTapGesture {
                            
                         isSettingActive.toggle()
                            
                          /*  DispatchQueue.main.async {
                               // session.unbind()
                                session.logout()
                               
                            } */
                            
                        }
                       // .padding(.trailing,15)
                    
                    
                      
                    
               
                    
                    
                 
                    
                    
                    
                    NavigationLink(destination: SavedUserListView(),isActive: $isBookActive){
                    
                        
                    }.hidden()
                    
                    NavigationLink(destination: PdfPreviewView(), isActive: $isPdfPreviewActive){
                        
                    }.hidden()
                    
                    NavigationLink(destination: SettingView(), isActive: $isSettingActive){
                        
                    }.hidden()
                    
                    
                  
                    
                    
                }
                
                
                
            }.padding([.bottom]) */
            
                HStack(){
                 
                    VStack(alignment: .leading, spacing: 5){
                        
                        HStack{
                        
                        Text(viewModel.fullname)
                            .font(.custom(appleGothicBold, size: 40))
                            .foregroundColor(Color.black)
                            .fixedSize()
                            
                            if viewModel.isVerified {
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(Color.yellow)
                                
                                
                            }
                        
                        }
                        
                        Text("@\(viewModel.username)")
                            .font(.custom(appleGothicLight, size: 15))
                            .foregroundColor(Color.black)
                            .kerning(-0.5)
                            .fixedSize()
                        
                        
                    }
                    
                   
                    
                    
                    Button(action: {showEditProfileView.toggle()} ){
                        Image(systemName: "person.crop.rectangle.stack")
                             .resizable()
                             .scaledToFit()
                             .frame(width:23, height: 20)
                        
                        
                    }.sheet(isPresented: $showEditProfileView, content: {EditProfileView(initfullname: viewModel.fullname, initusername: viewModel.username, initsummary: viewModel.summary)})
                  
                    
          
                    Button(action: {
                        
                        if keywordCount < 10 {
                        
                        alertView()
                            
                        } else {
                            
                            showingAlert.toggle()
                            
                        }
                        }) {
                        
                        Image(systemName: "rectangle.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width:23, height: 20)
                            .padding(.top,5)
                        
                        
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text("커커"), message: Text("키워드를 더이상 입력할 수 없습니다."), dismissButton: .default(Text("확인")) {

                            
                        })
                    }
                    
                
                
                    
                    Button(action: { isBookActive.toggle()} ) {
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width:23, height: 20)
                        
                    }
                    
                
                        
                    Spacer()
                    
                    
                    NavigationLink(destination: SavedUserListView(),isActive: $isBookActive){
                    
                        
                    }.hidden()
                    
                    NavigationLink(destination: PdfPreviewView(), isActive: $isPdfPreviewActive){
                        
                    }.hidden()
                    
                    NavigationLink(destination: SettingView(), isActive: $isSettingActive){
                        
                    }.hidden()
                    
                    
                   
                    Button(action: {
                        isPdfPreviewActive.toggle()
                        contentViewModel.fullname = viewModel.fullname
                        contentViewModel.depart = "\(viewModel.depart), \(viewModel.major) 재학"
                        contentViewModel.summary = viewModel.summary
                        
                        contentViewModel.bios = viewModel.bios
                    }){
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width:23, height: 20)
                        
                    }.padding(.trailing,3)
                    
                    Button(action: {   isSettingActive.toggle()}){
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width:23, height: 20)
                        
                    }.padding(.trailing,15)
                    
               

                    
                  
                    
                    
                }
      
                ScrollView(.vertical){
           
                   

               LazyVStack(alignment: .leading){
                
                
                 Divider()
                    .frame(width: 210)
                    .background(Color(hex: "#CBCBCB"))
                
                
            HStack{
            Text("\(viewModel.depart)계열")
                    .kerning(-1)
                    .font(.custom(appleGothicBold, size: 18))
                    .foregroundColor(Color(hex: "#A7A7A7"))
            Text(viewModel.major)
                    .kerning(-1)
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
                       .padding([.trailing])
                
            
        
                
                
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
                
            }
                    
                    .onAppear(){
                        self.viewModel.getKeywords(uid: Auth.auth().currentUser?.uid ?? "uid")
                
              
            }
            
                    LazyVStack(spacing: 13){
               
                Divider()
                   .frame(width: 35,height: 6)
                   .background(Color.black)
                    
                        HStack(spacing: 15){
                   
                  Label("plus",systemImage: "note.text.badge.plus")
                       .labelStyle(IconOnlyLabelStyle())
                       .onTapGesture {
                           showAddView.toggle()
                       }.sheet(isPresented: $showAddView, content: {AddBioView()})
            
                 /*  Button(action: {showAddView.toggle()}){
                       Image(systemName: "folder.badge.plus")
                       
                   }.sheet(isPresented: $showAddView, content: {AddBioView()}) */
                   
                   Text("Footprint")
                       .font(.custom(appleGothicBold, size: 36))
                       .foregroundColor(Color.black)
                       .tracking(-1.5)
                   
                 Label("edit", systemImage: "pencil")
                       .labelStyle(IconOnlyLabelStyle())
                       .onTapGesture {
                           showEditBioView.toggle()
                       }.sheet(isPresented: $showEditBioView, content: {EditBioView()})
                   
                   
                 /*  Button(action: {showEditBioView.toggle()}){
                       
                       Image(systemName: "pencil.circle")
                       
                   }.sheet(isPresented: $showEditBioView, content: {EditBioView()})
                       
                   */
                   
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
                     self.viewModel.getBios(uid: Auth.auth().currentUser?.uid ?? "uid" )
                 }
                
                
                
           }
            
         
            
        }
        .onAppear(){
            self.viewModel.getUserDoc(uid: self.session.session!.uid)
            
        }
        .padding(.leading,20)
        .padding(.top,25)
        .padding([.trailing,.bottom])
        .navigationBarHidden(true)
        .navigationTitle("프로필")
        }
        
        
        
        
      
    
        
    
       
    }
    
    func alertView(){
        
        let alert = UIAlertController(title: "키워드 추가", message: "자신만의 키워드를 추가해보세요!", preferredStyle: .alert)
        
        alert.addTextField{ (pass) in
            
            pass.placeholder = "키워드"
            
        }
        
        let add = UIAlertAction(title: "추가", style: .default) { (_) in
            
            keyword = alert.textFields![0].text!
            self.addKeyword(keyword: keyword)
            
            
            
            
            
        }
        
       
        
        let cancel = UIAlertAction(title: "닫기", style: .destructive) { (_) in
            
            
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
        
        
        HStack(alignment: .center, spacing: 6){
        
        Text(chipText)
            .kerning(-1)
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
        .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 3, x: 0, y: 3)
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



