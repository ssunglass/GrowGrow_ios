//
//  SearchView.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/22.
//

import SwiftUI


struct SearchView: View {
    @State var text = ""
    @State var chips: [[ChipData]] = []
    
    
    
    var body: some View {
        
      
        VStack(spacing: 30){
        
            LazyVStack(alignment: .leading,spacing:10){
                
                ForEach(chips.indices, id: \.self){ index in
                    
                    HStack{
                        
                        ForEach(chips[index].indices, id: \.self ){chipIndex in
                            
                            Text(chips[index][chipIndex].chipText)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(Capsule().stroke(Color.black,lineWidth:1))
                                .lineLimit(1)
                            
                                .overlay(
                                    GeometryReader{ reader -> Color in
                                        
                                        
                                        let maxX = reader.frame(in: .global).maxX
                                        
                                        if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded {
                                            DispatchQueue.main.async {
                                                
                                                chips[index][chipIndex].isExceeded = true
                                                let lastItem = chips[index][chipIndex]
                                                
                                                chips.append([lastItem])
                                                chips[index].remove(at:  chipIndex)
                                            }
                                            
                                        }
                                        
                                        return Color.clear


                                        
                                    },
                                    alignment: .trailing
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    //Removing Data..
                                    chips[index].remove(at: chipIndex)
                                    
                                    if chips[index].isEmpty {
                                        chips.remove(at: index)
                                    }
                                }
                               
                        }
                        
                    }
                    
                    
                }
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4),lineWidth:  1.5))
            
            
            TextEditor(text: $text)
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4),lineWidth:  1.5))
                
       
            
            Button(action: {
                
                
                //Adding Empty Array if there is Nothing
                if chips.isEmpty {
                    chips.append([])
                }
                
                withAnimation(.default){
                    
                    chips[chips.count - 1].append(ChipData(chipText: text))
                    
                    text = ""
                    
                    
                }
                
              
                
            }, label: {
                Text("Add Tag")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(4)
            }) .disabled(text == "")
                .opacity(text == "" ? 0.45 : 1 )
                
                
            
        

        }
        .padding()
        
       
    
       
    }
    
}

struct ChipData: Identifiable, Hashable {
    var id = UUID().uuidString
    var chipText : String
    var isExceeded = false
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}



