//
//  SHA.swift
//  PRNG
//
//  Created by Mihnea Stefan on 01/06/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


class SHA : Convertible {
  
    var H : [Int] = [0,0,0,0,0]
    var messageDigest : String?
    var input : String
    var converter : Converter
    
    init(seed : String){
        input = seed
        converter = Converter()
    }
    
    //Protocol methods
    
    func transformToBinary(input: [Int]) -> [[Int]] {
        return converter.transformToBinary(input: input)
      }
      
      func transformToAscii(input: String) -> [Int] {
        return converter.transformToAscii(input: input)
      }
      
      func transformBinaryToInt(input m: [Int]) -> Int {
        return converter.transformBinaryToInt(input: m)
      }
    
    
    //Class methods
    func preprocessing()->[Int]{
        var binary = [Int]()
        for c in input{
            binary+=Int(c.asciiValue!).binary
        }
        let l = binary.count
        var k = 448-((l%512)+1)
        binary.append(1)
        if k<0{
            k = k*(-1)
            k = 512-k
        }
        for _ in 0..<k{
            binary.append(0)
        }
        for _ in 0..<l.binary.count{
            binary.append(0)
        }
        binary+=l.binary
        return binary
    }
    
    func hashComputation(){
        var m = preprocessing()
        var M = [[Int]]()
        
    }
    
    
    
}
