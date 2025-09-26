#if canImport(UIKit)
import UIKit

final class FeatureAppsViewController: CoreCollectionViewController {
    
    private let viewModel: FeatureAppsViewModel
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        self.viewModel = FeatureAppsViewModel(AppCategoriesProviderImplementation())
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOrientationHandlers()
        setupCells()
        setupViews()
    }
    
    private func setupOrientationHandlers() {
        onPortraitOrientation = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        onLandscapeOrientation = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupViews() {
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        navigationItem.title = "Featured"
    }
    
    private func setupCells() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellid)
    }
    
    private func fetchCategories() {
        Task { @MainActor in
            let result = await viewModel.fetchCategories()
            
            switch result {
            case .success:
                collectionView.reloadData()
            case .failure(let error):
                NSLog("%@", error.localizedDescription)
            }
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        NSLog("%@", #function)
        fetchCategories()
    }
}

extension FeatureAppsViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCell.cellid,
            for: indexPath
        ) as! CategoryCell
        cell.setAppCategory(viewModel.appCategories[indexPath.item])
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.appCategories.count
    }
}

extension FeatureAppsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: view.bounds.width,
            height: min(240, view.bounds.height * 0.56)
        )
    }
}
#endif

