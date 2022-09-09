//
//  HomeViewController.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 1022/04/27.
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
    
    private let searchOptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 30
        return view
    }()
    
    private var searchOptionViewHeight = 0
    private var searchOptionViewWidth = 0
    
    // 画面の大きさ
    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height
    
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
        button.addTarget(self, action: #selector(openSearchOption), for: .touchUpInside)
        return button
    }()
    
    var selectedLanguage = ""
    private var selectedButton: UIButton?
    
    //MARK: 言語ボタン
    private let javaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Java", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let javaScriptButton: UIButton = {
        let button = UIButton()
        button.setTitle("JavaScript", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let typeScriptButton: UIButton = {
        let button = UIButton()
        button.setTitle("TypeScript", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let pythonButton: UIButton = {
        let button = UIButton()
        button.setTitle("Python", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let rubyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ruby", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let phpButton: UIButton = {
        let button = UIButton()
        button.setTitle("PHP", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let swiftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Swift", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let kotlinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kotlin", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let dartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dart", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let cButton: UIButton = {
        let button = UIButton()
        button.setTitle("C", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let csharpButton: UIButton = {
        let button = UIButton()
        button.setTitle("C#", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let rustButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rust", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let scalaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Scala", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    
    
    private let cplusButton: UIButton = {
        let button = UIButton()
        button.setTitle("C++", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let rButton: UIButton = {
        let button = UIButton()
        button.setTitle("R", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let htmlButton: UIButton = {
        let button = UIButton()
        button.setTitle("HTML", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    private let cssButton: UIButton = {
        let button = UIButton()
        button.setTitle("CSS", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(optionLanguageTapped(with:)), for: .touchUpInside)
        return button
    }()
    
    
    private let starButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.star.image, for: .normal)
        button.setTitle("star", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        //スターはすでに選択されているのでグレー、選択できない
        button.backgroundColor = Asset.basePink.color
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let forkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "tuningfork"), for: .normal)
        button.setTitle("fork", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGray2
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(forkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("クリア", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("閉じる", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Asset.basePink.color
        button.layer.cornerRadius = 10
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
        configureSearchOptionViewUI()
        
//MARK: searchOptionViewの動きをすぐ見たいときは下記のコメントアウトを外す
//        self.view.addSubview(searchOptionView)
//        searchOptionView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom).offset(20)
//            make.bottom.equalToSuperview().offset(-30)
//            make.right.equalToSuperview().offset(-10)
//            make.left.equalToSuperview().offset(10)
//        }
        
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
                me.searchOptionView.removeFromSuperview()
                me.viewModel.input.searchButtonClicked.onNext(())
                me.collectionView.setContentOffset(CGPoint(x: -10, y: 0), animated: false)
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
    
    @objc func openSearchOption() {
        searchOptionView.alpha = 1
        view.addSubview(searchOptionView)
        searchOptionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-30)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    @objc func optionLanguageTapped(with button: UIButton) {
        if (selectedButton != nil) {
            selectedButton?.backgroundColor = UIColor.systemGray2
            selectedButton?.isEnabled = true
        }
        button.backgroundColor = Asset.basePink.color
        button.isEnabled = false
        selectedLanguage = (button.titleLabel?.text) ?? ""
        selectedButton = button
    }
    
    @objc func starButtonTapped() {
        starButton.backgroundColor = Asset.basePink.color
        starButton.isEnabled = false
        
        forkButton.isEnabled = true
        forkButton.backgroundColor = UIColor.systemGray2
    }
    
    @objc func forkButtonTapped() {
        forkButton.backgroundColor = Asset.basePink.color
        forkButton.isEnabled = false
        
        starButton.isEnabled = true
        starButton.backgroundColor = UIColor.systemGray2
    }
    
    @objc func resetBtnTapped() {
        selectedLanguage = ""
        selectedButton?.isEnabled = true
        selectedButton?.backgroundColor = UIColor.systemGray2
    }

    @objc func closeButtonTapped() {
        UIView.animate(withDuration: 0.2, delay: 0.05, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.searchOptionView.alpha = 0.05
        }) { [weak self] _ in
            guard let me = self else { return }
            me.searchOptionView.removeFromSuperview()
            me.searchBar.rx.text.orEmpty
                .bind(to: me.viewModel.input.searchText)
                .disposed(by: me.disposeBag)
            me.viewModel.input.optionLanguage.onNext(me.selectedLanguage)
            me.viewModel.input.searchButtonClicked.onNext(())
            me.collectionView.setContentOffset(CGPoint(x: -10, y: 0), animated: false)
        }
        print("選ばれた言語は", selectedLanguage)
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-50)
            make.height.equalTo(32)
        }
        
        view.addSubview(optionButton)
        optionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(searchBar)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    private func configureSearchOptionViewUI() {
        
        //MARK: LanguageButton
        
        searchOptionView.addSubview(javaButton)
        javaButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(javaScriptButton)
        javaScriptButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(typeScriptButton)
        typeScriptButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        
        searchOptionView.addSubview(pythonButton)
        pythonButton.snp.makeConstraints { make in
            make.top.equalTo(javaButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(rubyButton)
        rubyButton.snp.makeConstraints { make in
            make.top.equalTo(javaScriptButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(phpButton)
        phpButton.snp.makeConstraints { make in
            make.top.equalTo(typeScriptButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        
        searchOptionView.addSubview(swiftButton)
        swiftButton.snp.makeConstraints { make in
            make.top.equalTo(pythonButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(kotlinButton)
        kotlinButton.snp.makeConstraints { make in
            make.top.equalTo(rubyButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(dartButton)
        dartButton.snp.makeConstraints { make in
            make.top.equalTo(phpButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        
        
        searchOptionView.addSubview(cButton)
        cButton.snp.makeConstraints { make in
            make.top.equalTo(swiftButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(csharpButton)
        csharpButton.snp.makeConstraints { make in
            make.top.equalTo(kotlinButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(cplusButton)
        cplusButton.snp.makeConstraints { make in
            make.top.equalTo(dartButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        
        
        searchOptionView.addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.top.equalTo(cButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(rustButton)
        rustButton.snp.makeConstraints { make in
            make.top.equalTo(csharpButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(scalaButton)
        scalaButton.snp.makeConstraints { make in
            make.top.equalTo(cplusButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        
        searchOptionView.addSubview(rButton)
        rButton.snp.makeConstraints { make in
            make.top.equalTo(goButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(htmlButton)
        htmlButton.snp.makeConstraints { make in
            make.top.equalTo(rustButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(cssButton)
        cssButton.snp.makeConstraints { make in
            make.top.equalTo(scalaButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        //MARK: CloseButton
        searchOptionView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(width / 8)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        //MARK: FillerButton
        searchOptionView.addSubview(starButton)
        starButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(closeButton.snp.top).offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(forkButton)
        forkButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(closeButton.snp.top).offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
        }
        
        searchOptionView.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(closeButton.snp.top).offset(-10)
            make.width.equalTo(width / 3.5)
            make.height.equalTo(width / 8)
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
            width: view.frame.width - 50,
            height: collectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
