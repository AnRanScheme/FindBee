//
//  Extensions.swift
//  CommandLineKit
//
//  Created by 安然  on 2018/4/12.
//

import Foundation
import PathKit

extension String {
    var fullRange: NSRange {
        let nsstring = NSString(string: self)
        return NSMakeRange(0, nsstring.length)
    }
    
    func plainFileName(extensions: [String]) -> String {
        let p = Path(self)
        var result: String!
        for ext in extensions {
            if hasSuffix(".\(ext)") {
                result = p.lastComponentWithoutExtension
                break
            }
        }
        
        if result == nil {
            result = p.lastComponent
        }
        
        if result.hasSuffix("@2x") || result.hasSuffix("@3x") {
            let endIndex = result.index(result.endIndex, offsetBy: -3)
            result = String(result[..<endIndex])
        }
        return result
    }
    
    func appendingPathComponent(_ str: String) -> String {
        let nsstring = NSString(string: self)
        return nsstring.appendingPathComponent(str)
    }
}

let fileSizeSuffix = ["B", "KB", "MB", "GB"]
extension Int {
    public var fn_readableSize: String {
        var level = 0
        var num = Float(self)
        while num > 1000 && level < 3 {
            num = num / 1000.0
            level += 1
        }
        
        if level == 0 {
            return "\(Int(num)) \(fileSizeSuffix[level])"
        } else {
            return String(format: "%.2f \(fileSizeSuffix[level])", num)
        }
    }
}

