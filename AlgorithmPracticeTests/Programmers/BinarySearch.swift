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
    func testImmigration2() {
        func solution(_ n:Int, _ times:[Int]) -> Int64 {
            var l=0, r=times.max()! * n
            var mid = (l+r)/2
            var ans = Int.max
            
            while l <= r {
                mid = (l+r)/2
                
                let tested = times.reduce(0){ $0 + mid/$1 }
                if n > tested {
                    l = mid + 1
                } else {
                    r = mid - 1
                    ans = mid
                }
            }
            
            return Int64(ans)
        }

        print(solution(6, [7,10]))
    }
}
