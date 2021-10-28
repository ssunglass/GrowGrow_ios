//
//  JsonParsing.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/26.
//

import Foundation
import SwiftUI

struct DataSearch: Codable {
    let dataSearch: Contents
    
    
}

struct Contents: Codable {
    let content: [MajorInfo]
}

struct MajorInfo: Hashable,Codable {
    let lClass: String
    let facilName: String
    let majorSeq: String
    let mClass: String
    let totalCount: String
    
    
}

class ViewModel: ObservableObject {
    @Published var contents: [MajorInfo] = []
    @Published var majors: [String] = []
    
    func getJson(urlString: String){
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //Convert to JSON
            
            do {
                let datas = try
                JSONDecoder().decode(DataSearch.self, from: data)
                
                DispatchQueue.main.async {
                    self?.contents = datas.dataSearch.content
                    
                    
                    
                }
                
                
                
                
            } catch{
                print(error)
            }
            
            
        }
         
         task.resume()
        
      

        
    }
    
    
}

