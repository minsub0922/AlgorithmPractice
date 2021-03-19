//
//  String+.swift
//  AlgorithmPractice
//
//  Created by 최민섭 on 2021/03/19.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation
extension String{
    func getArrayAfterRegex(regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
