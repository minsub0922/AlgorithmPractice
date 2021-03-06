//
//  BinarySearch.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2021/03/04.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation

import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testPresentWithN() {
        func solution(_ N:Int, _ number:Int) -> Int {
            if N == number { return 1}
            
            var d: [Set<Int>] = []

            (1..<9).forEach { i in
                d.append(Set([Int([String](repeating: String(N), count: i).reduce("") { $0 + $1 })!]))
            }
            
            for i in (1...8) {
                for j in (0..<i) {
                    for op1 in d[j] {
                        for op2 in d[i-j-1] {
                            d[i].insert(op1+op2)
                            d[i].insert(op1-op2)
                            d[i].insert(op1*op2)
                            if op2 != 0 { d[i].insert(op1/op2) }
                        }
                    }
                }
                
                if d[i].contains(number) {
                    return i+1
                }
            }
            return -1
        }
        
        print(solution(5, 12))
    }
}
