//
//  main.swift
//  PRNG
//
//  Created by Mihnea Stefan on 13/05/2020.
//  Copyright © 2020 Mihnea Stefan. All rights reserved.
//

import Foundation



var test = ShrinkingGenerator(seed: "ssh", key_length: 10)
test.generateKey()
print(test.output!)
