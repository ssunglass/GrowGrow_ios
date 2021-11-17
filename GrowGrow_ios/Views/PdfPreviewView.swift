//
//  PdfPreviewView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/16.
//

import SwiftUI
import PDFKit


struct PdfPreviewView: View {
    
    @EnvironmentObject private var contentViewModel : ContentViewModel
    @StateObject private var viewModel = SessionStore()
    @EnvironmentObject var session: SessionStore
    
    let appleGothicBold: String = "Apple SD Gothic Neo Bold"
   
    
    
    var body: some View {
        VStack{
            
            
            PdfViewUI(data: contentViewModel.pdfData())
                
            Button(action: {}, label: {
                Text("공유")
                    .foregroundColor(.white)
                    .font(.custom(appleGothicBold, size: 24))
                
            })
                .frame(maxWidth: 100, maxHeight: 35)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "#646464")))
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#646464"), lineWidth: 1)
                
                )
            
            Spacer()
            
            
        }
        .navigationTitle("나의 커리어")
        .navigationBarTitleDisplayMode(.inline)
       
    }
}



struct PdfViewUI : UIViewRepresentable {
    
    
    private var data: Data?
    
    private let autoScales: Bool
    
    
    init(data: Data?, autoScales : Bool = true){
        self.data = data
        self.autoScales = autoScales
        
    }
    
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        
        pdfView.autoScales = self.autoScales
        
        if let data = self.data {
            pdfView.document = PDFDocument(data: data)
        }
        
        
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
    
    
    
    
    
}
