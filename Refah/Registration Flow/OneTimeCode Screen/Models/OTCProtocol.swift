//
//  OTCProtocol.swift
//  Refah
//
//  Created by Jafar Khoshtabiat on 5/28/23.
//

import Foundation

protocol OTCProtocol {
    var size: Int { get }
    var otc: [String] { get set }
    
    func isAllOTCsEntered() -> Bool
    func getFirstEmptyOTCIndex() -> Int
    func getOTCIn(index: Int) -> String
    mutating func setOTCIn(index: Int, otc: String)
    func isOTCEnteredIn(index: Int) -> Bool
}

extension OTCProtocol {
    func isAllOTCsEntered() -> Bool {
        for item in otc {
            if item.count != 1 {
                return false
            }
        }
        
        return true
    }
    
    func getFirstEmptyOTCIndex() -> Int {
        var index = 0
        for item in otc {
            if item.count != 1 {
                return index
            }
            
            index += 1
        }
        
        return -1
    }
    
    func getOTCIn(index: Int) -> String {
        guard index < self.size else { return "-1" }
        return self.otc[index]
    }
    
    mutating func setOTCIn(index: Int, otc: String) {
        guard index < self.size else { return }
        guard otc.count <= 1 else { return }
        self.otc[index] = otc
    }
    
    func isOTCEnteredIn(index: Int) -> Bool {
        guard index < self.size else { return false }
        return self.otc[index].count == 1
    }
}
