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
    @State var selectedRegion: String = "대학권역"
    let departs = ["인문","사회","공학","자연","교육","의약","예체능"]
    let regions = ["서울/경기","강원","충청","대구/경북","전북/전남","제주"]
    
    @State var showSheet: Bool = false
    @State var isSelectedRegion : Bool = false
    @State var isSelectedDepart : Bool = false
    @State var searchIsActive : Bool = false
    
    
    @State var selectionsDepart: [String] = []
    @State var selectionsRegion: [String] = []
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    
    var body: some View {
      
        
        
        
        NavigationView{
            
        VStack{
            Text("키워드 검색")
            
            TextField("삼성전기 샘이랑을 검색해보세요",text: $keyword)
                .textFieldStyle(.roundedBorder)
            
            Text("필터 검색")
            
           
            
            LazyVGrid(columns: columns, spacing: 15){
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
            
            
        
            Text("지역")
            
            Text(selectedRegion)
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
                })
            
            
                       
            
            Button(action:{
                
                searchIsActive.toggle()
               
              
            }){
                
                HStack{
                    Text("검색")
                        .foregroundColor(.white)
                    Image(systemName: "magnifyingglass.circle.fill")
                    
                }
                .background(Color.black)
                .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.black, lineWidth: 1.5)
                
                )
            }.padding()
            
            
            NavigationLink(destination: SearchedView(), isActive: $searchIsActive){
                
                
                
            }.hidden()
            
                .navigationTitle("검색")
                
            
                
            
            
            
            
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
        
          Text(titleKey).font(.title3).lineLimit(1)
        
        .foregroundColor(isSelected ? .white : .blue)
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(40)
        .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.blue, lineWidth: 1.5)
        
        ).onTapGesture {
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
    
   var body: some View {
       
         Text(titleKey).font(.title3).lineLimit(1)
       
       .foregroundColor(isSelected ? .white : .blue)
       .background(isSelected ? Color.blue : Color.white)
       .cornerRadius(40)
       .overlay(
               RoundedRectangle(cornerRadius: 40)
                   .stroke(Color.blue, lineWidth: 1.5)
       
       ).onTapGesture {
           isSelected.toggle()
           
           if let action = action {
               action(isSelected)
           }
     
       }
   }
}

