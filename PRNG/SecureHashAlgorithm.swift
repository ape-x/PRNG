//
//  SecureHashAlgorithm.swift
//  PRNG
//
//  Created by Mihnea Stefan on 14/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class SHA1 : Convertible{
    
    let H0 : UInt32 = 0x67452301
    let H1 : UInt32 = 0xEFCDAB89
    let H2 : UInt32 = 0x98BADCFE
    let H3 : UInt32 = 0x10325476
    let H4 : UInt32 = 0xC3D2E1F0
    
    
 
    var input : String
    var converter : Converter
    var messageLength : Int
    
    init(input : String){
        self.input = input
        converter = Converter()
        messageLength = input.count
    }
    
    func hash(){
        let asciiCodes = transformToAscii(input: input) // conversion of text input to ascii
        let binaries = transformToBinary(input: asciiCodes)//conversion of ascii to binary
        var num = numString(input: binaries)
        var M = [[[Int]]]()
        var matrix = [[Int]]()
        var array = [Int]()
        var k = 0x0
        var N = num.count/512 // Number of messages
        
        for _ in 1...N{
            for _ in 0..<16{
            for _ in 0..<32{
                array.append(num[0])
                num.remove(at: 0)
            }
            matrix.append(array)
            array = []
        }
            M.append(matrix)
            matrix = []
        }
        //          HEX
       var P = M[0]
       var W = [String]()
        
        for i  in 0..<P.count{
            W.append(converter.transformToHex(input: converter.transformBinaryToAscii(input: P[i])))
            if W[i].count<8{
                var s : [Character] = W[i].reversed()
                while s.count<8{
                    s.append("0")
                }
                W[i] = String(s.reversed())
            }
        }
        print(W)
        print(P)
        //          HEX^
        
        var A = H0
        var B = H1
        var C = H2
        var D = H3
        var E = H4
        
        for i in 0...79{
            if i >= 0 && i <= 19{
                //x^y XOR not x ^ z
                k = 0xA827999
            }
            if i >= 20 && i <= 39{
                //x XOR y XOR z
                
                k = 0x6ED9EBA1
            }
            if i >= 40 && i <= 59{
                //(x^y) XOR (x^z) XOR (y^z)
                
                k = 0x8F1BBCDC
            }
            if i >= 60 && i <= 79{
                //x XOR y XOR z
                
                k = 0xCA62C1D6
            }
        }
        
    }
    
    func wordProcessing(M : [[Int]])->[[Int]]{
       var r = [[Int]]()
        var w = M
        for t in 16...79{
            
        }
        
        
        return r
    }
  
    func logicalOne(B : [Int], C : [Int], D : [Int])->[Int]{
           var t = [Int]()
           for i in 0..<32{
               t.append((B[i]&C[i])|(~B[i])&D[i])
           }
           return t
       }
       
    func logicalTwo(B : [Int], C : [Int], D : [Int])->[Int]{
        var t = [Int]()
            for i in 0..<32{
                t.append(B[i]^C[i]^D[i])
            }
            return t
    }

    func logicalThree(B : [Int], C : [Int], D : [Int])->[Int]{
        var t = [Int]()
        for i in 0..<32{
            t.append((B[i]&C[i]|(B[i]&D[i])|(C[i]&D[i])))
        }
        return t
    }
    
    
    func transformToAscii(input : String)->[Int]{
        return converter.transformToAscii(input: input)
    }
    
    func transformToBinary(input : [Int])->[[Int]]{
        return converter.transformToBinary(input: input)
    }
    
    func transformToHex(input : Int)->String{
        return converter.transformToHex(input: input)
    }
    func transformBinaryToAscii(input m : [Int])->Int{
        return converter.transformBinaryToAscii(input : m)
    }
    
    func numString(input m : [[Int]])->[Int]{
        var array = [Int]()
        var k = 0
        for i in 0..<m.count{ // append to a single array every element in the binaries matrix
            for j in 0..<m[i].count{
                array.append(m[i][j])
            }
        }
        let mlBinary = transformToBinary(input: [array.count])//the message has a length of l bits. convert to binary the number of bits
        k = 448 - (array.count%512)-1
        k = k%512
        if k<0{
            k = k*(-1)
            k = 512-k
        }
        array.append(1) // Pad 1
        for _ in 0..<k{
            array.append(0)
        }
        
       //add another array made of 64 bits, the big endian being the conversion of l bits to binary - > (0 0 0 0 0 ..... [binary of l])
        for _ in 1...(64-mlBinary[0].count){
            array.append(0)
        }
        for ar in mlBinary{
            for i in ar{
                array.append(i)
            }
        }
        return array
    }
    
}
