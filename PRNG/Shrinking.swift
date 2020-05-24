//
//  Shrinking.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


class ShrinkingGenerator{
    
    var A : LinearFeedbackShiftRegister
    var S : LinearFeedbackShiftRegister
    var output : [Int]?
    var hash : SHA1
    var keyLength : Int
    
    init(seed : String, key_length l : Int){
        hash = SHA1(input: seed)
        hash.hashComputation()
        keyLength = l
        output = [Int]()
        var Ainput = ""
        var Sinput = ""
        for i in 0..<hash.messageDigest!.count{
            let index = hash.messageDigest!.index(hash.messageDigest!.startIndex, offsetBy: i)
            if i < hash.messageDigest!.count/2{
                Ainput+="\(hash.messageDigest![index])"
            }else{
                Sinput+="\(hash.messageDigest![index])"
            }
        }
        print(Ainput,Sinput)
        A = LinearFeedbackShiftRegister(seed: Ainput)
        S = LinearFeedbackShiftRegister(seed: Sinput)
    }
    
    func generateKey(){
        while output!.count<keyLength{
            A.produceOutput()
            S.produceOutput()
            if S.output == 1{
                self.output?.append(A.output!)
            }
        }
        
        
    }
    
    
}
