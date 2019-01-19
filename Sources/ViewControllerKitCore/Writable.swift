//
//  Writable.swift
//  ViewControllerKit
//
//  Created by Chandler De Angelis on 1/19/19.
//

import Foundation

protocol Writable {
    func write() throws
}

extension Writable where Self == Template {
    
    func write() throws {
        try self.contents.write(to: self.location, atomically: true, encoding: .utf8)
    }
}

extension Collection where Element: Writable {
    
    func writeAll() throws {
        try self.forEach({ try $0.write() })
    }
}
