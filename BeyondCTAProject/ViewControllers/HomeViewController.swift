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
import SwiftMessages

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.logoImage.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.backgroundImage.image
        return imageView
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
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
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        return searchBar
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.tintColor = Asset.optionButton.color
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private let sampleButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Swift", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tap2), for: .touchUpInside)
        return button
    }()
    
    private let sampleButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.tintColor = .red
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tap3), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = ScrollCollectionLayout(size: .zero)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var repositories: [RepositoryInfoModel] = []
    
    private let viewModel: CardViewModelType
    private let disposeBag = DisposeBag()
    
    private let pagingThresholdOffset = 1
    
    // MARK: - Lifecycle
    
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
        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] _, indexPath in
                guard let me = self, me.collectionView.remainCellsCount(cellIndexPath: indexPath) == me.pagingThresholdOffset else { return }
                me.viewModel.input.willDisplayCell.onNext(())
            }).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(with: self,
                       onNext: { me, indexPath in
                let repository = me.repositories[indexPath.row]
                let url = URL(string: repository.url)
                let viewController = WebViewController(url: url)
                viewController.modalPresentationStyle = .fullScreen
                me.present(viewController, animated: true)
            }).disposed(by: disposeBag)
        
        optionButton.rx.tap
            .subscribe(with: self,
                       onNext: { me, _ in
//                let viewController = SearchViewController()
//                viewController.modalPresentationStyle = .fullScreen
//                me.present(viewController, animated: true)
//                me.view.addSubview(CustomView)
            }).disposed(by: disposeBag)
        
        // MARK: Inputs
        
        searchBar.rx.searchButtonClicked
            .subscribe(with: self,
                       onNext: { me, _ in
                me.searchBar.resignFirstResponder()
                me.viewModel.input.searchButtonClicked.onNext(())
                me.collectionView.setContentOffset(CGPoint(x: -20, y: 0), animated: false)
            }).disposed(by: disposeBag)
        
//        searchBar.rx.text.orEmpty
//            .bind(to: viewModel.input.searchText)
//            .disposed(by: disposeBag)
        
        // MARK: Outputs
        
        viewModel.output.hudShow
            .subscribe(onNext: { type in
                self.logoImageView.alpha = 0
                HUD.show(type)
            }).disposed(by: disposeBag)
        
        viewModel.output.hudHide
            .subscribe(onNext: { _ in
                HUD.hide()
            }).disposed(by: disposeBag)
        
        viewModel.output.repositoryInfoModels
            .subscribe(with: self,
                       onNext: { me, repositories in
                me.repositories = repositories
            }).disposed(by: disposeBag)

        viewModel.output.repositoryInfoModels
            .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CardCell.self)) { _, item, cell in
                cell.setupCellData(item: item)
            }.disposed(by: disposeBag)
        
        viewModel.output.noResults
            .subscribe(with: self,
                       onNext: { me, _ in
                guard let searchText = me.searchBar.text else { return }
                me.showNoResultsAlert(with: searchText)
            }).disposed(by: disposeBag)
        
    }
    
    @objc func tap() {
    }
    
    @objc func tap2() {
        print("@")
        searchBar.text = "Java"
    }
    
    @objc func tap3() {
        customView.removeFromSuperview()
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        viewModel.input.searchButtonClicked.onNext(())
        collectionView.setContentOffset(CGPoint(x: -20, y: 0), animated: false)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImageView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
        
        view.backgroundColor = Asset.base.color
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
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(searchBar)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        print("@@@")
        view.addSubview(customView)
        
        customView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
//            make.left.equalToSuperview().offset(100)
            make.left.equalToSuperview()
        }
        
        customView.addSubview(sampleButton)
        sampleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        customView.addSubview(sampleButton2)
        sampleButton2.snp.makeConstraints { make in
            
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    private func showNoResultsAlert(with searchText: String) {
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureDropShadow()
        view.configureContent(
            title: L10n.noResultsAlertTitle(searchText),
            body: L10n.noResultsAlertBody
        )
        view.button?.isHidden = true
        view.iconLabel?.isHidden = true
        SwiftMessages.show(view: view)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.frame.width - 60,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
