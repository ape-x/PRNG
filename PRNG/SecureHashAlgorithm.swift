//
//  SecureHashAlgorithm.swift
//  PRNG
//
//  Created by Mihnea Stefan on 14/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class SHA1 : Convertible{
    
    var H0 : Int = 0x67452301
    var H1 : Int = 0xEFCDAB89
    var H2 : Int = 0x98BADCFE
    var H3 : Int = 0x10325476
    var H4 : Int = 0xC3D2E1F0

    
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
        var binaries : [[Int]] = transformToBinary(input: asciiCodes)//conversion of ascii to binary
        
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
            var number = wordExpansion(A: W[i-3], B: W[i-8], C: W[i-14], D: W[i-16])
            number = leftrotate(input: number, times: 1)
            W.append(number)
        }
        
        var a = 1732584193
        var b = 4023233417
        var c = 2562383102
        var d = 271733878
        var e = 3285377520
        
        for i in 0...79{
            var k = 0x0
            var t = 0
            switch i {
            case 0...19 :
               k = 0x5a827999
               t = transformBinaryToInt(input: leftrotate(input: a.binary32, times: 5))+transformBinaryToInt(input : logicalOne(x: b.binary32, y: c.binary32, z: d.binary32))+transformBinaryToInt(input: W[i])+e+k
            case 20...39 :
                k = 0x6ed9eba1
                t = transformBinaryToInt(input: leftrotate(input: a.binary32, times: 5))+transformBinaryToInt(input : logicalTwo(x: b.binary32, y: c.binary32, z: d.binary32))+transformBinaryToInt(input: W[i])+e+k
            case 40...59 :
                k = 0x8f1bbcdc
                t = transformBinaryToInt(input: leftrotate(input: a.binary32, times: 5))+transformBinaryToInt(input : logicalThree(x: b.binary32, y: c.binary32, z: d.binary32))+transformBinaryToInt(input: W[i])+e+k
            case 60...79 :
                k = 0xca62c1d6
                t = transformBinaryToInt(input: leftrotate(input: a.binary32, times: 5))+transformBinaryToInt(input : logicalTwo(x: b.binary32, y: c.binary32, z: d.binary32))+transformBinaryToInt(input: W[i])+e+k
            default :
                break
            }
            let temp = transformToBinary(input: [t])
            var tm = temp[0]
            if tm.count>32{
            while tm.count>32{
                tm.remove(at: 0)
            }
            }
            t = transformBinaryToInt(input: tm)
            e = d
            d = c
            c = transformBinaryToInt(input: leftrotate(input: b.binary32, times: 30))
            b = a
            a = t
       
        }
        
        var hash = [(H0+a).binary8, (H1+b).binary8, (H2+c).binary8, (H3+d).binary8, (H4+e).binary8]
        
        for i in 0..<hash.count{
            if hash[i].count>32{
                while hash[i].count>32{
                    hash[i].remove(at: 0)
                }
            }
        }
        var Hash = ""
        for i in 0..<hash.count{
            Hash+="\((transformBinaryToInt(input : hash[i])).hex)"
        }
        print(Hash)
    }
    
    func leftrotate(input : [Int], times : Int)->[Int]{
     var result : [Int] = input.reversed()
        for _ in 0..<times{
            let head = result[result.count-1]
            for j in (1...result.count-1).reversed(){
                result[j] = result[j-1]
            }
            result[0] = head
        }
     return result.reversed()
    }
    
    func wordExpansion(A : [Int], B : [Int], C : [Int], D : [Int])->[Int]{
           var array = [Int]()
           let a = A
           let b = B
           let c = C
           let d = D
           
           for i in 0..<32{
               array.append(a[i]^b[i]^c[i]^d[i])
           }
           array = leftrotate(input: array, times: 0)
           return array
       }
    
    func logicalOne(x : [Int], y : [Int], z : [Int])->[Int]{ // (x,y,z) x&y XOR x&z
           var t = [Int]()
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
    func transformBinaryToInt(input m : [Int])->Int{
        return converter.transformBinaryToInt(input : m)
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
        let l = array.count
        array.append(1) // Pad 1
        k = 448 - (l%512)
        k = k%512
        if k<0{
            k = k*(-1)
            k = 512-k
        }
        for _ in 0..<k{
            array.append(0)
        }
        
         let mlBinary = transformToBinary(input: [l])//the message has a length of l bits. convert to binary the number of bits
       //add another array made of 64 bits, the big endian being the conversion of l bits to binary - > (0 0 0 0 0 ..... [binary of l])
        for _ in 1..<(64-mlBinary[0].count){
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

