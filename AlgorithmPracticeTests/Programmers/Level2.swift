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
}
