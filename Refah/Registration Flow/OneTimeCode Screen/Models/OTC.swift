//
//  OTC.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import Foundation

struct OTC: OTCProtocol {
    let size: Int
    var otc: [String]
    
    init(size: Int) {
        self.size = size
        self.otc = []
        
        for _ in 0..<size {
            self.otc.append("")
        }
    }
}
