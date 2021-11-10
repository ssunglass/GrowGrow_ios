//
//  SearchView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI
import FirebaseAuth


struct SearchView: View {
    
    @ObservedObject private var viewModel = SessionStore()
    @State var keyword: String = ""
   // @State var selectedRegion: String = "대학권역"
    let departs = ["인문","사회","공학","자연","교육","의약","예체능"]
    let regions = ["서울/경기","강원","충청","대구/경북","전북/전남","제주"]
    
    @State var showSheet: Bool = false
    @State var isSelectedRegion : Bool = false
    @State var isSelectedDepart : Bool = false
    @State var searchIsActive : Bool = false
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicSemiBold: String = "Apple SD Gothic Neo SemiBold"
    
    @State private var showingAlert = false
    
    @State var selectedRegion: String?
    
    
    @State var selectionsDepart: [String] = []
   
    
    
    let departColumns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .center)
    ]
    
    let regionColumns = [
        GridItem(.flexible(),  spacing: -5,alignment: .center),
        GridItem(.flexible(), spacing: -20, alignment: .center),
        GridItem(.flexible(), spacing: -5,alignment: .center),
        GridItem(.flexible(),  spacing: -5,alignment: .center)
    ]
    
    
    
    var body: some View {
      
        
        
        
        NavigationView{
            
            ScrollView{
            
            VStack(alignment: .leading){
                
            Text("키워드 검색")
                    .foregroundColor(Color.black)
                    .font(.custom(appleGothicBold, size: 18))
            
                HStack{
                    
                   TextField("삼성전기 샘이랑을 검색해보세요",text: $keyword)
                        .padding(.leading, 20)
                        .font(.custom(appleGothicSemiBold, size: 20))
                        .foregroundColor(Color(hex: "#818181"))
                    
                    
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 20)
                }.frame(height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(hex: "#F3F3F3"),lineWidth: 1))
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "F3F3F3")))
                    .padding(.bottom,10)
                
                Divider()
                    .background(Color(hex: "#CBCBCB"))
                Group{
            Text("필터 검색")
                    .foregroundColor(Color.black)
                    .font(.custom(appleGothicBold, size: 18))
                    .padding([.top])
                    .padding(.bottom,10)
           
                Text("계열")
                    .foregroundColor(Color(hex:"#646464"))
                    .font(.custom(appleGothicBold, size: 18))
            
            LazyVGrid(columns: departColumns, spacing: 15){
                ForEach(departs, id:\.self){depart in
                    Chips(titleKey: depart, isSelected: isSelectedDepart){ isSelect in
                        if isSelect{
                            print("Select \(depart)")
                            selectionsDepart.append(depart)
                            print(selectionsDepart)
                        } else {
                            print("not select \(depart)")
                           selectionsDepart = selectionsDepart.filter{ $0 != depart}
                            print(selectionsDepart)
                           
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
            }.padding(.horizontal)
                    
                }
                
                
               
            
                Group{
                    Divider()
                        .background(Color(hex: "#CBCBCB"))
                        .padding([.top,.bottom])
                    
                    Text("지역")
                        .foregroundColor(Color(hex:"#646464"))
                        .font(.custom(appleGothicBold, size: 18))
                    
                    
                
        
            
            
            LazyVGrid(columns: regionColumns, spacing: 15){
                ForEach(regions, id: \.self){region in
                    HStack{
                        Text(region)
                            .lineLimit(1)
                            .padding(.leading,10)
                            .padding(.trailing,10)
                            .padding(.top,5)
                            .padding(.bottom,5)
                            .foregroundColor(self.selectedRegion == region ? .white : Color(hex: "#646464"))
                            .cornerRadius(5)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                     .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
                            
                            )
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(self.selectedRegion == region ? Color.black : Color(hex: "#F3F3F3"))
                                            .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 0, y: 4))
                            .font(.custom(appleGothicBold, size: 15))
                            
                        
                        
                    }.onTapGesture {
                        if self.selectedRegion == region {
                            self.selectedRegion = ""
                            
                            
                        } else {
                            self.selectedRegion = region
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                }
            }
            .padding([.bottom])
            
                }
           /* Text(selectedRegion)
                .foregroundColor(.white)
                .background(Color.black)
                       .cornerRadius(40)
                       .overlay(
                               RoundedRectangle(cornerRadius: 40)
                                   .stroke(Color.blue, lineWidth: 1.5)
                       
                       )
                .onTapGesture {
                          
                           showSheet.toggle()
                       }
            
                .sheet(isPresented: $showSheet, content: {
                    
                    
                    
                    VStack{
                        
                      /*  List{
                            ForEach(regions, id: \.self){ name in
                                Regions(titleKey: name, isSelected: isSelectedRegion) {title in
                                    print(title)
                                }
                                
                            }
                            
                        } */
                        
                    
                   LazyVGrid(columns: columns,spacing: 15){
                        ForEach(regions, id: \.self){ region in
                            Regions(titleKey: region, isSelected: isSelectedRegion){isSelect in
                                if isSelect{
                                    print("selected \(region)")
                                    selectionsRegion.append(region)
                                    print(selectionsRegion)
                                    
                                } else {
                                    print("notSelected \(region)")
                                    selectionsRegion = selectionsRegion.filter{ $0 != region}
                                    print(selectionsRegion)
                                    
                                    
                                }
                }
                            
                        }
                        
                        
                        
                    }
                        
                        Button(action: {
                           
                        
                            showSheet.toggle()
                            
                        }){
                            Text("적용")
                            
                        }
                    }
                }) */
            
            
                       
            
            Button(action:{
                if keyword == "" {
                    
                    showingAlert.toggle()
                    print("no")
                    
                    
                } else {
                    
                searchIsActive.toggle()
                    
                }
              
            }){
                
                HStack{
                    Text("검색")
                        .foregroundColor(.white)
                        .font(.custom(appleGothicBold, size: 24))
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.white)
                    
                }
               
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.black))
            .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black, lineWidth: 1.5)
            
            )
            
            .padding()
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("커커"), message: Text("검색어를 입력해주세요"), dismissButton: .default(Text("확인")) {

                        
                    })
                }
                
                
                Spacer()
            
            
            NavigationLink(destination: SearchedView(inputKeyword: keyword, inputDeparts: selectionsDepart, inputRegions: selectedRegion), isActive: $searchIsActive){
                
                
                
            }.hidden()
            
                .navigationTitle("검색")
                
            
                
            
            
            
            
        }
            .padding()
            
            }
        }
        
            


        
       
    
       
    }
    
}




  









 struct Regions: View {
     
     typealias Action = (Bool) -> Void
     
    let titleKey: String
    @State var isSelected: Bool
     var action: Action?
    
     
    var body: some View {
        
          Text(titleKey)
            .lineLimit(1)
            .padding()
        
        .foregroundColor(isSelected ? .white : Color(hex: "#646464"))
        //.background(isSelected ? Color.blue : Color.white)
        .cornerRadius(5)
        .overlay(
                RoundedRectangle(cornerRadius: 5)
                 .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
        
        )
        .background(RoundedRectangle(cornerRadius: 5).fill(isSelected ? Color.black : Color(hex: "#F3F3F3")))
        .onTapGesture {
            isSelected.toggle()
            
            if let action = action {
                action(isSelected)
            }
      
        }
    }
}


struct Chips: View {
    
    typealias Action = (Bool) -> Void
    
   let titleKey: String
   @State var isSelected: Bool
    var action: Action?
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    
   var body: some View {
       
         Text(titleKey)
           .font(.custom(appleGothicBold, size: 15))
           .lineLimit(1)
           .padding(.leading,10)
           .padding(.trailing,10)
           .padding(.top,5)
           .padding(.bottom,5)
          
       
       .foregroundColor(isSelected ? .white : Color(hex: "#646464"))
       .cornerRadius(5)
       .overlay(
               RoundedRectangle(cornerRadius: 5)
                .stroke(Color(hex: "#F3F3F3"), lineWidth: 1.5)
       
       )
       .background(RoundedRectangle(cornerRadius: 5)
                    .fill(isSelected ? Color.black : Color(hex: "#F3F3F3"))
                    .shadow(color: Color(red:0, green: 0, blue: 0, opacity: 0.15), radius: 4, x: 0, y: 4))
       .onTapGesture {
           isSelected.toggle()
           
           if let action = action {
               action(isSelected)
           }
     
       }
   }
}

