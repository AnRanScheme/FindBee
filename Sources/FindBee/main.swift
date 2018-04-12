import Foundation
import CommandLineKit
import Rainbow
import FindBeeKit
import PathKit



let cli = CommandLineKit.CommandLine()

let projectPathOption = StringOption(shortFlag: "p",
                                     longFlag: "project",
                                     helpMessage: "Path to the project.")

let reasouceExtensionsOption = MultiStringOption(shortFlag: "r",
                                                 longFlag: "reasouce-extensions",
                                                 helpMessage: "reasouce extension to search")

let fileExtensionsOption = MultiStringOption(shortFlag: "f",
                                             longFlag: "file-extensions",
                                             helpMessage: "file extensions to search")

let excludePathOption = MultiStringOption(shortFlag: "e",
                                          longFlag: "exclude-extensions",
                                          helpMessage: "exclude extensions to search out")


let help = BoolOption(shortFlag: "h",
                      longFlag: "help",
                      helpMessage: "Prints a help message.")

cli.addOptions(projectPathOption,
               reasouceExtensionsOption,
               fileExtensionsOption,
               help)

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.lightBlue
    default:
        str = s
    }
    
    return cli.defaultFormat(s: str, type: type)
}

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if help.value {
    cli.printUsage()
    exit(EX_OK)
}

let projectPath = projectPathOption.value ?? "."
let resourceExtentions = reasouceExtensionsOption.value ?? ["imageset", "jpg", "png", "gif"]
let fileExtensions = fileExtensionsOption.value ?? ["m", "mm", "swift", "xib", "storyboard", "plist"]
let excludePaths = excludePathOption.value ?? []

