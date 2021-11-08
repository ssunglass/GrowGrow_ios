//
//  EditBioView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/30.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth


struct EditBioView: View {
    
    @StateObject private var viewModel = SessionStore()
    @EnvironmentObject var session: SessionStore
    @State var editIsActive = false
    @State var onEditDate: String = ""
    @State var onEditText: String = ""
    let db = Firestore.firestore()
   
    
    func deleteBio(date: String){
        
    
        db.collection("Users").document(self.session.session!.uid)
            .collection("Bios")
            .document(date)
            .delete(){error in
                if let error = error {
                    print(error.localizedDescription)
                    
                    
                } else {
                    
                    
                   // self.viewModel.getBios(uid: self.session.session!.uid)
                    
                }
                
                
            }
        
        
        
        
        
        
    }
    
    
    var body: some View {
        
     
        NavigationView{
       List{
        
        ForEach(viewModel.bios){bio in
            
            
           
        
                
            
            
            BioView(date: bio.date, description: bio.description)
                
                
                .modifier(CenterModifier())
                .swipeActions{
                    
                    Button(role: .destructive, action: {
                        deleteBio(date: bio.date)
                  
                    }, label: {Label("삭제",systemImage: "trash.circle.fill")})
                    
                    
                }
                
                .swipeActions(edge: .leading, allowsFullSwipe: false){
                     Button(action: {
                         editIsActive.toggle()
                         onEditDate = bio.date
                         onEditText = bio.description
                     }, label: {Label("수정",systemImage: "pencil.circle.fill")})
                        .tint(.blue)
                    
                   
                    
                    
                }
            
        
            
        }
           
           NavigationLink(destination: EditBioTextView(editBioText: onEditText, date: onEditDate), isActive: $editIsActive){
              Image(systemName: "pencil.circle.fill")
              
              
          }
           .hidden()
        
        
    }.onAppear(){
            self.viewModel.getBios(uid: self.session.session!.uid)
             
    }.listStyle(PlainListStyle())
            
    .navigationTitle("이력 리스트")
   
        }
        
    }
}

struct EditBioView_Previews: PreviewProvider {
    static var previews: some View {
        EditBioView()
    }
}
struct CenterModifier: ViewModifier{
    func body(content: Content) -> some View {
        HStack{
            Spacer()
            content
            Spacer()
        }
    }
}
