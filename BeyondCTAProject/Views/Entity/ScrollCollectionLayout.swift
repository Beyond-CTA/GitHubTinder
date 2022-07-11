//
//  ScrollCollectionLayout.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/06/11.
//

import UIKit

final class ScrollCollectionLayout: UICollectionViewFlowLayout {
    
    // MARK: - Propertirs
    
    private var lastCollectionViewSize: CGSize = .zero
    private var scalingOffset: CGFloat = 200
    private var minimumScaleFactor: CGFloat = 0.9
    private var minimumAlphaFactor: CGFloat = 0.3
    private var scaleItems: Bool = true
    
    // MARK: - Lifecycle
    
    init(size: CGSize) {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 100
        self.itemSize = itemSize
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        guard let collectionView = collectionView else { return }
        if collectionView.bounds.size != lastCollectionViewSize {
            configureInset()
            lastCollectionViewSize = collectionView.bounds.size
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let proposedRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
        guard let layoutAttributes = layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionView.bounds.width / 2
        
        for attribute in layoutAttributes {
            if attribute.representedElementCategory != .cell {
                continue
            }
            
            if candidateAttributes == nil {
                candidateAttributes = attribute
                continue
            }
            
            if abs(attribute.center.x - proposedContentOffsetCenterX) <
                abs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                candidateAttributes = attribute
            }
        }
        
        guard let aCandidateAttributes = candidateAttributes else {
            return proposedContentOffset
        }
        
        var newOffsetX = aCandidateAttributes.center.x - collectionView.bounds.size.width / 2
        let offset = newOffsetX - collectionView.contentOffset.x
        
        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
            let pageWidth = itemSize.width + minimumLineSpacing
            newOffsetX += velocity.x > 0 ? pageWidth : -pageWidth
        }
        
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView,
              let superAttributes = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        if scaleItems == false {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let contentOffset = collectionView.contentOffset
        let size = collectionView.bounds.size
        
        let visibleRect = CGRect(x: contentOffset.x, y: contentOffset.y, width: size.width, height: size.height)
        let visibleCenterX = visibleRect.midX
        
        guard case let newAttributesArray as [UICollectionViewLayoutAttributes] =
                NSArray(array: superAttributes, copyItems: true) else { return nil }
        newAttributesArray.forEach {
            let distanceFromCenter = visibleCenterX - $0.center.x
            let absDistanceFromCenter = min(abs(distanceFromCenter), scalingOffset)
            let scale = absDistanceFromCenter * (minimumScaleFactor - 1) / scalingOffset + 1
            $0.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
            
            let alpha = absDistanceFromCenter * (minimumAlphaFactor - 1) / scalingOffset + 1
            $0.alpha = alpha
        }
        
        return newAttributesArray
    }
    
    private func configureInset() {
        guard let collectionView = collectionView else { return }
        let inset =  collectionView.bounds.size.width / 2 - itemSize.width / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.contentOffset = CGPoint(x: -inset, y: 0)
    }
}

