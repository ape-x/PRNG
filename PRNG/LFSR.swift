//
//  LFSR.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class LFSR : Convertible{
   
    var R = [[Int]]()
    var output = [Int]()
    var seed : String
    var seedAsciiValues = [Int]()
    var converter : Converter
    
    
    init(seed : String){
        self.seed = seed
        converter = Converter()
        seedAsciiValues = transformToAscii(input: seed)
        R = transformToBinary(input: seedAsciiValues)
    }
    
    func transformToAscii(input: String) -> [Int] {
        return converter.transformToAscii(input: input)
    }
    func transformToBinary(input : [Int])->[[Int]]{
        return converter.transformToBinary(input: input)
    }
    func transformToHex(input : Int)->String{
        return converter.transformToHex(input: input)
    }
    func transformBinaryToInt(input m : [Int])->Int{
        return converter.transformBinaryToInt(input : m)
    }
    func transformTo32(input : Int)->[Int]{
        return converter.transformTo32(input : input)
    }
    
    func startMachine(times_shifted turns : Int){
        for _ in 1...turns  {
        for i in 0..<R.count{
            produceoutput(for_lfsr: i)
            }
        }
        print(output)
    }
    func produceoutput(for_lfsr lfsr : Int){
        let gate = R[lfsr][1]^R[lfsr][5]
        shifting(xor_product: gate, lsfr_number: lfsr)
    }
    func shifting(xor_product gate : Int, lsfr_number lfsr : Int){
        output.append(R[lfsr][7])
        for i in (1...R[lfsr].count-1).reversed(){
            R[lfsr][i] = R[lfsr][i-1]
        }
        R[lfsr][0] = gate
    }
}
