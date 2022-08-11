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
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    private let gradientLayer = CAGradientLayer()
    
    private let url: URL?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let me = self else { return }
                me.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientLayer.colors = [Asset.background.color, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)

        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).offset(24)
        }
    }
}
