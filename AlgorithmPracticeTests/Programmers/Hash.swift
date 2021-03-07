//
//  Hash.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2021/03/07.
//  Copyright © 2021 최민섭. All rights reserved.
//

import Foundation
import XCTest
@testable import AlgorithmPractice

extension AlgorithmPracticeTests {
    func testAtheles() {
        func solution(_ clothes:[[String]]) -> Int {
            
            var dic: [String:[String]] = [:]
            
            clothes.forEach {
                dic[$0[1], default: []].append($0[0])
            }
            
            return dic.values.map { $0.count }.reduce(1) { ($0)*($1+1) } - 1
        }
        
        print(solution([["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]]    ))
    }
    
    func testBestAlbum2() {
        func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
            
            var dic: [String: [(Int,Int)]] = [:]
            
            zip(genres, plays)
                .enumerated()
                .forEach {
                    dic[$1.0, default: []].append(($1.1, $0))
            }
            
            return dic
                .map {
                    (
                        $1.reduce(0) { $0 + $1.0 },
                        $1.sorted {
                            if $0.0 == $1.0 { return $0.1 < $1.1 }
                            return $0.0 > $1.0
                        }
                    )}
                .sorted { $0.0 > $1.0 }
                .flatMap { $0.1.map { $0.1 }.prefix(2) }
        }
        
        print(solution(["classic", "pop", "classic", "classic", "pop"],
                       [500, 600, 150, 800, 2500]    ))
    }
}
