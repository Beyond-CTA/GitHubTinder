//
//  UICollectionView+Cell.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/06/27.
//

import UIKit

extension UICollectionView {
    func remainCellsCount(cellIndexPath: IndexPath) -> Int {
        let allCellsCount = Array(0 ..< numberOfSections).reduce(0) { sum, sectionIndex -> Int in
            return sum + numberOfItems(inSection: sectionIndex)
        }
        let cellsInAboveSectionCount = Array(0 ..< cellIndexPath.section).reduce(0) { sum, sectionIndex -> Int in
            return sum + numberOfItems(inSection: sectionIndex)
        }
        return allCellsCount - cellsInAboveSectionCount - cellIndexPath.row
    }
}
