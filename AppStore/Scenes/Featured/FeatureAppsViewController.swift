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
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.cellid
        )
        collectionView.register(
            LargeCategoryCell.self,
            forCellWithReuseIdentifier: LargeCategoryCell.cellidA
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.cellid
        )
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
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LargeCategoryCell.cellidA,
                for: indexPath
            ) as! LargeCategoryCell
            cell.setAppCategory(viewModel.appCategories[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.cellid,
                for: indexPath
            ) as! CategoryCell
            cell.setAppCategory(viewModel.appCategories[indexPath.item])
            return cell
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.appCategories.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.cellid,
                for: indexPath
            ) as! HeaderView
            
            if let model = viewModel.appCategories.first {
                headerView.setAppCategory(model)
            }
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension FeatureAppsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.bounds.width, height: 150)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(
                width: view.bounds.width,
                height: min(160, view.bounds.height * 0.36)
            )
        }
        
        return CGSize(
            width: view.bounds.width,
            height: min(240, view.bounds.height * 0.56)
        )
    }
}
#endif

