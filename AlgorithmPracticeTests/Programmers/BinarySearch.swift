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
    
    func testStones() {
        func solution(_ distance:Int, _ rocks:[Int], _ n:Int) -> Int {
            var _rocks = rocks.sorted()
            
            var l = 0, r = distance, mid = 0
            var ans = 0
            
            while l <= r {
                mid = (l+r)/2
                
                var pre = 0, count = 0
                for rock in _rocks {
                    if rock - pre < mid {
                        count += 1
                    } else {
                        pre = rock
                    }
                }
                
                if count <= n {
                    l = mid + 1
                    ans = max(ans, mid)
                } else {
                    r = mid - 1
                }
            }
             
            return ans
        }
        
        print(solution(25, [2,14,11,21,17], 2))
    }
}
