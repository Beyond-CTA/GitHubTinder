//
//  WebViewController.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/06/30.
//

import UIKit
import SnapKit
import RxSwift
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: - Properties
    private let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "optionButton")
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✗", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "basePink")
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())

    private let url: URL?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        backButton.rx.tap
            .subscribe(with: self,
                       onNext: { me, _ in
                me.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadWebView(url: url)
    }
    
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(statusBarHeight + 45)
        }
        
        headerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(statusBarHeight + 45)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func loadWebView(url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
