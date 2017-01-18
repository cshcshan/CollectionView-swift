//
//  AdsorbFlowLayout.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class AdsorbFlowLayout: UICollectionViewFlowLayout {
  
  private let ITEM_SIDE: CGFloat = 200
  private let ITEM_MARGIN: CGFloat = 20
  
  override func prepare() {
    super.prepare()
    // 初始化
    itemSize = CGSize(width: ITEM_SIDE, height: collectionView!.frame.height / 2)
    scrollDirection = .horizontal
    minimumLineSpacing = 10
    sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    // 計算scrollview最後停留範圍
    var lastRect = collectionView?.frame
    lastRect?.origin = proposedContentOffset
    
    // 取得範圍內的所有屬性
    let array = layoutAttributesForElements(in: lastRect!)
    
    // 起始值，即預設情況下要停下來的X值
    let startX = proposedContentOffset.x
    print("startX: \(startX)")
    
    // 遍歷所有屬性
    var adjustOffsetX: CGFloat = CGFloat(MAXFLOAT)
    for attrs: UICollectionViewLayoutAttributes in array! {
      let attrsX = attrs.frame.minX
      let attrsW = attrs.frame.width
      print("attrsX: \(attrsX), attrsW: \(attrsW)")
      if startX - attrsX < attrsW / 2 {
        adjustOffsetX = -(startX - attrsX + ITEM_MARGIN)
      } else {
        adjustOffsetX = attrsW - (startX - attrsX)
      }
      break // 取得第一組即可
    }
    return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return super.layoutAttributesForElements(in: rect)
  }
}
