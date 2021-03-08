//
//  Level2.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2021/03/07.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testNormalRectangle() {
        func solution(_ w:Int, _ h:Int) -> Int64{
            func fetchGCD(_ a: Int, _ b: Int) -> Int64 {
                if a == 0 { return Int64(b) }
                return fetchGCD(b%a, a)
            }
            
            let gcd = fetchGCD(w, h)
            let w64 = Int64(w)
            let h64 = Int64(h)
            return w64*h64 - w64 - h64 + gcd
        }
        
        print(solution(8, 12))
    }
    
    func testSkillTree() {
        func solution(_ skill:String, _ skill_trees:[String]) -> Int {
            
//            var dic: [String: Int] = [:]
//            for (i,s) in skill.enumerated() {
//                dic[String(s)] = i
//            }
//
//            return skill_trees
//                .map { $0.map { String($0) } }
//                .map { $0.filter { dic[$0, default: -1] != -1 } }
//                .filter { $0.enumerated().filter { dic[$0.element] != $0.offset }.count == 0 }
//                .count
            
            return skill_trees
                .filter { skill.starts(with: $0.filter { skill.contains($0) })  }
                .count
        }
        
        print(solution("CBD"    , ["BACDE", "CBADF", "AECB", "BDA"]    ))
    }
}
