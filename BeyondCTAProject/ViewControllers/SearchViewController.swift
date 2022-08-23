//
//  SearchViewController.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/11.
//

import UIKit
import RxSwift

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        searchButton.rx.tap
            .subscribe(with: self,
                       onNext: { me, _ in
                me.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
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
    }
}
