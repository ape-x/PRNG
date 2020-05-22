//
//  main.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation


var a : LFSR = LFSR(seed :"a")
var b : SHA1 = SHA1(input: " ")
b.hash()

var s = 1

print((s+2).binary8)

//54955917420102912630289020957282471427832449680
//879294678721646602032513693786241067415307455120

//9A04EFE2 DD0D5360 0B39A92B DB15FCB8 317A8A90
//9A04EFE2DD0D53600B39A92BDB15FCB8317A8A90
