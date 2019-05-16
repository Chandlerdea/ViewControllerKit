//  ___FILEHEADER___

import UIKit

final class ___FILEBASENAMEASIDENTIFIER___: UIViewController {

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
private extension ___FILEBASENAMEASIDENTIFIER___ {

    func configureCollectionView() {
        self.collectionView.dataSource = self.dataSource
        self.dataSource.viewController = self
    }

}