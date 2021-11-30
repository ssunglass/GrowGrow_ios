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
    
    @StateObject private var viewModel = SessionStore()
    @EnvironmentObject var session: SessionStore
    
    @State private var editBioText = ""
    @Environment(\.presentationMode) var presentationMode
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    let db = Firestore.firestore()
    
    
    var date: String
    
    
    
    
    init(editBioText:String, date: String){
        
        self._editBioText = State(initialValue: editBioText)
        self.date = date
        UINavigationBar.appearance().tintColor = .black
        
        
        
    }
    
    func updateData(){
        
        let bioRef = db.collection("Users").document(self.session.session!.uid)
        
        bioRef
            .collection("Bios")
            .document(date)
            .updateData([
                "description" : editBioText.trimmingCharacters(in: .whitespacesAndNewlines)
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                      } else {
                          print("Document successfully updated")
                          
                          bioRef.updateData([
                              "bios_search" : FieldValue.delete()
                          ]){ err in
                              if let err = err {
                                  print("Error updating document: \(err)")
                              } else {
                                  
                                  print("Document successfully updated")
                                  
                                  for bio in self.viewModel.bios {
                                      
                                      let inputString = bio.description
                                   let trimmed = String(inputString.filter {!"\n\t\r".contains($0)})
                               
                                    let words = trimmed.components(separatedBy: " ")
                                      
                                      for word in words {
                                          bioRef.updateData([
                                              "bios_search" : FieldValue.arrayUnion([word])
                                          ])
                                      }
                                      
                                      
                                      
                                      
                                  }
                                  
                                  
                                  
                                  
                              }
                              
                          }
                          
                      }
            }
        
        
        
        
        
    }
    
    
    var body: some View {
        VStack(alignment:.center){
            
            Text("커리어 업데이트")
                .font(.custom(appleGothicSemiBold, size: 25))
                .foregroundColor(Color.black)
                .padding()
            
            Text(date)
                .font(.custom(appleGothicBold, size: 30))
                .foregroundColor(Color.black)
                .tracking(-1.5)
                .padding(.bottom,5)
            
            TextEditor(text: $editBioText)
                .padding()
                .frame(maxHeight: 180, alignment: .center)
                .font(.custom(appleGothicSemiBold, size: 17))
                .foregroundColor(Color.black)
                .cornerRadius(5)
                .overlay(
                         RoundedRectangle(cornerRadius: 5)
                             .stroke(Color(hex: "#ADADAD"), lineWidth: 1.5)
                         )
               /* .background(RoundedRectangle(cornerRadius: 15)
                             .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.10), radius: 4, x: 0, y: 4)) */
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
        .onAppear(){
            self.viewModel.getBios(uid: self.session.session!.uid)
            
            
        }
        
    }
}


