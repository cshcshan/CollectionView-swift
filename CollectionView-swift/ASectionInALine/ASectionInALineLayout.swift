//
//  ASectionInALineLayout.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2018/12/17.
//  Copyright © 2018 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class ASectionInALineLayout: UICollectionViewLayout {
    
    private var attributesArray = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat = 0.0
    private let direction = "V" // H: Horizontal, V: Vertical
    
    override func prepare() {
        super.prepare()
        guard collectionView != nil else { return }
        for section in 0..<collectionView!.numberOfSections {
            for row in 0..<collectionView!.numberOfItems(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let size = CGSize(width: 100, height: 50)
                var point = CGPoint.zero
                if direction == "H" {
                    point = CGPoint(x: size.width * CGFloat(indexPath.row), y: size.height * CGFloat(indexPath.section))
                } else {
                    point = CGPoint(x: size.width * CGFloat(indexPath.section), y: size.height * CGFloat(indexPath.row))
                }
                let frame = CGRect(origin: point, size: size)
                let insetFrame = frame.insetBy(dx: 5, dy: 5)
                attributes.frame = insetFrame
                contentWidth = max(contentWidth, frame.maxX)
                contentHeight = max(contentHeight, frame.maxY)
                attributesArray.append(attributes)
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
}
