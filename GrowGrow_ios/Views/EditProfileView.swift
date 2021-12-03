//
//  EditProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseDynamicLinks
import Security

struct EditProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    @ObservedObject private var sessionViewModel = SessionStore()
    @Environment(\.presentationMode) var presentationMode
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var summary: String = ""
    @StateObject var viewModel = ViewModel()
    @State private var agreedToChange : Bool = false
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    
    @State private var selectedRegion = 0
    @State private var selectedDepart = 0
    @State private var selectedMajor = 0
    
    //퍼센트 단위를 배열로 만들어주고
    let regions = ["서울/경기","강원","충청","대구/경북","전북/전남","제주"]
    let departs = ["인문","사회","공학","자연","교육","의약","예체능"]
    @State private var urlString: String
    @State private var departIcon: String
    
   @State private var NumberToMessage = ""
  
    
    
   
   

    init(initfullname: String, initusername:String,initsummary:String){
        self._fullname = State(initialValue: initfullname)
        self._username = State(initialValue: initusername)
        self._summary = State(initialValue: initsummary)
        self._urlString = State(initialValue: "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391&perPage=100")
        self._departIcon = State(initialValue: "person.fill.questionmark")
        
        UINavigationBar.appearance().tintColor = .black
        
    }
    
     func urlControl(){
         
         if departs[selectedDepart] == "의약"{
             
             urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100396&perPage=100"
             
             
         } else if departs[selectedDepart] == "사회" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100392&perPage=100"
         }
         else if departs[selectedDepart] == "교육" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100393&perPage=100"
         }
         else if departs[selectedDepart] == "공학" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100394&perPage=100"
         }
         else if departs[selectedDepart] == "자연" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100395&perPage=100"
         }
         else if departs[selectedDepart] == "예체능" {
             
              urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100397&perPage=100"
         } else {
             urlString = "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391&perPage=100"
             
         }
         
       
        
       
        
    }
    
   
    func updateUser(){
        let db = Firestore.firestore()
        
        if departs[selectedDepart] == "인문" {
            
            departIcon = "brain.head.profile"
            
        } else if departs[selectedDepart] == "사회" {
            
            departIcon = "figure.stand.line.dotted.figure.stand"
        } else if departs[selectedDepart] == "공학" {
            
            departIcon = "link.icloud"
        } else if departs[selectedDepart] == "자연" {
            
            departIcon = "tortoise"
        } else if departs[selectedDepart] == "교육" {
            
            departIcon = "graduationcap"
        } else if departs[selectedDepart] == "의약" {
            
            departIcon =  "cross.case"
        } else {
            
            departIcon = "airpodsmax"
        }
        
        
        
        
        
        
        if agreedToChange == true {
            
            
            
            db.collection("Users").document(self.session.session!.uid).updateData([
                //"fullname" : fullname,
                //"username" : username,
                "summary" : summary.trimmingCharacters(in: .whitespacesAndNewlines),
                "region" : regions[selectedRegion],
                "depart" : departs[selectedDepart],
                "major" : viewModel.contents[selectedMajor].mClass,
                "departIcon" : departIcon
            
            
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                      } else {
                          print("Document successfully updated")
                      }
            }
            
            
            
        } else {
            
            db.collection("Users").document(self.session.session!.uid).updateData([
                "summary" : summary.trimmingCharacters(in: .whitespacesAndNewlines),
        
            
            
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
            
            
            VStack(){
                
                VStack(alignment: .leading){
                    
                 
                    
                Text("한줄요약")
                    .foregroundColor(Color.black)
                    .font(.custom(appleGothicBold, size: 18))
                    .padding(.leading, 20)
                
                TextEditor(text: $summary)
                      .padding()
                      .frame(maxHeight: 150, alignment: .center)
                      .font(.custom(appleGothicSemiBold, size: 15))
                      .foregroundColor(Color.black)
                      .cornerRadius(5)
                      .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                   .stroke(Color(hex: "#ADADAD"), lineWidth: 1)
                               )
                      /*.background(RoundedRectangle(cornerRadius: 5)
                                   .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.10), radius: 4, x: 0, y: 4))*/
                      .padding([.horizontal])
                    
                }
                
                HStack(alignment:.center,spacing: 50){
                    
                    VStack{
                        HStack(spacing: 2.5){
                            
                            Image(systemName: "globe.asia.australia")
                            
                        Text("지역")
                                .foregroundColor(Color(hex:"#646464"))
                                .font(.custom(appleGothicBold, size: 18))
                            
                           
                               
                        }
                        
                        Text(sessionViewModel.region)
                            .lineLimit(1)
                            .padding(.leading,10)
                            .padding(.trailing,10)
                            .padding(.top,5)
                            .padding(.bottom,5)
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                     .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
                            
                            )
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(Color(hex: "646464"))
                                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 0, y: 4))
                            .font(.custom(appleGothicBold, size: 15))
                        
                        
                    }
                    
                    VStack{
                        HStack(spacing: 2.5){
                            Image(systemName: "books.vertical")
                        Text("계열")
                                .foregroundColor(Color(hex:"#646464"))
                                .font(.custom(appleGothicBold, size: 18))
                        }
                        
                        Text(sessionViewModel.depart)
                            .lineLimit(1)
                            .padding(.leading,10)
                            .padding(.trailing,10)
                            .padding(.top,5)
                            .padding(.bottom,5)
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                     .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
                            
                            )
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(Color(hex: "646464"))
                                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 0, y: 4))
                            .font(.custom(appleGothicBold, size: 15))
                        
                    }
                 
                    
                    VStack{
                        HStack(spacing: 2.5){
                            Image(systemName: "book.closed")
                        Text("전공")
                                .foregroundColor(Color(hex:"#646464"))
                                .font(.custom(appleGothicBold, size: 18))
                        
                        }
                        
                        Text(sessionViewModel.major)
                            .lineLimit(1)
                            .padding(.leading,10)
                            .padding(.trailing,10)
                            .padding(.top,5)
                            .padding(.bottom,5)
                            .foregroundColor(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                     .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
                            
                            )
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(Color(hex: "646464"))
                                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 0, y: 4))
                            .font(.custom(appleGothicBold, size: 15))
                    }
                    
                    
                    
                    
                }
                .padding(.top,20)
                
                
                Form{
                    
                    Section{
                        Toggle(isOn: $agreedToChange){
                            Text("세부 정보 수정하기")
                                .font(.custom(appleGothicBold, size: 18))
                                .foregroundColor(Color.black)
                            
                        }
                        
                        if agreedToChange {
                            
                            Picker("선택된 지역", selection: $selectedRegion) {
                                //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                                ForEach(0 ..< regions.count) {
                                    Text("\(self.regions[$0])")
                                  
                                }
                            }.disabled(agreedToChange == false)
                            
                            Picker("선택된 계열", selection: $selectedDepart) {
                                //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                                ForEach(0 ..< departs.count) {
                                    Text("\(self.departs[$0])")
                                    
                                }
                            }.disabled(agreedToChange == false)
                            
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
                        
                    }
                    .font(.custom(appleGothicBold, size: 15))
                  
                    
                }
                    .onAppear(){
                        UITableView.appearance().backgroundColor = .clear
                    }
                
                
                    
                
                
                
                
                
            }
            .onAppear(){
                self.sessionViewModel.getUserDoc(uid: self.session.session!.uid)
            }
            .padding()
            
            
            
            
            .navigationBarTitle(Text("프로필 수정"), displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                
                Button(action: {presentationMode.wrappedValue.dismiss()}) {
                    
                    Label("cancel", systemImage: "xmark")
                        .labelStyle(IconOnlyLabelStyle())
                        
                }.padding()
                
            

                }, trailing:
                    HStack {
                
                Button(action: {
                    updateUser()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Label("check", systemImage: "checkmark")
                        .labelStyle(IconOnlyLabelStyle())
                       
                    
                } .padding()
                
          
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



