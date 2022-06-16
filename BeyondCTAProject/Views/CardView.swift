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
import RxGesture
import RxSwift
import MarkdownView

final class CardView: UIView {
    
    // MARK: - Properties
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.base.color
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.cardBackground.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
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
    
    private let tagView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.tag.color
        view.layer.cornerRadius = 10
        return view
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
    
    private let css = [
        "* { color:white !important;}"
        ].joined(separator: "\n")
    
    private let readmeView: MarkdownView = {
        let view = MarkdownView()
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let readmeBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.alpha = 0.9
        return view
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
    
    convenience init(item: RepositoryInfoModel) {
        self.init()
        setupCellData(item: item)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(backImageView)
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
        
        addSubview(readmeBackView)
        readmeBackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp_bottomMargin).offset(12)
            make.left.right.equalToSuperview()
        }
        
        readmeBackView.addSubview(readmeView)
        readmeView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(readmeBackView)
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
            make.left.equalTo(self).offset(24)
            make.bottom.equalTo(self).offset(-10)
        }
        
        let contributorsStack = UIStackView(arrangedSubviews: [contributorImageView, contributorsCount])
        contributorsStack.axis = .horizontal
        contributorsStack.spacing = 8
        
        contributorImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        addSubview(contributorsStack)
        contributorsStack.snp.makeConstraints { make in
            make.centerY.equalTo(starStack)
            make.right.equalTo(self).offset(-24)
        }
        
        configureGestureRecognizer()
    }
    
    func setupCellData(item: RepositoryInfoModel) {
        print("DEBUG: ITEM IS \(item)")
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
        descriptionLabel.text = item.description
    }
    
    private func configureGestureRecognizer() {
        backImageView.rx.panGesture()
            .when(.began)
            .subscribe(onNext: { [superview] _ in
                superview?.subviews.forEach { $0.layer.removeAllAnimations() }
            }).disposed(by: disposeBag)
        
        backImageView.rx.panGesture()
            .when(.changed)
            .subscribe(onNext: { [weak self] sender in
                guard let me = self else { return }
                me.panCard(sneder: sender)
            }).disposed(by: disposeBag)
        
        backImageView.rx.panGesture()
            .when(.ended)
            .subscribe(onNext: { [weak self] sender in
                guard let me = self else { return }
                me.resetCardPosition(sender: sender)
            }).disposed(by: disposeBag)
    }
}

// MARK: - Enum extensions

extension CardView {
    private enum SwipeDirection: Int {
        case left = -1
        case right = 1
    }
}

// MARK: - PanGesture extensions

extension CardView {
    private func resetCardPosition(sender: UIPanGestureRecognizer) {
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1,
            options: .curveEaseOut,
            animations: {
                
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
        })
    }
    
    private func panCard(sneder: UIPanGestureRecognizer) {
        let translation = sneder.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
}
