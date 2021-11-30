//
//  AddProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/27.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddBioView: View {
    @State private var bioText = ""
   // @State private var keywordText = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SessionStore()
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
   
    
    @State private var selectedYearIndex: Int = 0
    private let years: [Int] = Array(2000...Int("yyyy".stringFromDate())!)
    
    
    private let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = false
        return nf
    }()

   @State private var isNextActive = false

    func yearString(at index: Int) -> String {
        let selectedYear = years[index]
        return numberFormatter.string(for: selectedYear) ?? selectedYear.description
    }
   
  /* func addBio(){
       
       if !bioText.isEmpty {
           
        
        BioService.saveBio(date: yearString(at: selectedYearIndex), description: bioText, onSuccess: {
            (bio) in
        }){
            (errorMessage) in
            print("Error \(errorMessage)")
            return
            
            
        }
           
       }
        
    } */
    
  

  
    
    var body: some View {
        
        
        NavigationView{
       
        VStack{
        
                Text("커리어 추가")
                    .font(.custom(appleGothicBold, size: 20))
                    .foregroundColor(Color.black)
                    .padding(.top,20)
                    .padding(.bottom,20)
        
       
                  
                    Picker("Year", selection: $selectedYearIndex) {
                        ForEach(years.indices) { yearIndex in
                            Text("\(self.yearString(at: yearIndex))")
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    .cornerRadius(15)
                    .overlay(
                             RoundedRectangle(cornerRadius: 15)
                                 .stroke(Color(hex: "#ADADAD"), lineWidth: 1.5)
                             )
                    .padding(.horizontal)
                    
                      
                
                   /* TextEditor(text: $bioText)
                               .frame(maxHeight: 100, alignment: .center)
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
                               
                */
            
           
                
                Button(action: {
                    
                    isNextActive.toggle()
                    
                   // addBio()
                  //  presentationMode.wrappedValue.dismiss()
                }){
                  
                    Text("다음")
                        .foregroundColor(Color.white)
                        .font(.custom(appleGothicBold, size: 24))
                       
                    
                    
                    
                    
                }
                .frame(maxWidth: 100, maxHeight: 35)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "#646464")))
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#646464"), lineWidth: 1)
                
                )
                .padding(.top,15)
                
                Spacer()
                
            NavigationLink(destination: BioTextAddView(selectedYear: yearString(at: selectedYearIndex))
                
               
                
                
                
                
            , isActive: $isNextActive){
                
                
            }.hidden()
            
            
            
            
            
            
        }
        .padding()
            
          
            
        }
    }
}

struct BioTextAddView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var session: SessionStore
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    @State private var bioText = ""
    var selectedYear: String
    let db = Firestore.firestore()
    
    func addBio(){
        
        if !bioText.isEmpty {
            
            let bioRef = db.collection("Users").document(self.session.session!.uid)
            
           
          
            
         
            BioService.saveBio(date: selectedYear, description: bioText.trimmingCharacters(in: .whitespacesAndNewlines), onSuccess: {
             (bio) in
      
      let inputString = bioText.lowercased()
      let trimmed = String(inputString.filter {!"\n\t\r".contains($0)})
      
      let words = trimmed.components(separatedBy: " ")
      

      for word in words {
          bioRef.updateData([
              "bios_search" : FieldValue.arrayUnion([word])
          ])
      }
         }){
             (errorMessage) in
             print("Error \(errorMessage)")
             return
             
             
         }
            
        }
         
     }
    
    var body: some View {
        VStack(alignment:.center){
            
           
            
            Text(selectedYear)
                .font(.custom(appleGothicBold, size: 30))
                .foregroundColor(Color.black)
                .tracking(-1.5)
                .padding(.bottom,5)
            
            TextEditor(text: $bioText)
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
                 addBio()
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
                .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}





