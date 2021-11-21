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
     
     let tableDataItems: [AllBios]
     let defaultOffset: CGFloat = 20
     let defaultXValue: CGFloat = 62
     @State var firstOffset: CGFloat = 300

    /**
    W: 8.5 inches * 72 DPI = 612 points
    H: 11 inches * 72 DPI = 792 points
    A4 = [W x H] 595 x 842 points
    */
    init(pageRect : CGRect =
         CGRect(x: 0, y: 0, width: (8.5 * 72.0), height: (11 * 72.0)), tableDataItems: [AllBios]) {
       
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [kCGPDFContextTitle: "커리어 프로필",
            kCGPDFContextAuthor: "커커"]

        format.documentInfo = metaData as [String: Any]
        self.pageRect = pageRect
        self.renderer = UIGraphicsPDFRenderer(bounds: self.pageRect,
                                             format: format)
        
        self.tableDataItems = tableDataItems
        super.init()
    }
}

extension PdfCreator {
    private func addTop (fullname  : String, depart: String, drawContext: CGContext ){
        let textRect = CGRect(x: defaultXValue, y: 64,
                         width: pageRect.width - 40 ,height: 40)
        let departRect = CGRect(x: defaultXValue, y: textRect.maxY + 15, width: pageRect.width - 40, height: 20)
        
        
        let nameAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 36),
            NSAttributedString.Key.foregroundColor :  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            
           // NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)
        
        ]
        
        let departAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.654, green: 0.654, blue: 0.654, alpha: 1),
            NSAttributedString.Key.kern: -1.8
        
        ] as [NSAttributedString.Key : Any]
        
        fullname.draw(in: textRect,withAttributes: nameAttributes as [NSAttributedString.Key : Any])
        depart.draw(in: departRect, withAttributes: departAttributes as [NSAttributedString.Key : Any])
        
        drawLine(drawContext, drawY: departRect.maxY + 30, drawX: 300)
        drawBoldLine(drawContext, drawY: departRect.maxY + 30, drawX: 300, spacing: 40)
        
       
    }
    
    private func addMid(summary: String, drawContext: CGContext){
      
         let summaryRect = CGRect(x: defaultXValue, y: 185, width: pageRect.width - 40, height: 50)
        
        let titleRect = CGRect(x: defaultXValue, y: 280, width:  pageRect.width - 40, height: 35)
        let title: String = "Career / Project"
        
        
        let summaryAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16),
            NSAttributedString.Key.foregroundColor :  UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.kern: -1.6
        
        ] as [NSAttributedString.Key : Any]

        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 24),
            NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.kern: -1.2
        
        ] as [NSAttributedString.Key : Any]
        
       
        summary.draw(in: summaryRect, withAttributes: summaryAttributes)
        title.draw(in: titleRect, withAttributes: titleAttributes)
        
        drawLine(drawContext, drawY: summaryRect.maxY + 30, drawX: 450)
        drawBoldLine(drawContext, drawY: summaryRect.maxY + 30, drawX: 450, spacing: 40)
       
        
    }
    
   /* private func addBody (body : String, bios: [AllBios]) {
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
        
        
    } */
    
    private func drawLine(_ drawContext: CGContext, drawY: CGFloat, drawX: CGFloat){
        
        drawContext.saveGState()
          // 3
          drawContext.setLineWidth(1.0)
        
        drawContext.move(to: CGPoint(x: defaultXValue, y: drawY))
         drawContext.addLine(to: CGPoint(x: defaultXValue + drawX, y: drawY))
        drawContext.setFillColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
         drawContext.strokePath()
         drawContext.restoreGState()
        
       
        
        
        
    }
    
    private func drawBoldLine(_ drawContext: CGContext, drawY: CGFloat, drawX: CGFloat, spacing: CGFloat){
        
        drawContext.saveGState()
          // 3
          drawContext.setLineWidth(3.0)
        
        drawContext.move(to: CGPoint(x: defaultXValue + drawX , y: drawY))
         drawContext.addLine(to: CGPoint(x: defaultXValue + drawX + spacing, y: drawY))
        drawContext.setFillColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1)
         drawContext.strokePath()
         drawContext.restoreGState()
        
        
        
    }
    
    private func drawCircle(_ drawContext: CGContext, drawY: CGFloat, drawX: CGFloat){
        
        drawContext.saveGState()
        drawContext.setLineWidth(2)
        
        drawContext.setFillColor(red: 0.387, green: 0.387, blue: 0.387, alpha: 1)
        drawContext.addEllipse(in: CGRect(x: drawX, y: drawY, width: 5, height: 5))
        drawContext.drawPath(using: .fillStroke)
        drawContext.restoreGState()
        
    }
    
    func drawBios(drawContext: CGContext, pageRect: CGRect, tableDataItems: [AllBios], perPageOffset: CGFloat, isLast: Bool) {
        drawContext.setLineWidth(1.0)
        drawContext.saveGState()

        let defaultStartY = defaultOffset * 5

        for elementIndex in 0..<tableDataItems.count {
            
           
            
            let yPosition = CGFloat(elementIndex) * defaultStartY + defaultStartY

            // Draw content's elements texts
            let textFont = UIFont.systemFont(ofSize: 13.0, weight: .regular)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            let descriptStyle = NSMutableParagraphStyle()
            descriptStyle.alignment = .left
            descriptStyle.lineBreakMode = .byWordWrapping
            descriptStyle.lineSpacing = 5
            
            
            let dateAttributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 24),
                NSAttributedString.Key.foregroundColor :  UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                
            ] as [NSAttributedString.Key : Any]
            
            let descriptiontAttributes = [
                NSAttributedString.Key.paragraphStyle: descriptStyle,
                NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 11),
                NSAttributedString.Key.kern: -0.55
                
            ] as [NSAttributedString.Key : Any]
            
            
            
            let tabWidth = (pageRect.width - defaultOffset * 2) / CGFloat(3)
            
            for titleIndex in 0..<2 {
                var attributedText = NSAttributedString(string: "", attributes: dateAttributes)
                switch titleIndex {
                case 0: attributedText = NSAttributedString(string: tableDataItems[elementIndex].date, attributes: dateAttributes)
                case 1: attributedText = NSAttributedString(string: tableDataItems[elementIndex].description, attributes: descriptiontAttributes)
               
                default:
                    break
                }
                let tabX = CGFloat(titleIndex) * tabWidth
                let textRect = CGRect(x: tabX + defaultOffset,
                                      y: yPosition + perPageOffset,
                                      width: tabWidth,
                                      height: defaultOffset * 6)
                attributedText.draw(in: textRect)
            }

            // Draw content's 3 vertical lines
            //for verticalLineIndex in 0..<3 {
                let tabX = CGFloat(1) * tabWidth
                drawContext.setLineWidth(1)
                drawContext.move(to: CGPoint(x: tabX + defaultOffset - 35, y: yPosition + perPageOffset ))
                drawContext.addLine(to: CGPoint(x: tabX + defaultOffset - 35, y: yPosition + perPageOffset + defaultOffset * 5 ))
           
               drawContext.strokePath()
            //}
            
            if(elementIndex == tableDataItems.count - 1 && isLast == true) {
                
                drawCircle(drawContext, drawY: yPosition + defaultStartY + 15, drawX: tabX + defaultOffset - 37.5)
                
                
            }
            
           

            // Draw content's element bottom horizontal line
           // drawContext.move(to: CGPoint(x: defaultOffset, y: yPosition + defaultStartY))
           // drawContext.addLine(to: CGPoint(x: pageRect.width - defaultOffset, y: yPosition + defaultStartY))
           // drawContext.strokePath()
        }
        drawContext.restoreGState()
    }
}

extension PdfCreator {
    func pdfData( fullname : String, depart: String, summary:String, body: String, bios: [AllBios] ) -> Data? {
        
        let numberOfElmentsPerPage = calculateNumberofElmentsperPage(with: pageRect)
        let tableDataChunked: [[AllBios]] = tableDataItems.chunkedElements(into: 4)
        
        
        //tableDataChunked의 첫번째 elements와 그이외의 elements들로 나누어서 pdf생성
        print(tableDataChunked[0])
        
        if let renderer = self.renderer {

            let data = renderer.pdfData  { ctx in
              //  ctx.beginPage()
               
                
                let context = ctx.cgContext
                var pageNumber: Int = 1
                
                
                for tableDataChunk in tableDataChunked {
                   
                    
                   
                    if pageNumber == 1 {
                        
                        ctx.beginPage()
                        
                    
                            
                        addTop(fullname: fullname, depart: depart, drawContext: context)
                 
                        
                        addMid(summary: summary, drawContext: context)
                        
                        
                        
                        drawBios(drawContext: context, pageRect: pageRect, tableDataItems: tableDataChunk, perPageOffset: 240, isLast: false)
                        
                        
                    } else {
                        ctx.beginPage()
                        
                        
                        if pageNumber == tableDataChunked.endIndex {
                            
                            drawBios(drawContext: context, pageRect: pageRect, tableDataItems: tableDataChunk, perPageOffset: defaultOffset, isLast: true)
                            
                            
                            
                        } else {
                            
                            drawBios(drawContext: context, pageRect: pageRect, tableDataItems: tableDataChunk, perPageOffset: defaultOffset, isLast: false)
                            
                            
                        }
                        
                        
                    /*    drawBios(drawContext: context, pageRect: pageRect, tableDataItems: tableDataChunk, perPageOffset: defaultOffset, isLast: true)
                        
                       
                        
                        print(pageNumber)
                        print(tableDataChunked.endIndex)
                        */
                      
                        
                        
                        
                    }
                
              
               
               
            
                   
                   
                   
                    pageNumber = pageNumber + 1
                    
                 
                    
                 
                    
                }
              
                
                
               
            }
            return data
        }
        return nil
    }
    
    func calculateNumberofElmentsperPage(with pageRect: CGRect) -> Int {
        
      
        
        let rowHeight = (defaultOffset * 6)
        let belowHeight = (defaultOffset * 1)
        let number = Int((pageRect.height - rowHeight - belowHeight) / rowHeight)
        
        return number
        
        
        
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
       return PdfCreator(tableDataItems: bios).pdfData(fullname: fullname,
                                   depart: depart,
                                   summary:summary,
                                   body: body,
                                   bios: bios)
   }

}

 struct PdfBioDataItem {
    var date : String
    var description: String
    
    init(date: String, description: String) {
        self.date = date
        self.description = description
    }
    
    
    
}


extension Array {
    func chunkedElements(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    
}



  

    

