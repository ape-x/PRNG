//
//  main.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


var a : LFSR = LFSR(seed :"a")
var b : SHA1 = SHA1(input: "AFC53A4EA20856F98E08DC6F3A5C9833137768ED")
b.hash()
a.startMachine(times_shifted: 7)

//A9993E36 A38340B5 BA3E2571 7850C26C CE686C4E

