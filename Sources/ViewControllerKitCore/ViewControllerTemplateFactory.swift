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
        result.append(self.viewTemplate(with: arguments))
        result.append(self.controllerTemplate(with: arguments))
        if let dataSourceTemplate: Template = self.dataSourceTempate(with: arguments) {
            result.append(dataSourceTemplate)
        }
        return result
    }
    
    private static func viewTemplate(with arguments: Arguments) -> Template {
        let result: Template
        switch arguments.viewType {
        case .view:
            result = self.defaultViewTemplate(
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
        case .table:
            result = self.tableViewTemplate(
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
        case .collection:
            result = self.collectionViewTemplate(
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
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
                viewName: arguments.viewName,
                path: arguments.viewControllerPath
            )
        case .collection:
            result = self.collectionViewControllerTemplate(
                viewControllerName: arguments.viewControllerName,
                viewName: arguments.viewName,
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
    
    private static func tableViewTemplate(viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewName))
        
        import UIKit
        
        final class \(viewName): UIView {
        
            // MARK: - Properties
        
            let tableView: UITableView = UITableView()
        
            // MARK: - Init
        
            override init(frame: CGRect) {
                super.init(frame: frame)
                self.setup()
            }
        
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
            // MARK: - Public Methods
        
            override func layoutSubviews() {
                super.layoutSubviews()
                self.tableView.frame = self.bounds
            }
        
        }
        // MARK: - Private Methods
        private extension \(viewName) {
        
            func setup() {
                self.addSubview(self.tableView)
            }
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
    private static func tableViewControllerTemplate(viewControllerName: String, viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewName))
        
        import UIKit
        
        final class \(viewControllerName): UIViewController {
        
            // MARK: - Properties
        
            private let dataSource: DataSource
            private let _view: \(viewName) = \(viewName)()
        
            var tableView: UITableView {
                return (self.view as! \(viewName)).tableView
            }
        
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
                self.view = self._view
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
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
        
                weak var viewController: \(viewControllerName)? {
                    didSet {
                        self.viewController?.tableView.dataSource = self
                    }
                }
        
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
    
    private static func collectionViewTemplate(viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewName))

        import UIKit
        
        final class \(viewName): UIView {
        
            // MARK: - Properties
        
            let collectionView: UICollectionView = UICollectionView()
        
            // MARK: - Init
        
            override init(frame: CGRect) {
                super.init(frame: frame)
                self.setup()
            }
        
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        
            // MARK: - Public Methods
        
            override func layoutSubviews() {
                super.layoutSubviews()
                self.collectionView.frame = self.bounds
            }
        
        }
        // MARK: - Private Methods
        private extension \(viewName) {
        
            func setup() {
                self.addSubview(self.collectionView)
            }
        }
        
        """
        return Template(location: location, contents: contents)
    }
    
    private static func collectionViewControllerTemplate(viewControllerName: String, viewName: String, path: String) -> Template {
        let location: URL = URL(fileURLWithPath: "\(path)/\(viewControllerName).swift")
        let contents: String = """
        \(Template.makeCopyrightContents(filename: viewControllerName))

        import UIKit
        
        final class \(viewControllerName): UIViewController {
        
            // MARK: - Properties
        
            private let dataSource: DataSource
            private let _view: \(viewName) = \(viewName)()
        
            var collectionView: UICollectionView {
                return (self.view as! \(viewName)).collectionView
            }
        
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
                self.view = self._view
            }
        
            override func viewDidLoad() {
                super.viewDidLoad()
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
        
                weak var viewController: \(viewControllerName)? {
                    didSet {
                        self.viewController?.collectionView.dataSource = self
                    }
                }
        
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





