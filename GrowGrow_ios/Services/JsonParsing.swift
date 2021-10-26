//
//  JsonParsing.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/26.
//

import Foundation

class JsonParsing {
    

struct ComplexJson: Codable {
    let dataSearch: MajorContent
    
}

struct MajorContent: Codable {
    let content: [MajorData]
    
    
}

struct MajorData: Codable {
    let mclass: String
    
    
}

func getJson(){
    
    if let url = URL(string: "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391"){
        var request = URLRequest.init(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            if let json = try?decoder.decode(ComplexJson.self, from:  data){
                print(json.dataSearch)
                
            }
            
        }
        
        
    }
    
    
    
}
}
