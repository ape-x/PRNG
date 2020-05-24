//
//  LinearFeedbackShiftRegister.swift
//  PRNG
//
//  Created by Mihnea Stefan on 24/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class LinearFeedbackShiftRegister : Convertible {
  
    //XOR GATE POSITIONS : 0 and 2, 6 and seed.count/2, seed.count/3 and 3
    var output : Int?
    var seed : [Int]?
    var converter : Converter
    
    init(seed : String){
        converter = Converter()
        let asciiCodes = transformToAscii(input: seed)
        self.seed = [Int]()
        for code in asciiCodes{
            self.seed! += code.binary
        }
    }
    
    //PROTOCOL METHODS
    
    func transformToBinary(input: [Int]) -> [[Int]] {
        return converter.transformToBinary(input: input)
      }
      
      func transformToAscii(input: String) -> [Int] {
        return converter.transformToAscii(input: input)
      }
      
      func transformBinaryToInt(input m: [Int]) -> Int {
        return converter.transformBinaryToInt(input: m)
      }
      
    //METHODS
    
    func produceOutput(){
        let product = (seed![0]^seed![2])^(seed![6]^seed![seed!.count/2])^(seed![seed!.count/3]^seed![3])
        shift(xor_product: product)
    }
    
    func shift(xor_product gate : Int){
        output = seed![seed!.count-1]
        for i in (1...seed!.count-1).reversed(){
            seed![i] = seed![i-1]
        }
        seed![0] = gate
    }
    
    
}
