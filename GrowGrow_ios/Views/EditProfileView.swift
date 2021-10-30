//
//  EditProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/25.
//

import SwiftUI
import FirebaseFirestore

struct EditProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject private var sessionViewModel = SessionStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var summary: String = ""
    @StateObject var viewModel = ViewModel()
    @State private var agreedToChange : Bool = false
    
    
    @State private var selectedRegion = 0
    @State private var selectedDepart = 0
    @State private var selectedMajor = 0
    
    //퍼센트 단위를 배열로 만들어주고
    let regions = ["서울/경기","강원","충청","대구/경북","전북/전남","제주"]
    let departs = ["인문","사회","공학","자연","교육","의약","예체능"]
    @State private var urlString: String
  
    
    
   
   

    init(initfullname: String, initusername:String,initsummary:String){
        self._fullname = State(initialValue: initfullname)
        self._username = State(initialValue: initusername)
        self._summary = State(initialValue: initsummary)
        self._urlString = State(initialValue: "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391&perPage=50")
        
    }
    
     func urlControl(){
         
         if departs[selectedDepart] == "의약"{
             
             urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100396&perPage=50"
             
             
         } else if departs[selectedDepart] == "사회" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100392&perPage=50"
         }
         else if departs[selectedDepart] == "교육" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100394&perPage=50"
         }
         else if departs[selectedDepart] == "공학" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100392&perPage=50"
         }
         else if departs[selectedDepart] == "자연" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100395&perPage=50"
         }
         else if departs[selectedDepart] == "예체능" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100397&perPage=50"
         } else {
             urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391&perPage=50"
             
         }
         
       
        
       
        
    }
    
    func updateUser(){
        let db = Firestore.firestore()
        
        if agreedToChange == true {
            
            db.collection("Users").document(self.session.session!.uid).updateData([
                "fullname" : fullname,
                "username" : username,
                "summary" : summary,
                "region" : regions[selectedRegion],
                "depart" : departs[selectedDepart],
                "major" : viewModel.contents[selectedMajor].mClass
            
            
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                      } else {
                          print("Document successfully updated")
                      }
            }
            
            
            
        } else {
            
            db.collection("Users").document(self.session.session!.uid).updateData([
                "fullname" : fullname,
                "username" : username,
                "summary" : summary,
        
            
            
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                      } else {
                          print("Document successfully updated")
                      }
            }
            
            
        }
        
       
        
        
        
        
        
    }
    
    

    
    var body: some View {
        
      
        
        NavigationView {
            
            Form{
                
                
            
            
                
                
                
                    
                    
                
                Section{
                    
                    
                
            VStack{
                FormField(value: $fullname, icon: "person.fill", placeholder: "fullname")
                FormField(value: $username, icon: "person.fill", placeholder: "username")
                TextEditor(text: $summary)
                    .frame(height: 50, alignment: .center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .overlay(
                             RoundedRectangle(cornerRadius: 25)
                               .stroke(Color.black, lineWidth: 2)
                             )
                
            }
                    
                }
                
                Section{
                    Toggle("Agree to change",isOn: $agreedToChange)
                   
                }
                
                               
                Section(header: Text("현재 나의 지역 \(sessionViewModel.region)")) {
                                    Picker("선택된 지역", selection: $selectedRegion) {
                                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                                        ForEach(0 ..< regions.count) {
                                            Text("\(self.regions[$0])")
                                        }
                                    }.disabled(agreedToChange == false)
                                }
                
                Section(header: Text("현재 나의 계열 \(sessionViewModel.depart)")) {
                    Picker("선택된 계열", selection: $selectedDepart) {
                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                        ForEach(0 ..< departs.count) {
                            Text("\(self.departs[$0])")
                            
                        }
                    }.disabled(agreedToChange == false)
                }
                
                Section(header: Text("현재 나의 전공 \(sessionViewModel.major)")) {
                    Picker("선택된 전공", selection: $selectedMajor) {
                     ForEach(0 ..< viewModel.contents.count, id: \.self) {
                             Text(self.viewModel.contents[$0].mClass)
                            
                        }
                    }
                    .disabled(agreedToChange == false)
                    .onAppear{
                        urlControl()
                        viewModel.getJson(urlString: urlString)
                            
                    }
                    
                }
               
                
                
                
                
            
            }.onAppear(){
                self.sessionViewModel.getCurrentUser()
            }
            
            
            
            
            .navigationBarTitle(Text("프로필 편집"), displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }.padding()


                }, trailing:
                    HStack {
                        Button(action: {
                            
                            updateUser()
                            presentationMode.wrappedValue.dismiss()
                        
                        }) {
                            Image(systemName: "checkmark")
                        }
                    }
            )
        }
    }
    
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(initfullname: "", initusername: "", initsummary: "")
    }
}



