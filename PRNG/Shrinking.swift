//
//  Shrinking.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


class ShrinkingGenerator{
    
    var A : LFSR
    var S : LFSR
    var seed : String
    
    init(seed : String){
        self.seed = seed
        self.A = LFSR(seed: seed)
        self.S = LFSR(seed: seed)
    }
    
    
}
