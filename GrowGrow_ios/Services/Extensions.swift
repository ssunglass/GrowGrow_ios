//
//  Extensions.swift
//  GrowGrow_ios
//
//  Created by 김세훈 on 2021/10/21.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            throw NSError()
        }
        return dictionary
        
    }
}

extension Decodable {
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension String {
    func splitString() -> [String] {
        
        var stringArray: [String] = []
        let trimmed = String(self.filter { !"\n\t\r".contains($0)})
        
      
        
        for (index, _) in trimmed.enumerated(){
            let prefixIndex = index+1
            let substringPrefix =
            String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix.trimmingCharacters(in: .whitespacesAndNewlines))
                               
            
        }
        return stringArray
    }
}

extension String {
    func stringFromDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}
