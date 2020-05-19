//
//  Protocols.swift
//  PRNG
//
//  Created by Mihnea Stefan on 14/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation

class Converter{
    
    func transformToAscii(input : String)->[Int]{
          var asciiCodes = [Int]()
          for char in input{
              asciiCodes.append(Int(char.asciiValue!))
          }
          return asciiCodes
      }
    
    func transformToBinary(input : [Int])->[[Int]]{
        var binaries = [[Int]]()
        
        for i in 0..<input.count{
            var number = input[i]
            var array = [Int]()
            while true{
                array.append(number%2)
                if number/2 == 0{
                    break
                }
                number = number/2
            }
            while array.count<8{
                array.append(0)
            }
            array = array.reversed()
            binaries.append(array)
            array.removeAll()
        }
        
        return binaries
    }
    
   func transformToHex(input : Int)->String{
        var number = input
        var array = [Int]()
        var str = ""
        while true{
            let D = Double(number)/16
            let R = Int((D-Double((number/16)))*16)
            number = Int(D)
            array.append(R)
            if number/16 == 0{
                array.append(Int(D))
             break
            }
        }
        array = array.reversed()
        for i in 0..<array.count{
            if array[i]>=10{
                str.append(String(UnicodeScalar(array[i]+55)!))
            }else{
                str.append(String(UnicodeScalar(array[i]+48)!))
            }
        }
        return str
    }
    
    func transformBinaryToAscii(input m : [Int])->Int{
        var ascii : Int = 0
        var k = m.count-1
            for j in 0..<m.count{
                ascii+=Int(powf(2,Float(j))*Float(m[k]))
                k-=1
                
            }
        return ascii
    }
    
    func transformToDecimal(hexadecimal input : String)->Int{
        var result = 0
        var chars : [Character] = input.reversed()
        chars = chars.reversed()
        let k = chars.count-1
        for i in 0..<chars.count{
            if chars[i].isNumber{
            result+=Int(powf(16,Float(i))*Float(chars[k].asciiValue!-48))
            }else{
                result+=Int(powf(16,Float(i)*Float(chars[k].asciiValue!-65+10)))
            }
        }
        return result
        
    }
    
    func transformTo32(input : Int)->[Int]{
        var array = [Int]()
        var number = input
        while true{
                     array.append(number%2)
                     if number/2 == 0{
                         break
                     }
                     number = number/2
                 }
                 while array.count<32{
                     array.append(0)
                 }
                 array = array.reversed()
        return array
    }
    
}

protocol Convertible{
    func transformToBinary(input : [Int])->[[Int]]
    func transformToAscii(input : String)->[Int]
    func transformToHex(input : Int)->String
    func transformBinaryToAscii(input m : [Int])->Int
    func transformTo32(input : Int)->[Int]
}
