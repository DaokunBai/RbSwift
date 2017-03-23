//
//  Array+Patch.swift
//  SwiftPatch
//
//  Created by draveness on 16/03/2017.
//  Copyright © 2017 draveness. All rights reserved.
//

import Foundation

public extension Array {
    
    /// When invoked with a closure, pass all combinations of length n of elements
    /// from the array and then returns the array itself.
    /// The implementation makes no guarantees about the order in which the combinations are yielded.
    ///
    /// - Parameters:
    ///   - num: The length of combination in the returning array
    ///   - closure: A closure called each time finds a new combination
    /// - Returns: An new array with all the possible combination in the receiver array
    @discardableResult func combination(_ num: Int, closure: (([Element]) -> Void)? = nil) -> [[Element]] {
        guard num.isPositive && !self.isEmpty else { return [] }
        guard num <= self.length else { return [[]] }
        var bits = Array<Int>(Array<Int>(0..<num).reversed())
        
        func lastBit() -> Int? {
            for (index, bit) in bits.enumerated() {
                if bit + index < self.length - 1 {
                    bits[index] += 1
                    return bit
                }
            }
            return nil
        }
        
        var results: [[Element]] = []
        
        while true {
            var result: [Element] = []
            for index in bits.reversed() {
                result.append(self[index])
            }
            if let closure = closure { closure(result) }
            results.append(result)
            if lastBit() == nil {
                break
            }
        }
        return results
    }
    
    @discardableResult func repeatedCombination(_ num: Int, closure: (([Element]) -> Void)? = nil) -> [[Element]] {
        guard num.isPositive && !self.isEmpty else { return [] }
        var bits = Array<Int>(Array<Int>(repeating: 0, count: num).reversed())
        
        func lastBit() -> Int? {
            for (index, bit) in bits.enumerated() {
                print("\(bits)")
                if bit < self.length - 1 {
                    bits[index] += 1
                    return bit
                } else if index < bits.length - 1 {
                    print("+ before: \(bits) \(index)")
                    bits[index+1] += 1
                    bits[index] = index + 1
                    print("+ after : \(bits)")
                    if bits[index] + 1 {
                        <#code#>
                    }
                }
            }
            return nil
        }
        
        var results: [[Element]] = []
        
        while true {
            var result: [Element] = []
            for index in bits.reversed() {
                result.append(self[index])
            }
            if let closure = closure { closure(result) }
            results.append(result)
            if lastBit() == nil {
                break
            }
        }
        return results
    }
    
    /// Extracts the nested value specified by the sequence of idx objects by
    /// calling dig at each step, returning nil if any intermediate step is nil.
    ///
    /// - Parameter idxs: A sequence of int specify the value location in the recevier array.
    /// - Returns: An value in the nested array or nil
    func dig<T>(_ idxs: Int...) -> T? {
        return dig(idxs)
    }
    
    /// Extracts the nested value specified by the sequence of idx objects by 
    /// calling dig at each step, returning nil if any intermediate step is nil.
    ///
    /// - Parameter idxs: A sequence of int specify the value location in the recevier array.
    /// - Returns: An value in the nested array or nil
    func dig<T>(_ idxs: [Int]) -> T? {
        guard self.length > 0 else { return nil }
        guard let firstIdx = idxs.first else { return nil }
        guard firstIdx < self.length else { return nil }
        let element = self[firstIdx]
        if let element = element as? [T] {
            return element.dig(idxs.drop(1))
        } else if idxs.count == 1 {
            return element as? T
        } else {
            return nil
        }
    }
}


