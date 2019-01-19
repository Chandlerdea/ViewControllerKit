import ViewControllerKitCore
import Foundation

do {
    let kit: ViewControllerKit = try ViewControllerKit()
    try kit.run()
} catch {
    switch error {
    case Arguments.Error.missingAllArguments:
        print("""
            ViewControllerKit is a tool I use to create boilerplate for my view controllers.
            There are 2 arguments:
            1. The view controller's name
            2. The view controller's path
            There is an option `--type` which allows you to create either a regular view controller, a table view controller, or a collection view controller.
            The possible values are the following: view | table | collection
            If you do not pass the --type flag, a regular view controller is created by default.
        """)
    case Arguments.Error.missingArgument(let name, let message):
        print("👮‍♀️ Missing argument \(name): \(message)")
    case Arguments.Error.invalidViewType:
        print("👮‍♀️ Invalid viewType. Must use one of the following: view | table | collection")
    case Arguments.Error.generic(let message):
        print("👮‍♀️ Error occurred: \(message)")
    default:
        print("💥 An unknown error occurred")
    }
    exit(1)
}
