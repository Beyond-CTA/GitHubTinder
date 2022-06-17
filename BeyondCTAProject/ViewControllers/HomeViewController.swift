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

    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = L10n.searchPlacaholder
        searchBar.searchTextField.textColor = Asset.searchBar.color
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.backgroundColor = Asset.searchBar.color
        searchBar.layer.shadowColor = UIColor.gray.cgColor
        searchBar.layer.shadowOpacity = 1
        searchBar.layer.shadowRadius = 4
        searchBar.searchTextField.layer.cornerRadius = 20
//        searchBar.layer.cornerRadius = 20
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        return searchBar
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
        
        viewModel.output.cardViews
            .subscribe(onNext: { [weak self] items in
                guard let me = self else { return }
                me.configureCards(items: items)
            }).disposed(by: disposeBag)
        
        viewModel.output.noResults
            .subscribe(onNext: { [weak self]  _ in
                guard let me = self else { return }
                me.showNoResultsAlert(searchText: me.searchBar.text ?? "")
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = Asset.base.color
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.height.equalTo(32)
        }
        
        view.addSubview(deckView)
        deckView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCards(items: [CardView]) {
        items.forEach { cardView in
            deckView.addSubview(cardView)
            cardView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func showNoResultsAlert(searchText: String) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.info)
        view.configureDropShadow()
        view.configureContent(
            title: L10n.noResultsAlertTitle(searchText),
            body: L10n.noResultsAlertBody,
            iconText: L10n.noResultsAlertIcon
        )
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
}
