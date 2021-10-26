//
//  SearchView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

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
    
     func getJson(){
        guard let url = URL(string: "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=8fa1b6fffaf969b85712d6ea45a921fd&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&univSe=univ&subject=100391") else {return}
        
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

struct SearchView: View {
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        
        List{
            ForEach(viewModel.contents, id: \.self){ content in
                HStack {
                    
                    Text(content.mClass)
                    
                }
            }
            
        }
        .onAppear{
            viewModel.getJson()
        }
        
        
    
       
    
       
    }
    
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}



