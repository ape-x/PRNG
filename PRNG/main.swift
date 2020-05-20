//
//  main.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


var a : LFSR = LFSR(seed :"a")
//a.startMachine(times_shifted: 8)
var b : SHA1 = SHA1(input: "abc")
b.hash()


//15381
//21 + 1 + k = 448
//k = 448 - 21 - 1 = 426
//15381 + 426 + 1 + 64 =

var c = Converter()


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
    let result = 0
    var chars : [Character] = input.reversed()
    chars = chars.reversed()
    var k = chars.count-1
    for _ in 0..<chars.count{
        if chars[k].isNumber{
            
        }else if chars[k].isLetter{
            
        }
        k-=1
    }
    return result
    
}

//print(transformToDecimal(hexadecimal: "23C"))
//10000001100100101010001110110


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

//var number : UInt32 = 12903185459

//print(transformTo32(input: 12903185459))
//1100000001000101101111110000110011
