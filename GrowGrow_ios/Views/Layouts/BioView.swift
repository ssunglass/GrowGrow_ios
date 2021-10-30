//
//  BioView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/29.
//

import SwiftUI

struct BioView: View {
    var date:String
    var description: String
    
    
    
    var body: some View {
        
      
        
        
        VStack(alignment: .center){
            
            HStack{
                Divider()
                    .background(Color.black)
                    .frame(height: 30)
            }
            
            Text(date)
            
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
            
            
            
          /*  HStack{
                Divider()
                    .background(Color.black)
                    .frame(height: 30)
            }*/
            
        }
            
        
        
        
    }
    
  
}






