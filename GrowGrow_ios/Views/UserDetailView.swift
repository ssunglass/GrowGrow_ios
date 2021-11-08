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
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicLight: String = "Apple SD Gothic Neo Light"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    
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
                    
                    if !isCurrentUser {Button(action: {
                        
                        saveUser()
                        
                    }){
                        Image(systemName: "bookmark.square.fill")
                            .resizable()
                            .foregroundColor( isSaved ? Color.yellow : Color.gray)
                            .frame(width: 20, height: 20)
                        
                    }
                    
                    
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
                 
             
         
                 
                 
                }
                    .padding([.bottom])
                
                LazyVStack(alignment: .leading) {
                    
                    Divider()
                       .frame(width: 210)
                       .background(Color(hex: "#CBCBCB"))
            
            
            
            ForEach(viewModel.keywordsForChips, id: \.self){ subItems in
                HStack(spacing: 10){
                    ForEach(subItems, id:\.self){ word in
                        
                        detailChipView(chipText: word)

                        
                    
                        
                        
                            
                    }
                    
                }
                
            }
            
        }
                  .onAppear(){
                       self.viewModel.getKeywords(uid: uid)
                             }
                
                LazyVStack(spacing: 13){
           
            Divider()
               .frame(width: 35,height: 6)
               .background(Color.black)
                
           HStack{
               
               Text("Footprint")
                   .font(.custom(appleGothicBold, size: 36))
                   .foregroundColor(Color.black)
                   .tracking(-1.5)
        
            
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
                     self.viewModel.getBios(uid: uid)
                 }
                
                
                
            }
            
            
                
     
        }.onAppear(){
            self.currentUserCheck()
            self.savedUserCheck()
            self.viewModel.getUserDoc(uid: uid)
            
            
        }
        .padding(.leading,20)
        .padding([.trailing,.top,.bottom])
        
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct detailChipView: View {
    var chipText: String
    
    @EnvironmentObject var session: SessionStore
    @State var randomTextBase: Color = Color.black
    @State var random: Color = Color(hex: "#E5E5E5")
    let appleGothicMed : String = "Apple SD Gothic Neo Medium"
    
    let colors = [Color(hex: "#E5E5E5"),
                  Color(hex: "#C5C5C5"),
                  Color(hex: "#646464")]
    

    
    
    
    var body: some View{
        
        
        HStack(alignment: .center, spacing: 5){
        
        Text(chipText)
            
            .fixedSize()
            .font(.custom(appleGothicMed, size: 16))
            //.background(Color.gray)
            .lineLimit(1)
            .foregroundColor(randomTextBase)
            //.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
                   
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
