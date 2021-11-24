//
//  PersonalInfoWebView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/21.
//

import SwiftUI
import WebKit
struct PersonalInfoWebView: UIViewRepresentable {
   
    
    var urlToLoad: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        
        guard let url = URL(string: self.urlToLoad) else {
            
            return WKWebView()
        }
        
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<PersonalInfoWebView>) {
        
    }
}

struct PersonalInfoWebView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoWebView(urlToLoad: "")
    }
}
