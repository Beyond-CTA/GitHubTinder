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
    var languages = ["Java", "JavaScript", "TypeScript"]
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
    
    private let searchOptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 30
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
        button.addTarget(HomeViewController.self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    private let javaButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Java", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(javaBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let javaScriptButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("JavaScript", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(javaScriptBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let typeScriptButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("TypeScript", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(typeScriptBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let pythonButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Python", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(pythonBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let rubyButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Ruby", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(rubyBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let phpButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("PHP", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(phpBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let swiftButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Swift", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(swiftBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let kotlinButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Kotlin", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(kotlinBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let flutterButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Flutter", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(flutterBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let cButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("C", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let csharpButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("C#", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(csharpBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let goButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Go", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(goBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let rustButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Rust", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(rustBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let scalaButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("Scala", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(scalaBtnTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private let cplusButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("C++", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cplusBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let rButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("R", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(rBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let htmlButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("HTML", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(htmlBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let cssButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("CSS", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cssBtnTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    private let starButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.star.image, for: .normal)
        button.setTitle("@@@", for: .normal)
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let forkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "tuningfork"), for: .normal)
        button.setTitle("@@@", for: .normal)
        button.tintColor = .red
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(forkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    
    
    
    
    
    private let closeButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(systemName: L10n.verticalSlider), for: .normal)
        button.setTitle("閉じる", for: .normal)
        button.tintColor = .red
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
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
        
        self.view.addSubview(searchOptionView)
        
        searchOptionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(50)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
//            make.left.equalToSuperview().offset(100)
            make.left.equalToSuperview()
        }

        
        searchOptionView.addSubview(javaButton)
        javaButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(javaScriptButton)
        javaScriptButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(typeScriptButton)
        typeScriptButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        searchOptionView.addSubview(pythonButton)
        pythonButton.snp.makeConstraints { make in
            make.top.equalTo(javaButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(rubyButton)
        rubyButton.snp.makeConstraints { make in
            make.top.equalTo(javaScriptButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(phpButton)
        phpButton.snp.makeConstraints { make in
            make.top.equalTo(typeScriptButton.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        searchOptionView.addSubview(swiftButton)
        swiftButton.snp.makeConstraints { make in
            make.top.equalTo(pythonButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(kotlinButton)
        kotlinButton.snp.makeConstraints { make in
            make.top.equalTo(rubyButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(flutterButton)
        flutterButton.snp.makeConstraints { make in
            make.top.equalTo(phpButton.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        
        searchOptionView.addSubview(cButton)
        cButton.snp.makeConstraints { make in
            make.top.equalTo(swiftButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(csharpButton)
        csharpButton.snp.makeConstraints { make in
            make.top.equalTo(kotlinButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(cplusButton)
        cplusButton.snp.makeConstraints { make in
            make.top.equalTo(flutterButton.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        
        searchOptionView.addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.top.equalTo(cButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(rustButton)
        rustButton.snp.makeConstraints { make in
            make.top.equalTo(csharpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(scalaButton)
        scalaButton.snp.makeConstraints { make in
            make.top.equalTo(cplusButton.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        searchOptionView.addSubview(rButton)
        rButton.snp.makeConstraints { make in
            make.top.equalTo(goButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(htmlButton)
        htmlButton.snp.makeConstraints { make in
            make.top.equalTo(rustButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(cssButton)
        cssButton.snp.makeConstraints { make in
            make.top.equalTo(scalaButton.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        
        
        
        
        
        
        
        
        
        searchOptionView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        searchOptionView.addSubview(starButton)
        starButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalTo(closeButton.snp.top).offset(-40)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        searchOptionView.addSubview(forkButton)
        forkButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(closeButton.snp.top).offset(-40)
            make.width.equalTo(110)
            make.height.equalTo(60)
        }
        
        
        
        
        
        
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
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
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
        print("@@@")
//        self.view.addSubview(searchOptionView)
//
//        searchOptionView.snp.makeConstraints { make in
////            make.top.equalToSuperview()
//            make.top.equalToSuperview().offset(200)
//            make.bottom.equalToSuperview()
//            make.right.equalToSuperview()
////            make.left.equalToSuperview().offset(100)
//            make.left.equalToSuperview()
//        }
//
//        searchOptionView.addSubview(swiftButton)
//        swiftButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(100)
//        }
//
//        searchOptionView.addSubview(javaButton)
//        javaButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(30)
//            make.left.equalToSuperview().offset(20)
//            make.width.equalTo(130)
//            make.height.equalTo(80)
//        }
//
//        searchOptionView.addSubview(closeButton)
//        closeButton.snp.makeConstraints { make in
//            make.height.equalTo(60)
//            make.right.equalToSuperview().offset(-30)
//            make.left.equalToSuperview().offset(30)
//            make.bottom.equalToSuperview().offset(-40)
//        }
    }
    
   
    
    @objc func javaBtnTapped() {
        print("@")
        searchBar.text = javaButton.titleLabel?.text

        javaButton.backgroundColor = UIColor.systemGray2
        javaButton.isEnabled = false
        
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        

        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func javaScriptBtnTapped() {
        searchBar.text = javaScriptButton.titleLabel?.text
        
        javaScriptButton.backgroundColor = UIColor.systemGray2
        javaScriptButton.isEnabled = false
        
        javaButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func typeScriptBtnTapped() {
        print("@")
        searchBar.text = typeScriptButton.titleLabel?.text
        
        typeScriptButton.backgroundColor = UIColor.systemGray2
        typeScriptButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true

        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func pythonBtnTapped() {
        print("@")
        searchBar.text = pythonButton.titleLabel?.text
        
        pythonButton.backgroundColor = UIColor.systemGray2
        pythonButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
        
    }
    
    @objc func rubyBtnTapped() {
        print("@")
        searchBar.text = rubyButton.titleLabel?.text
        
        rubyButton.backgroundColor = UIColor.systemGray2
        rubyButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func phpBtnTapped() {
        print("@")
        searchBar.text = phpButton.titleLabel?.text
        
        phpButton.backgroundColor = UIColor.systemGray2
        phpButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func swiftBtnTapped() {
        print("@")
        searchBar.text = swiftButton.titleLabel?.text
        
        swiftButton.backgroundColor = UIColor.systemGray2
        swiftButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func kotlinBtnTapped() {
        print("@")
        searchBar.text = kotlinButton.titleLabel?.text
        
        kotlinButton.backgroundColor = UIColor.systemGray2
        kotlinButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func flutterBtnTapped() {
        print("@")
        searchBar.text = flutterButton.titleLabel?.text
        
        flutterButton.backgroundColor = UIColor.systemGray2
        flutterButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func cBtnTapped() {
        print("@")
        searchBar.text = cButton.titleLabel?.text
        
        cButton.backgroundColor = UIColor.systemGray2
        cButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func csharpBtnTapped() {
        print("@")
        searchBar.text = csharpButton.titleLabel?.text
        
        csharpButton.backgroundColor = UIColor.systemGray2
        csharpButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func cplusBtnTapped() {
        print("@")
        searchBar.text = cplusButton.titleLabel?.text
        
        cplusButton.backgroundColor = UIColor.systemGray2
        cplusButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func goBtnTapped() {
        print("@")
        searchBar.text = goButton.titleLabel?.text
        
        goButton.backgroundColor = UIColor.systemGray2
        goButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func rustBtnTapped() {
        print("@")
        searchBar.text = rustButton.titleLabel?.text
        
        rustButton.backgroundColor = UIColor.systemGray2
        rustButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func scalaBtnTapped() {
        print("@")
        searchBar.text = scalaButton.titleLabel?.text
        
        scalaButton.backgroundColor = UIColor.systemGray2
        scalaButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func rBtnTapped() {
        print("@")
        searchBar.text = rButton.titleLabel?.text
        
        rButton.backgroundColor = UIColor.systemGray2
        rButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        htmlButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func htmlBtnTapped() {
        print("@")
        searchBar.text = htmlButton.titleLabel?.text
        
        htmlButton.backgroundColor = UIColor.systemGray2
        htmlButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        cssButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        cssButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func cssBtnTapped() {
        print("@")
        searchBar.text = cssButton.titleLabel?.text
        
        cssButton.backgroundColor = UIColor.systemGray2
        cssButton.isEnabled = false
        
        javaButton.isEnabled = true
        javaScriptButton.isEnabled = true
        typeScriptButton.isEnabled = true
        pythonButton.isEnabled = true
        rubyButton.isEnabled = true
        phpButton.isEnabled = true
        swiftButton.isEnabled = true
        kotlinButton.isEnabled = true
        flutterButton.isEnabled = true
        cButton.isEnabled = true
        csharpButton.isEnabled = true
        cplusButton.isEnabled = true
        goButton.isEnabled = true
        rustButton.isEnabled = true
        scalaButton.isEnabled = true
        rButton.isEnabled = true
        htmlButton.isEnabled = true
        
        javaButton.backgroundColor = Asset.basePink.color
        javaScriptButton.backgroundColor = Asset.basePink.color
        typeScriptButton.backgroundColor = Asset.basePink.color
        pythonButton.backgroundColor = Asset.basePink.color
        rubyButton.backgroundColor = Asset.basePink.color
        phpButton.backgroundColor = Asset.basePink.color
        swiftButton.backgroundColor = Asset.basePink.color
        kotlinButton.backgroundColor = Asset.basePink.color
        flutterButton.backgroundColor = Asset.basePink.color
        cButton.backgroundColor = Asset.basePink.color
        csharpButton.backgroundColor = Asset.basePink.color
        cplusButton.backgroundColor = Asset.basePink.color
        goButton.backgroundColor = Asset.basePink.color
        rustButton.backgroundColor = Asset.basePink.color
        scalaButton.backgroundColor = Asset.basePink.color
        rButton.backgroundColor = Asset.basePink.color
        htmlButton.backgroundColor = Asset.basePink.color
    }
    
    @objc func starButtonTapped() {
        print("☆")
    }
    
    @objc func forkButtonTapped() {
        print("フォーク")
    }
    
    
    
    
    @objc func closeButtonTapped() {
        searchOptionView.removeFromSuperview()
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
