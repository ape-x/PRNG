//
//  main.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


var a : LFSR = LFSR(seed :"a")
var b : SHA1 = SHA1(input: "abc")
b.hash()
a.startMachine(times_shifted: 7)
