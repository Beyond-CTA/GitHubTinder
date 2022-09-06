//
//  CardCell.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/27.
//

import UIKit
import SnapKit
import Nuke
import RxNuke
import RxSwift
import MarkdownView

final class CardCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.cardBackground.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.8
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60 / 2
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Reactive Programming in Swift"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private let toWebViewIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up.forward.app")
//        imageView.tintColor = Asset.basePink.color
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let css = [
        "* { color:white !important;}",
        "code { color:black !important;}",
        "code { background-color:white !important;}",
        "pre { color:black !important;}",
        "pre { background-color:white !important;}",
        "span { color:black !important;}",
        ].joined(separator: "\n")
    
    private let readmeView: MarkdownView = {
        let view = MarkdownView()
//        view.backgroundColor = .clear
        view.backgroundColor = .black
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let readmeBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.8
        return view
    }()
    
    let noReadmeLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.noReadmeText
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 2
        label.alpha = 0
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.text = "2.1k stars"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    private let contributorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.contributorsSample.image
        imageView.layer.cornerRadius = 30 / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let contributorsCount: UILabel = {
        let label = UILabel()
        label.text = "+ 320 people contributors"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
        
    private var disposeBag = DisposeBag()
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        backImageView.layer.cornerRadius = 30
        
        addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(32)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp_bottomMargin).offset(12)
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(12)
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        }
        
        addSubview(toWebViewIcon)
        toWebViewIcon.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        addSubview(readmeBackView)
        readmeBackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp_bottomMargin).offset(12)
            make.left.right.equalToSuperview()
        }
        
        readmeBackView.addSubview(readmeView)
        readmeView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(readmeBackView)
        }
        
        addSubview(noReadmeLabel)
        noReadmeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(readmeBackView).offset(-100)
            make.left.equalTo(readmeBackView).offset(43)
            make.right.equalTo(readmeBackView).offset(-43)
        }
        
        let starStack = UIStackView(arrangedSubviews: [starImageView, starCountLabel])
        starStack.axis = .horizontal
        starStack.spacing = 6
        
        starImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        addSubview(starStack)
        starStack.snp.makeConstraints { make in
            make.top.equalTo(readmeView.snp_bottomMargin).offset(20)
//            make.left.equalTo(self).offset(24)
            make.right.equalTo(self).offset(-24)
            make.bottom.equalTo(self).offset(-10)
        }
        
//        let contributorsStack = UIStackView(arrangedSubviews: [contributorImageView, contributorsCount])
//        contributorsStack.axis = .horizontal
//        contributorsStack.spacing = 8
//
//        contributorImageView.snp.makeConstraints { make in
//            make.size.equalTo(CGSize(width: 30, height: 30))
//        }
//
//        addSubview(contributorsStack)
//        contributorsStack.snp.makeConstraints { make in
//            make.centerY.equalTo(starStack)
//            make.right.equalTo(self).offset(-24)
//        }
    }
    
    func setupCellData(item: RepositoryInfoModel) {
        nameLabel.text = item.fullName

        guard let url = URL(string: item.avatarURL) else { return }
        ImagePipeline.shared.rx.loadImage(with: url)
            .subscribe(onSuccess: { [profileImageView] in
                profileImageView.image = $0.image
            }).disposed(by: disposeBag)
        
        starCountLabel.text = "\(item.stargazersCount) stars"
        
        // called when rendering finished
//        readmeView.onRendered = { [weak self] height in
//          self?.readmeView.constant = height
//          self?.view.setNeedsLayout()
//        }
        readmeView.load(markdown: item.readmeBody, css: css)
        noReadmeLabel.alpha = item.readmeBody.isEmpty ? 0.8 : 0
        descriptionLabel.text = item.description
    }
}
