//
//  AddProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/27.
//

import SwiftUI

struct AddProfileView: View {
    @State private var bioText = ""
   // @State private var keywordText = ""
    @Environment(\.presentationMode) var presentationMode
   
    
    @State private var selectedYearIndex: Int = 0
    private let years: [Int] = Array(2000...Int("yyyy".stringFromDate())!)
    
    
    private let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.usesGroupingSeparator = false
        return nf
    }()

   

    func yearString(at index: Int) -> String {
        let selectedYear = years[index]
        return numberFormatter.string(for: selectedYear) ?? selectedYear.description
    }
   
   func addBio(){
       
       if !bioText.isEmpty {
           
           
       
        
        BioService.saveBio(date: yearString(at: selectedYearIndex), description: bioText, onSuccess: {
            (bio) in
        }){
            (errorMessage) in
            print("Error \(errorMessage)")
            return
            
            
        }
           
       }
        
    }

  
    
    var body: some View {
        VStack{
            
          /*  Group{
                
                Text("키워드 추가")
                
                TextField("키워드 입력", text: $keywordText)
                    //.textFieldStyle(.roundedBorder)
                    .overlay(
                             RoundedRectangle(cornerRadius: 25)
                               .stroke(Color.black, lineWidth: 2)
                             )
                
                
                Button(action: {}){
                    Text("추가")
                    
                    
                    
                    
                }
                
                
            } */
            
            Group{
                Text("바이오 추가")
                
                
                    
                
                
                  
                    Picker("Year", selection: $selectedYearIndex) {
                        ForEach(years.indices) { yearIndex in
                            Text("\(self.yearString(at: yearIndex))")
                        }
                    }.pickerStyle(InlinePickerStyle())
                
                
                
                
                
                      
                
                           TextEditor(text: $bioText)
                               .frame(height: 250, alignment: .center)
                               .foregroundColor(.secondary)
                               .padding(.horizontal)
                               .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                          .stroke(Color.black, lineWidth: 2)
                                        )
                               
                       
                
                Button(action: {
                    addBio()
                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("추가")
                    
                    
                    
                    
                }
            }
            
            
            
            
            
        }
    }
}

struct AddProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddProfileView()
    }
}


