//
//  FileSearchRule.swift
//  CommandLineKit
//
//  Created by 安然  on 2018/4/12.
//

import Foundation

// 面向协议编程

protocol FileSearchRule {
    func search(in cotnent: String) -> Set<String>
}

protocol RegPatternSearchRule: FileSearchRule {
    var extensions: [String] { get }
    var patterns: [String] { get }
}

extension RegPatternSearchRule {
    func search(in content: String) -> Set<String> {
        
        let nsstring = NSString(string: content)
        var result = Set<String>()
        
        for pattern in patterns {
            let reg = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            
            let matches = reg.matches(in: content, options: [], range: content.fullRange)
            for checkingResult in matches {
                let extracted = nsstring.substring(with: checkingResult.range(at: 1))
                result.insert(extracted.plainFileName(extensions: extensions) )
            }
        }
        
        return result
    }
}

struct PlainImageSearchRule: RegPatternSearchRule {
    let extensions: [String]
    var patterns: [String] {
        if extensions.isEmpty {
            return []
        }
        
        let joinedExt = extensions.joined(separator: "|")
        return ["\"(.+?)\\.(\(joinedExt))\""]
    }
}

struct ObjCImageSearchRule: RegPatternSearchRule {
    let extensions: [String]
    let patterns = ["@\"(.*?)\"", "\"(.*?)\""]
}

struct SwiftImageSearchRule: RegPatternSearchRule {
    let extensions: [String]
    let patterns = ["\"(.*?)\""]
}

struct XibImageSearchRule: RegPatternSearchRule {
    let extensions = [String]()
    let patterns = ["image name=\"(.*?)\"", "image=\"(.*?)\"", "value=\"(.*?)\""]
}

struct PlistImageSearchRule: RegPatternSearchRule {
    let extensions: [String]
    let patterns = ["<key>UIApplicationShortcutItemIconFile</key>[^<]*<string>(.*?)</string>"]
}

