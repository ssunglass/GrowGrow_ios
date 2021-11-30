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
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    let appleGothicRegular: String = "Apple SD Gothic Neo Regular"
    
    
    
    var body: some View {
        
      
        
        
        VStack(alignment: .center,spacing: 1){
            
            HStack{
                Divider()
                    .background(Color(hex: "#C5C5C5"))
                    .frame(height: 30)
            }
            
            Text(date)
                .font(.custom(appleGothicBold, size: 30))
                .foregroundColor(Color.black)
                .tracking(-1.5)
                .padding(.bottom,5)
                
            
            Text(description)
                .kerning(-0.6)
                .fixedSize(horizontal: false, vertical: true)
                .font(.custom(appleGothicRegular, size: 15))
                .foregroundColor(Color.black)
                .lineSpacing(6)
                .multilineTextAlignment(.center)
            
            
            
          /*  HStack{
                Divider()
                    .background(Color.black)
                    .frame(height: 30)
            }*/
            
        }
            
        
        
        
    }
    
  
}






