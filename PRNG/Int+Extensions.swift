//
//  Int+Extensions.swift
//  PRNG
//
//  Created by Mihnea Stefan on 23/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


extension Int{
    var binary32 : [Int]{
        get{
            var array = [Int]()
            var number = self
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
            if array.count>32{
                while array.count>32{
                    array.remove(at: 0)
                }
            }
            array = array.reversed()
            return array
        }
    }
    
    var binary8 : [Int]{
        get{
            var array = [Int]()
            var number = self
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
            return array
        }
    }
    
    var hex : String{
        get{
            var value = ""
            var number = self
            var array = [Int]()
            
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
            while array.count<8{
                array.append(0)
            }
            array = array.reversed()
            for i in 0..<array.count{
                if array[i]>=10{
                    value.append(String(UnicodeScalar(array[i]+55)!))
                }else{
                    value.append(String(UnicodeScalar(array[i]+48)!))
                }
            }
            
            return value
        }
    }
}
