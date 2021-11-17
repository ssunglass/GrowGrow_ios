//
//  PdfConverter.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/11/16.
//

import SwiftUI
import PDFKit

 class PdfCreator : NSObject {
    private var pageRect : CGRect
    private var renderer : UIGraphicsPDFRenderer?

    /**
    W: 8.5 inches * 72 DPI = 612 points
    H: 11 inches * 72 DPI = 792 points
    A4 = [W x H] 595 x 842 points
    */
    init(pageRect : CGRect =
        CGRect(x: 0, y: 0, width: (8.5 * 72.0), height: (11 * 72.0))) {
       
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [kCGPDFContextTitle: "It's a PDF!",
            kCGPDFContextAuthor: "TechChee"]

        format.documentInfo = metaData as [String: Any]
        self.pageRect = pageRect
        self.renderer = UIGraphicsPDFRenderer(bounds: self.pageRect,
                                             format: format)
        super.init()
    }
}

extension PdfCreator {
    private func addTop (fullname  : String, depart: String ){
        let textRect = CGRect(x: 60, y: 60,
                         width: pageRect.width - 40 ,height: 40)
        let departRect = CGRect(x: 60, y: textRect.height + 50, width: pageRect.width - 40, height: 16)
        
        
        let nameAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        
        ]
        
        let departAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        
        ]
        
        fullname.draw(in: textRect,withAttributes: nameAttributes)
        depart.draw(in: departRect, withAttributes: departAttributes)
    }
    
    private func addMid(summary: String){
      
         let summaryRect = CGRect(x:60, y: 180, width: pageRect.width - 40, height: 40)
        
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        
        ]

        
       
        summary.draw(in: summaryRect, withAttributes: attributes)
       
        
    }
    
    private func addBody (body : String, bios: [AllBios]) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor : UIColor.gray
        ]
        
        
        
        let bodyRect = CGRect(x: 20, y: 230,
                              width: pageRect.width - 40 ,height: pageRect.height - 80)
        
        let bioDescriptionRect = CGRect(x: 100, y: 230,
                              width: pageRect.width - 40 ,height: pageRect.height - 80)
        
        
        body.draw(in: bodyRect, withAttributes: attributes)
        
        for bio in bios {
            bio.date.draw(in: bodyRect, withAttributes: attributes)
            bio.description.draw(in: bioDescriptionRect, withAttributes: attributes)
        }
        
        
    }
    
    private func drawLine(_ drawContext: CGContext){
        
        drawContext.saveGState()
          // 3
          drawContext.setLineWidth(1.0)
        
        drawContext.move(to: CGPoint(x: 40, y: 20))
         drawContext.addLine(to: CGPoint(x: 100, y: 20))
         drawContext.strokePath()
         drawContext.restoreGState()
        
        
        
    }
}

extension PdfCreator {
    func pdfData( fullname : String, depart: String, summary:String, body: String, bios: [AllBios] ) -> Data? {
        if let renderer = self.renderer {

            let data = renderer.pdfData  { ctx in
                ctx.beginPage()
                //ctx.beginPage()
                
                let context = ctx.cgContext
                
                
                
                
                addTop(fullname: fullname, depart: depart)
                addMid(summary: summary)
                addBody(body: body, bios: bios)
                
                drawLine(context)
                
               
            }
            return data
        }
        return nil
    }
}

struct Content{
    var fullname : String = "김민국"
    var depart : String = "미술계열, 첨단시각디자인과"
    var summary : String = "글도 쓰고, 프로젝트도 합니다."
    var body : String = "Career / Project"
    var bios = [AllBios]()
}

class ContentViewModel : ObservableObject {
    @Published private var content = Content()
    
    
    var fullname : String {
        get { content.fullname }
        set (newFullname){
           content.fullname = newFullname
        }
    }
    
    var depart : String {
        get { content.depart }
       set (newDepart){
           content.depart = newDepart
       }
    }
    
    var summary : String {
        get { content.summary }
       set (newSummary){
           content.summary = newSummary
       }
    }

    var body : String {
       get { content.body }
       set (newBody){
           content.body = newBody
       }
    }
    
    var bios : [AllBios] {
        get { content.bios }
       set (newBios){
           content.bios = newBios
       }
    }
}

extension ContentViewModel {
    
    func pdfData() -> Data? {
       return PdfCreator().pdfData(fullname: fullname,
                                   depart: depart,
                                   summary:summary,
                                   body: body,
                                   bios: bios)
   }

}

