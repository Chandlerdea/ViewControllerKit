//
//  Template.swift
//  ViewControllerKit
//
//  Created by Chandler De Angelis on 1/19/19.
//

import Foundation

struct Template: Writable {
    
    static func makeCopyrightContents(filename: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString: String = dateFormatter.string(from: Date())
        let processName: String = ProcessInfo.processInfo.processName
        let userName: String = NSFullUserName()
        return """
        //
        //  \(filename).swift
        //  \(processName)
        //
        //  Created by \(userName) on \(dateString).
        //
        """
    }
    
    let location: URL
    let contents: String
}

