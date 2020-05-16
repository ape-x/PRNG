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
//b.hash()


//15381
//21 + 1 + k = 448
//k = 448 - 21 - 1 = 426
//15381 + 426 + 1 + 64 =

print(Int(UInt32(0xC3D2E1F0)))


//Fiecare M de 512 il impart in 16 M[i] de 32
//Fiecare M[i] de 32 il transform intr-un hex W[i]



//"abc"
//hex : 61626380
//binary :01100001011000100110001110000000

//


func logicalOne(B : [Int], C : [Int], D : [Int])->[Int]{
          var t = [Int]()
          for i in 0..<32{
              t.append((B[i]&C[i])|(~B[i])&D[i])
          }
          return t
      }

var s = Converter()
//print(s.transformBinaryToAscii(input: [0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]))
print(s.transformToHex(input: 1633837952))
