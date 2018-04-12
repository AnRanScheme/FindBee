//
//  FindBee.swift
//  CommandLineKit
//
//  Created by 安然  on 2018/4/12.
//

import Foundation

public struct FindBee {
    
    let projectPath: String
    let excludedPaths: [String]
    let resourceExtensions: [String]
    let searchInFileExtensions: [String]
    
    let regularDirExtensions = ["imageset", "launchimage", "appiconset", "bundle"]
    var nonDirExtensions: [String] {
        return resourceExtensions.filter { !regularDirExtensions.contains($0) }
    }
    
    public init(projectPath: String, excludedPaths: [String], resourceExtensions: [String], searchInFileExtensions: [String]) {
        //let path = Path(projectPath).absolute()
        self.projectPath = projectPath
        self.excludedPaths = excludedPaths
        self.resourceExtensions = resourceExtensions
        self.searchInFileExtensions = searchInFileExtensions
    }
}
