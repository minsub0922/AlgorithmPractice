//
//  AlgorithmPracticeTests.swift
//  AlgorithmPracticeTests
//
//  Created by 최민섭 on 2020/09/02.
//  Copyright © 2020 최민섭. All rights reserved.
//

import XCTest
@testable import AlgorithmPractice

class AlgorithmPracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMarathon() throws {
        let participants: Set = ["marina", "josipa", "nikola", "vinko", "filipa"]
        let completions: Set = ["josipa", "filipa", "marina", "nikola"]
        
        let failures = participants.subtracting(completions)
        
        print(failures)
    }
    
    func testNumberBook() throws {
        var pb = ["12","123","1235","567","88"]
        pb.sort()
        var ans = true
        for i in 1..<pb.count {
            if pb[i].starts(with: pb[i-1]) {
                ans = false; break;
            }
        }
        
        print(ans)
    }
    
    func testCamouflage() throws {
        let clothes = [["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]
        var combi: [String : [String]] = [:]
        
        clothes.forEach { combi[$0[1], default: []].append($0[0]) }
        var ans = 1
        combi.forEach { ans *= ($1.count+1) }
        print(ans-1)
    }
    
    func testBestAlbum() throws {
        let genres: [String] = ["classic", "pop", "classic", "classic", "pop"]
        let plays: [Int] = [150, 600, 150, 800, 2500]
    
        struct Music { let genre: String, played: Int, index: Int }
        
        var music: [String: [Music]] = [:]
            
        genres.enumerated().map { Music(genre: $0.element,
                                        played: plays[$0.offset],
                                        index: $0.offset) }
            .forEach { music[$0.genre, default: []].append($0) }
        
        var res: [Int] = []
        
        music
            .sorted { $0.value.map { $0.played }.reduce(0,+) > $1.value.map { $0.played }.reduce(0,+) }
            .forEach {
                
                if $0.value.count == 1 { res.append($0.value[0].index) }
                else {
                    res.append(contentsOf: $0.value.sorted(by: { s1, s2 in
                        if s1.played == s2.played { return s1.index < s2.index }
                        else { return s1.played > s2.played }
                    })[0...1].map { $0.index })
                }
        }
        
        print(res)
    }
    
    func testStock() throws {
        let prices = [1,2,3,2,3]
        struct Stock { let price: Int, time: Int}
        let stocks = prices.enumerated().map { Stock(price: $0.element, time: $0.offset) }
        var stack: [Stock] = []
        var res: [Int] = prices.map { _ in 0 }
        
        stocks.enumerated().forEach { i, e in
            while !stack.isEmpty {
                if e.price < stack.last!.price {
                    if let item = stack.popLast() {
                        res[item.time] = i - item.time
                    }
                } else { break }
            }
            
            stack.append(e)
        }
        
        stack.forEach {
            res[$0.time] = res.count - 1 - $0.time
        }
        
        print(res)
    }
    
    func testFunctionDevelop() throws {
        let p = [93, 30, 55], s = [1, 30, 5]
        var res: [Int] = []
        
        var left: [Int] = zip(p, s).map { Int(ceil(Double(100-$0)/Double($1))) }
        
        while !left.isEmpty {
            let top = left.remove(at: 0)
            if top > 0 {
                res.append(1)
                left = left.map { $0 - top }
            }
            else { res[res.count-1] += 1 }
        }
        
        print(res)
    }
    
    func testTruckCrossingBridge() throws {
        let bridge_length = 100
        let weight = 100
        var truck_weights: [Int] = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
        var leftWeight = weight
        
        struct Truck { var weight, entryTime: Int}
        var stack: [Truck] = []
        var time: Int = 0
        
        while !truck_weights.isEmpty {
            let weight = truck_weights[0]
            time += 1
            
            if
                let top = stack.first,
                time - top.entryTime == bridge_length {
                leftWeight += stack.remove(at: 0).weight
            }
            
            if leftWeight >= weight {
                stack.append(Truck(weight: weight, entryTime: time))
                truck_weights.remove(at: 0)
                leftWeight -= weight
            }
        }
            
        print((stack.last?.entryTime ?? time) + bridge_length)
    }
    
    func testPriorityPrinter() throws {
        let priorities:[Int] = [1, 1, 9, 1, 1, 1]
        let location:Int = 0
        
        struct Object { let priority: Int, location: Int }
        var objects: [Object] = priorities.enumerated().map { Object(priority: $0.element, location: $0.offset) }
        var ans: [Object] = []
        
        while !objects.isEmpty {
            let top = objects.remove(at: 0)
            if objects.contains(where: { $0.priority > top.priority}) {
                objects.append(top)
            } else {
                ans.append(top)
            }
        }
        
        print(ans.lastIndex{ $0.location == location }! + 1)
    }
    
    
    
    func testMoreSpicy() throws {
        let scovile = [1, 2, 3, 9, 10, 12], k = 7
        
        while scovile.contains(where: { $0 < 7 }) {
            scovile.max()
        }
    }
    
    func mixscovile(_ a: Int, _ b: Int) -> Int { return a + b*2 }
    
    func testKNumber() throws {
        let array = [1, 5, 2, 6, 3, 7, 4]
        let commands = [[2, 5, 3], [4, 4, 1], [1, 7, 3]]
        
        let ans = commands.map { command -> Int in
            let i = command[0]
            let j = command[1]
            let k = command[2]
            
            return array[i-1...j-1].sorted()[k-1]
        }
    }
    
    func testBiggestNumber() throws {
        let numbers = [6, 10, 2]
        let strings = numbers.map { String($0) }.sorted { Int($0+$1)! > Int($1+$0)! }.reduce("",+)
        
         print(strings)
    }
    
    func testMathTerror() throws {
        let answer = [1,1,3,3,6,6,6,6,6]
        
        let numberOne = [1,2,3,4,5]
        let numberTwo = [2,1,2,3,2,4,2,5]
        let numberThree = [3,3,1,1,2,2,4,4,5,5]
        
        var corr: [Int:Int] = [:]
        
        answer.enumerated().forEach { i,e in
            if e == numberOne[i%numberOne.count] { corr[1, default: 0] += 1 }
            if e == numberTwo[i%numberTwo.count] { corr[2, default: 0] += 1 }
            if e == numberThree[i%numberThree.count] { corr[3, default: 0] += 1 }
        }
        
        //let max = corr.max { $0.value > $1.value }?.value
        let max = corr.max { $0.value > $1.value}?.value
        print(corr.filter { $0.value == max }.map { $0.key }.sorted())
        
    }
    
    func testFindPrime() throws {
        let numbers = "17"
        var number = numbers.map { Int(String($0))! }
        var v = number.map { _ in 0 }
        
        print(Set(nestedSearch(number: number, visited: v, s: "0")).count)
    }
    
    func nestedSearch(number: [Int], visited: [Int], s: String) -> [Int] {
        var arr: [Int] = []
        var isPrime = true
        if Int(s)! > 3 {
            for i in 2...Int(sqrt(Double(s)!)) {
                if(Int(s)! % i == 0) {
                    isPrime = false
                    break
                }
            }
        } else { isPrime = false }
        
        if isPrime || Int(s)! == 2 || Int(s)! == 3 {
            arr.append(Int(s)!)
        }
        
        var v = visited
        
        for (i,e) in number.enumerated() {
            if v[i] == 0 {
                v[i] = 1
                arr.append(contentsOf: nestedSearch(number: number, visited: v, s: s+String(e)))
                v[i] = 0
            }
        }
        
        return arr
    }
    
    func testCarpet() throws {
        let brown = 10, yellow = 2
        let sumXY = (brown+4) / 2
        var ans: [Int] = []
        print(Double(sumXY)/2.0)
        for i in Int(ceil(Double(sumXY)/2.0))..<sumXY {
            if (i-2) * (sumXY-i-2) == yellow {
                ans = [i, sumXY-i]
                break
            }
        }
        print(ans)
    }
    
    func testGymsuit() throws {
        let n = 3
        let lost = [3]
        let reserve = [1]
        
        var states: [Int] = (0..<n).map { _ in 1 }
        lost.forEach { states[$0-1] -= 1 }
        reserve.forEach { states[$0-1] += 1 }
        
        lost.forEach {
            let i = $0 - 1
            if states[i] > 0 { return }
            if i-1 > 0 && states[i-1] > 1 {
                states[i-1] -= 1
                states[i] += 1
            }
            else if i+1 < n && states[i+1] > 1 {
                states[i+1] -= 1
                states[i] += 1
            }
        }
    
        print(states.filter{ $0 > 0 }.count)
    }
    
    func testMakeBigNumber() throws {
        let number = "2111111111111111111111"
        let k = 4
        var stack: [Int] = []
        
        number
            .map { Int(String($0))! }
            .enumerated()
            .forEach { i,e in
                while stack.last ?? 10 < e {
                    if i-k > stack.count-1 { break }
                    stack.removeLast()
                }
                
                stack.append(e)
        }
        
        print(stack[0..<number.count-k].reduce("") { String($0) + String($1) })
    }
    
    func testJoystick() throws {
        let name: String = "ABAAAAAAAB"
        var words: [Word] =
            name
                .enumerated()
                .map { Word(word: String($0.element), index: $0.offset) }
                .filter { $0.value > 65 }

        var index = 0
        var ans = 0

        while !words.isEmpty {
            let distanceA = min(abs(index - words.first!.index), name.count - index + words.first!.index)
            let distanceB = min(abs(index - words.last!.index), name.count - words.last!.index + index)

            let word = distanceA <= distanceB ? words.removeFirst() : words.removeLast()
            let distance = min(distanceA, distanceB)

            print(word, costForWord(word: word), distance)
            ans += costForWord(word: word) + distance
            index = word.index
        }
        print(ans)
    }
    
    struct Word {
        let word: String, index: Int
        var value: Int { Int(UnicodeScalar(word)!.value) }
    }
    
    func costForWord(word: Word) -> Int {
        return min(word.value - 65, 91 - word.value)
    }
    
    // Kruskal && UnionParent && Minimal Spanning Tree
    var cycleTable = (0...101).compactMap { $0 }

    func find(node: Int) -> Int {
        if cycleTable[node] == node { return node}
        cycleTable[node] = find(node: cycleTable[node])
        return cycleTable[node]
    }
    
    func testConnectIsland() throws {
        let costs = [[0,1,1],[0,2,2],[1,2,5],[1,3,1],[2,3,8]]
        let sorted = costs.sorted(by: { $0[2] < $1[2] })
                
        var ans = 0
        sorted.forEach {
            let start = find(node: $0[0]), end = find(node: $0[1])
            if start == end { return }
            cycleTable[start] = min(start, end)
            cycleTable[end] = min(start, end)
            ans += $0[2]
        }
        
        print(ans)
    }
    
    var dp: [Int:Int] = [:]
    var values: [[Int]] = (0...8).compactMap { _ in [] }
    
    func testPresentToN() throws {
        let N = 5
        let number = 12
        
        values[1] = [N, -N]
        dp[N] = 1
        dp[-N] = 1
        
        (2...8).forEach { n in
            for i in 1..<n {
                for a in values[i] {
                    for b in values[n-i] {
                        let set: [Int?] = [
                            a*b, a+b, a-b, b-a,
                            a != 0 ? b / a : nil, b != 0 ? a / b : nil,
                        ]
                        
                        set
                            .compactMap { $0 }
                            .forEach {
                                values[n].append(contentsOf: [$0, -$0])
                                dp[$0, default: 9] = min(dp[$0, default: 9], n)
                                dp[-$0, default: 9] = min(dp[-$0, default: 9], n)
                        }
                    }
                    
                    values[n] = Array(Set(values[n]))
                }
                
                let sequence = Int((0..<n).map { _ in String(N) }.reduce("", +))!
                values[n].append(contentsOf: [sequence, -sequence])
                dp[sequence, default: 9] = min(dp[sequence, default: 9], n)
                dp[-sequence, default: 9] = min(dp[-sequence, default: 9], n)
            }
    
            
        }
        
        print(dp[number, default: -1])
    }
    
   
    
    func testTargetNumber() {
        let numbers = [1,1,1,1,1]
        let target = 3
        
        t = target
        number = numbers
        
        dfs(start: 0, sum: 0)
        
        print(ans)
    }
    
    var ans: Int = 0
       var number: [Int] = []
       var t: Int = 0
    
    func dfs(start: Int, sum: Int) {
        if start == number.count {
            if sum == t { ans += 1 }
            return
        }
        
        dfs(start: start+1, sum: sum + number[start])
        dfs(start: start+1, sum: sum - number[start])
    }
    
    
    
    func testNetwork() throws {
        let computers = [[1, 1, 0], [1, 1, 1], [0, 1, 1]]
        let n = 3
        var root: [Int] = (0...200).compactMap { $0 }
        
        for (index, element) in computers.enumerated() {
            let end = find(node: index)
            for (i, e) in element.enumerated() {
                if e == 1 {
                    let start = find(node: i)
                    if start != end {
                        root[start] = min(start, end)
                        root[end] = min(start, end)
                    }
                }
            }
        }
        
        func findParent(node: Int) -> Int {
            if root[node] == node { return node }
            root[node] = findParent(node: root[node])
            return root[node]
        }
        
        print(Set(root.prefix(upTo: n).map { findParent(node: $0) }).count)
    }
    
    func testWordTranslation() throws {
        let begin = "hit"
        let target = "cog"
        let words = ["hot", "dot", "dog", "lot", "log", "cog"]
        
        var visited: [Bool] = Array(repeating: false, count: words.count)
        var ans = 51
        
        func possibleToChange(a: String, b: String) -> Bool {
            return zip(a, b).filter { $0 != $1 }.count == 1
        }
        
        func dfs(word: String, depth: Int) {
            if word == target {
                ans = min(ans, depth)
                return
            }
            if depth == words.count { return }
            
            for (i,w) in words.enumerated() {
                if visited[i] == false && possibleToChange(a: w, b: word) {
                    visited[i] = true
                    dfs(word: w, depth: depth+1)
                    visited[i] = false
                }
            }
        }
        
        dfs(word: begin, depth: 0)
        ans == 51 ? 0 : ans
        print(ans)
    }
    
    func testImmigration() {
        let n = 6
        let times = [7,10]
        
        var left = 0
        var right = times.sorted().last! * n
        var ans: Int64 = Int64(right)
        
        while right >= left {
            var mid = (left + right) / 2
            
            var doneWorks = 0
            for time in times { doneWorks += mid / time }
            
            if doneWorks < n { left = mid + 1 }
            else {
                if mid <= ans { ans = Int64(mid)}
                right = mid - 1
            }
        }
        
        print(ans)
    }
    
    func testSteppingStone() throws {
        let distance = 25
        let rocks = [2, 14, 11, 21, 17]
        let n = 2
        
        var sorted = rocks.sorted()
        var ans = 0
        var left = 0
        var right = distance
         
        while left <= right {
            var count = 0
            var pre = 0
            let middle = (left + right) / 2
            
            for rock in rocks {
                if rock - pre < middle { count += 1 }
                else { pre = rock }
            }
            
            if distance - pre < middle { count += 1 }
            
            if count <= n {
                ans = max(ans, middle)
                left = middle + 1
            } else {
                right = middle - 1
            }
        }
        
        print(ans)
    }
    
    func testDiskController() throws {
        let jobs = [[0, 3], [1, 9], [2, 6]]
        var sorted = jobs.sorted {
            if $0[1] == $1[1] { return $0[0] < $1[0] }
            return $0[1] < $1[1]
        }
        
        var total = 0
        var time = 0
        
        while !sorted.isEmpty {
            for job in sorted {
                if job[0] <= time {
                    time += job[1]
                    total += time - job[0]
                    sorted.removeAll { $0 == job }
                    break
                }
                if job == sorted.last { time += 1 }
            }
        }
        
        print(total / jobs.count)
    }
    
    
}


 
