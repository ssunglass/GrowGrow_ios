//
//  SearchedView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/02.
//

import SwiftUI

struct SearchedView: View {
    
    var inputKeyword: String
    var inputDeparts: [String]
    var inputRegions: String?
    
    
    var body: some View {
        VStack{
        Text(inputKeyword)
        Text(inputRegions ?? "")
            
            ForEach(inputDeparts, id: \.self){input in
                Text(input)
            }
            
            
        }
            .navigationTitle("검색된 유저")
    }
}


