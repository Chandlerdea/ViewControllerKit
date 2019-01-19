import Foundation

public final class ViewControllerKit {
    
    private let arguments: Arguments
    
    public init(commanLineArguments: [String] = CommandLine.arguments) throws {
        self.arguments = try Arguments(commanLineArguments: commanLineArguments)
    }
    
    public func run() throws {
        let templates: [Template] = ViewControllerTemplateFactory.makeTemplates(with: self.arguments)
        try templates.writeAll()
        templates.forEach {
            print("👌 Created \($0.location.lastPathComponent) at \($0.location.path)")
        }
    }
}
