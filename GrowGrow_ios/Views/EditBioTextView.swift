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
    
    
    var date: String
    
    
    
    
    init(editBioText:String, date: String){
        
        self._editBioText = State(initialValue: editBioText)
        self.date = date
        
        
        
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
            Text(date)
            
            TextEditor(text: $editBioText)
                .frame(height: 250, alignment: .center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .overlay(
                         RoundedRectangle(cornerRadius: 25)
                           .stroke(Color.black, lineWidth: 2)
                         )
            
            Button(action:{
                updateData()
                presentationMode.wrappedValue.dismiss()
            }){
                
                Text("Update")
                
            }
            
        }
    }
}


