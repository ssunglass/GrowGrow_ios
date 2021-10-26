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
    
    @State private var pickerindex = 0
    
    //퍼센트 단위를 배열로 만들어주고
    let regions = ["서울/경기","강원","충청","대구/경북","전북/전남","제주"]
    let departs = ["인문","사회","공학","자연","교육","의약","예체능"]
   
   

    init(initfullname: String, initusername:String,initsummary:String){
        self._fullname = State(initialValue: initfullname)
        self._username = State(initialValue: initusername)
        self._summary = State(initialValue: initsummary)
        
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
                                    Picker("현재 나의 지역", selection: $pickerindex) {
                                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                                        ForEach(0 ..< regions.count) {
                                            Text("\(self.regions[$0])")
                                        }
                                    }
                                }
                
                Section {
                    Picker("현재 나의 계열", selection: $pickerindex) {
                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                        ForEach(0 ..< departs.count) {
                            Text("\(self.departs[$0])")
                        }
                    }
                }
                
                Section {
                    Picker("현재 나의 전공", selection: $pickerindex) {
                        //0..< = 딕셔너리의 [10]부터 tipPercentage보다 작은값
                        ForEach(0 ..< departs.count) {
                            Text("\(self.departs[$0])")
                        }
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
