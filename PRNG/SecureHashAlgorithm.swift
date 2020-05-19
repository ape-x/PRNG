//
//  SecureHashAlgorithm.swift
//  PRNG
//
//  Created by Mihnea Stefan on 14/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class SHA1 : Convertible{
    
    var H0 : UInt32 = 0x67452301 // 01100111010001010010001100000001
    var H1 : UInt32 = 0xEFCDAB89 // 11101111110011011010101110001001
    var H2 : UInt32 = 0x98BADCFE // 10011000101110101101110011111110
    var H3 : UInt32 = 0x10325476 // 00010000001100100101010001110110
    var H4 : UInt32 = 0xC3D2E1F0 // 11000011110100101110000111110000

    
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
        var num = preprocessing(input: binaries)
        var M = [[[Int]]]()
        var matrix = [[Int]]()
        var array = [Int]()
        let N = num.count/512 // Number of messages

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
        //Functioning on a single 512 block atm
        var W = [[Int]]()
        for array in M[0]{
            W.append(array)
        }
        for i in 16...79{
            var number = logicalXOR(A: W[i-3], B: W[i-8], C: W[i-14], D: W[i-16])
            number = leftrotate(input: number, times: 1)
            W.append(number)
        }
        
        var a = 1732584193
        var b = 4023233417
        var c = 2562383102
        var d = 271733878
        var e = 3285377520
        
        var A : [Int] {
            get{
                return transformTo32(input: a)
            }
        }
        var B : [Int]{
            get{
                return transformTo32(input: b)
            }
        }
        var C : [Int]{
            get{
                return transformTo32(input: c)
            }
        }
        var D : [Int]{
            get{
                return transformTo32(input: d)
            }
        }
        var E : [Int]{
            get{
                return transformTo32(input: e)
            }
        }
        
        for i in 0...79{
            var k = 0x0
            var t = 0
            switch i {
            case 0...19 :
                k = 0x5a827999
                 t = transformBinaryToAscii(input: leftrotate(input: A, times: 5))+transformBinaryToAscii(input : logicalOne(x: B, y: C, z: D))+transformBinaryToAscii(input: W[i])+e+k
            case 20...39 :
                k = 0x6ed9eba1
                 t = transformBinaryToAscii(input: leftrotate(input: A, times: 5))+transformBinaryToAscii(input : logicalTwo(x: B, y: C, z: D))+transformBinaryToAscii(input: W[i])+e+k
            case 40...59 :
                k = 0x8f1bbcdc
                 t = transformBinaryToAscii(input: leftrotate(input: A, times: 5))+transformBinaryToAscii(input : logicalThree(x: B, y: C, z: D))+transformBinaryToAscii(input: W[i])+e+k
            case 60...79 :
                k = 0xca62c1d6
                 t = transformBinaryToAscii(input: leftrotate(input: A, times: 5))+transformBinaryToAscii(input : logicalTwo(x: B, y: C, z: D))+transformBinaryToAscii(input: W[i])+e+k
            default :
                break
            }
            e = d
            d = c
            c = transformBinaryToAscii(input: leftrotate(input: B, times: 30))
            b = a
            a = t
        }
    }
    
    func leftrotate(input : [Int], times : Int)->[Int]{
        var result : [Int] = input
        for _ in 0..<times{
            let head = result[result.count-1]
            for j in (1...result.count-1).reversed(){
                result[j] = result[j-1]
            }
            result[0] = head
        }
        
        
        return result
    }
  
    func logicalXOR(A : [Int], B : [Int], C : [Int], D : [Int])->[Int]{
        var array = [Int]()
        let a : [Int] = A.reversed()
        let b : [Int] = B.reversed()
        let c : [Int] = C.reversed()
        let d : [Int] = D.reversed()
        for i in 0..<32{
            array.append(a[i]^b[i]^c[i]^d[i])
        }
        return array
    }
    
    func logicalOne(x : [Int], y : [Int], z : [Int])->[Int]{ // (x,y,z) x&y XOR x&z
           var t = [Int]()
        print(x.count)
        print(y.count)
        print(z.count)
           for i in 0..<32{
               t.append((x[i]&y[i])|(~x[i])&z[i])
           }
           return t
       }
       
    func logicalTwo(x : [Int], y : [Int], z : [Int])->[Int]{ // x XOR y XOR z
        var t = [Int]()
            for i in 0..<32{
                t.append(x[i]^y[i]^z[i])
            }
            return t
    }

    func logicalThree(x : [Int], y : [Int], z : [Int])->[Int]{ // x^y XOR x^z XOR x^z
        var t = [Int]()
        for i in 0..<32{
            t.append((x[i]&y[i]|(x[i]&z[i])|(y[i]&z[i])))
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
    func transformTo32(input : Int)->[Int]{
        return converter.transformTo32(input : input)
    }
    
    
    func preprocessing(input m : [[Int]])->[Int]{
        var array = [Int]()
        var k = 0
        for i in 0..<m.count{ // append to a single array every element in the binaries matrix
            for j in 0..<m[i].count{
                array.append(m[i][j])
            }
        }
        
        array.append(1) // Pad 1
        k = 448 - (array.count%512)
        k = k%512
        if k<0{
            k = k*(-1)
            k = 512-k
        }
        for _ in 0..<k{
            array.append(0)
        }
        
         let mlBinary = transformToBinary(input: [array.count])//the message has a length of l bits. convert to binary the number of bits
        
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
   
