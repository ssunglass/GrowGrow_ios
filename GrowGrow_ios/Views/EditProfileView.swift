//
//  EditProfileView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/25.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var summary: String = ""
    @StateObject var viewModel = ViewModel()
    
    
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
    
    

    
    var body: some View {
        
      
        
        NavigationView {
            
            Form{
                
                
            
            
                
                
                
                    
                    
                
                Section{
                    
                    
                
            VStack{
                FormField(value: $fullname, icon: "person.fill", placeholder: "fullname")
                FormField(value: $username, icon: "person.fill", placeholder: "username")
                FormField(value: $summary, icon: "person.fill", placeholder: "한줄요약")
                
            }
                    
                }
               
                               //퍼센트 섹션
                                Section {
                                    Picker("현재 나의 지역", selection: $selectedRegion) {
                                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                                        ForEach(0 ..< regions.count) {
                                            Text("\(self.regions[$0])")
                                        }
                                    }
                                }
                
                Section {
                    Picker("현재 나의 계열", selection: $selectedDepart) {
                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                        ForEach(0 ..< departs.count) {
                            Text("\(self.departs[$0])")
                        }
                    }
                }
                
                Section {
                    Picker("현재 나의 전공", selection: $selectedMajor) {
                     ForEach(0 ..< viewModel.contents.count, id: \.self) {
                             Text(self.viewModel.contents[$0].mClass)
                            
                        }
                    }.onAppear{
                        urlControl()
                        viewModel.getJson(urlString: urlString)
                            
                    }
                    
                }
               
                
                
                
                
            
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

struct DetailView: View {
    
    var body: some View{
        Text("Detail")
    }
    
}
