//
//  ViewControllerTemplateFactory.swift
//  ViewControllerKit
//
//  Created by Chandler De Angelis on 1/19/19.
//

import Foundation

struct ViewControllerTemplateFactory {
    
    static func makeTemplates(with arguments: Arguments) -> [Template] {
        var result: [Template] = []
        if let viewTemplate: Template = self.viewTemplate(with: arguments) {
            result.append(viewTemplate)
        }
        result.append(self.controllerTemplate(with: arguments))
        if let dataSourceTemplate: Template = self.dataSourceTempate(with: arguments) {
            result.append(dataSourceTemplate)
        }
        return result
    }
    
    private static func viewTemplate(with arguments: Arguments) -> Template? {
        let result: Template
        switch arguments.viewType {
        case .view:
            result = self.defaultViewTemplate(
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
        case .table, .collection:
            return .none
        }
        return result
    }
    
    private static func controllerTemplate(with arguments: Arguments) -> Template {
        let result: Template
        switch arguments.viewType {
        case .view:
            result = self.defaultControllerTemplate(
                viewControllerName: arguments.viewControllerName,
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
        case .table:
            result = self.tableViewControllerTemplate(
                viewControllerName: arguments.viewControllerName,
                path: arguments.viewControllerPath
            )
        case .collection:
            result = self.collectionViewControllerTemplate(
                viewControllerName: arguments.viewControllerName,
                path: arguments.viewControllerPath
            )
        }
        return result
    }
    
    private static func dataSourceTempate(with arguments: Arguments) -> Template? {
        var result: Template?
        switch arguments.viewType {
        case .view:
            result = .none
        case .table:
            result = self.tableViewDataSourceTemplate(
                viewControllerName: arguments.viewControllerName,
                path: arguments.viewControllerPath
            )
        case .collection:
            result = self.collectionViewDataSourceTemplate(
                viewControllerName: arguments.viewControllerName,
                path: arguments.viewControllerPath
            )
        }
        return result
    }
    
    // MARK: - View Controller Templates
    
    private static func defaultViewTemplate(viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewName))
        
        import UIKit
        
        final class \(viewName): UIView {
        
            // MARK: - Properties
        
            // MARK: - Init
        
            override init(frame: CGRect) {
                super.init(frame: frame)
                self.setup()
            }
        
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
        }
        // MARK: - Private Methods
        private extension \(viewName) {
        
            func setup() {
                self.backgroundColor = UIColor.white
            }
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
    private static func defaultControllerTemplate(viewControllerName: String, viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewName))

        import UIKit
        
        final class \(viewControllerName): UIViewController {
        
            // MARK: - Properties
        
            private let _view: \(viewName) = \(viewName)()
        
            // MARK: - View Lifecycle
        
            override func loadView() {
                self.view = self._view
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
        
            }
        }
        // MARK: - Private
        private extension \(viewControllerName) {
        
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
    // MARK: - Table View Controller Templates
    
    private static func tableViewControllerTemplate(viewControllerName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewControllerName))
        
        import UIKit
        
        final class \(viewControllerName): UIViewController {
        
            // MARK: - Properties
        
            private let dataSource: DataSource
            private let tableView: UITableView = {
                let tableView: UITableView = UITableView()
                return tableView
            }()
        
            // MARK: - Init
        
            override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                self.dataSource = DataSource()
                super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            }
        
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
            // MARK: - View Lifecycle
        
            override func loadView() {
                self.view = self.tableView
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
                self.configureTableView()
            }
        }
        // MARK: - Private
        private extension \(viewControllerName) {
        
            func configureTableView() {
                self.tableView.dataSource = self.dataSource
                self.dataSource.viewController = self
            }
        
        }
        """
        return Template(location: location, contents: contents)
    }
    
    private static func tableViewDataSourceTemplate(viewControllerName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName)+DataSource.swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewControllerName))
        
        import UIKit
        
        extension \(viewControllerName) {
        
            final class DataSource: NSObject, UITableViewDataSource {
        
                // MARK: - Properties
        
                weak var viewController: \(viewControllerName)?
        
                // MARK: - UITableViewDataSource
        
                func numberOfSections(in tableView: UITableView) -> Int {
        
                }
        
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
                }
        
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                }
        
            }
        
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
    // MARK: - Collection View Controller Templates

    private static func collectionViewControllerTemplate(viewControllerName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewControllerName))

        import UIKit
        
        final class \(viewControllerName): UIViewController {
        
            // MARK: - Properties
        
            private let dataSource: DataSource
            private let collectionView: UICollectionView = {
                let collectionView: UICollectionView = UICollectionView()
                return collectionView
            }()
        
            // MARK: - Init
        
            override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                self.dataSource = DataSource()
                super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            }
        
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
            // MARK: - View Lifecycle
        
            override func loadView() {
                self.view = self.collectionView
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
                self.configureCollectionView()
            }
        }
        // MARK: - Private
        private extension \(viewControllerName) {
        
            func configureCollectionView() {
                self.collectionView.dataSource = self.dataSource
                self.dataSource.viewController = self
            }
        
        }
        """
        return Template(location: location, contents: contents)
    }
    
    private static func collectionViewDataSourceTemplate(viewControllerName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName)+DataSource.swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewControllerName))

        import UIKit
        
        extension \(viewControllerName) {
        
            final class DataSource: NSObject, UICollectionViewDataSource {
        
                // MARK: - Properties
        
                weak var viewController: \(viewControllerName)?
        
                // MARK: - UICollectionViewDataSource
        
                func numberOfSections(in collectionView: UICollectionView) -> Int {
        
                }
        
                func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
        
                }
        
                func collectionView(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        
                }
        
            }
        
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
}





