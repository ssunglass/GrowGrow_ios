//
//  ButtonModifiers.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import SwiftUI

struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title:String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
    
    private let cornerRadius: CGFloat = 15
    
    internal init(title:String,
                  background: Color = .blue,
                  foreground:Color = .white,
                  border:Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler, label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(RoundedRectangle(cornerRadius: 15).fill(background))
                .foregroundColor(foreground)
                .font(.custom(appleGothicBold, size: 24))
                .cornerRadius(cornerRadius)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(border, lineWidth: 1.5))
                .padding(.vertical,5)
        })
            
    }
    
}


