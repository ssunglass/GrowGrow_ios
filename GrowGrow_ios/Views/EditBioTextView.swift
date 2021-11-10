//
//  EditBioTextView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct EditBioTextView: View {
    
    @State private var editBioText = ""
    @Environment(\.presentationMode) var presentationMode
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    
    
    var date: String
    
    
    
    
    init(editBioText:String, date: String){
        
        self._editBioText = State(initialValue: editBioText)
        self.date = date
        UINavigationBar.appearance().tintColor = .black
        
        
        
    }
    
    func updateData(){
        
        Firestore.firestore()
            .collection("Users")
            .document(Auth.auth().currentUser!.uid)
            .collection("Bios")
            .document(date)
            .updateData([
                "description" : editBioText
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                      } else {
                          print("Document successfully updated")
                      }
            }
        
        
        
    }
    
    
    var body: some View {
        VStack(alignment:.center){
            
            Text("이력 업데이트")
                .font(.custom(appleGothicSemiBold, size: 25))
                .foregroundColor(Color.black)
                .padding()
            
            Text(date)
                .font(.custom(appleGothicBold, size: 30))
                .foregroundColor(Color.black)
                .tracking(-1.5)
                .padding(.bottom,5)
            
            TextEditor(text: $editBioText)
                .frame(maxHeight: 180, alignment: .center)
                .font(.custom(appleGothicSemiBold, size: 20))
                .foregroundColor(Color.black)
                .cornerRadius(15)
                .overlay(
                         RoundedRectangle(cornerRadius: 15)
                             .stroke(Color(hex: "#ADADAD"), lineWidth: 1.5)
                         )
                .background(RoundedRectangle(cornerRadius: 15)
                             .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.10), radius: 4, x: 0, y: 4))
                .padding(.horizontal,10)
            
            Button(action:{
                updateData()
                presentationMode.wrappedValue.dismiss()
            }){
                
                Text("완료")
                 .font(.custom(appleGothicBold, size: 24))
                 .foregroundColor(Color.white)
                
                
            }
            .frame(maxWidth: 100, maxHeight: 35)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "#646464")))
            .overlay(
                   RoundedRectangle(cornerRadius: 20)
                       .stroke(Color(hex: "#646464"), lineWidth: 1)
           
           )
            .padding(.top,10)
            
            Spacer()
            
            
            
        }
        
    }
}


