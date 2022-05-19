//
//  HomeViewController.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/27.
//

import UIKit
import SnapKit
import RxSwift
import PKHUD

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = L10n.searchPlacaholder
        searchBar.searchTextField.textColor = .darkGray
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundColor = .clear
        searchBar.layer.shadowColor = UIColor.gray.cgColor
        searchBar.layer.shadowOpacity = 1
        searchBar.layer.shadowRadius = 4
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        return searchBar
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "slider.vertical.3"), for: .normal)
        button.tintColor = UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1)
        return button
    }()
    
    private var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let viewModel: CardViewModelType
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycles
    
    init(viewModel: CardViewModelType = CardViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // MARK: Inputs
        
        searchBar.rx.searchButtonClicked
            .bind(to: viewModel.input.searchButtonClicked)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        // MARK: Outputs
        
        viewModel.output.hudShow
            .subscribe(onNext: { type in
                HUD.show(type)
            }).disposed(by: disposeBag)
        
        viewModel.output.hudHide
            .subscribe(onNext: { _ in
                HUD.hide()
            }).disposed(by: disposeBag)

        viewModel.output.repositoryInfoModels
            .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CardCell.self)) { _, item, cell in
                cell.setupCellData(item: item)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-50)
            make.height.equalTo(32)
        }
        
        view.addSubview(optionButton)
        optionButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(searchBar.snp.right).offset(0)
            make.right.equalTo(view).offset(-3)
            make.height.equalTo(32)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.width - 40,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }
}
