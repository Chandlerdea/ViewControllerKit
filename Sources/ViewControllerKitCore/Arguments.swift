//
//  Arguments.swift
//  ViewControllerKit
//
//  Created by Chandler De Angelis on 1/19/19.
//

import Foundation

public struct Arguments {
    
    public enum Error: Swift.Error {
        case missingAllArguments
        case missingArgument(String, String)
        case invalidViewType
        case generic(String)
    }
    
    let viewControllerName: String
    let viewName: String
    let viewControllerPath: String
    let viewType: ViewType
    
    init(commanLineArguments: [String]) throws {
        guard commanLineArguments.count > 1 else {
            throw Error.missingAllArguments
        }
        guard commanLineArguments.count >= 2 else {
            throw Error.missingArgument("[view controller name]", "provide the name of your view controller")
        }
        self.viewControllerName = commanLineArguments[1]
        guard let viewControllerNameRange: Range<String.Index> = viewControllerName.range(of: "ViewController") else {
            throw Error.generic("👮‍♂️ Name of view controller must end with `ViewController`")
        }
        self.viewName = String(viewControllerName[viewControllerName.startIndex..<viewControllerName.index(viewControllerNameRange.lowerBound, offsetBy: 4)])
        guard commanLineArguments.count > 2 else {
            throw Error.missingArgument("[view controller path]", "provide the path of your view controller and its view")
        }
        self.viewControllerPath = commanLineArguments[2]
        if commanLineArguments.count > 3 {
            let viewTypeArgument: String = commanLineArguments[3]
            guard viewTypeArgument == "--type" else {
                throw Error.missingArgument("[--type]", "to specify the type of view controller, pass the --type flag")
            }
            guard commanLineArguments.count == 5 else {
                throw Error.invalidViewType
            }
            let viewTypeValue: String = commanLineArguments[4]
            guard let viewType: ViewType = ViewType(rawValue: viewTypeValue) else {
                throw Error.invalidViewType
            }
            self.viewType = viewType
        } else {
            self.viewType = .view
        }
    }
}
