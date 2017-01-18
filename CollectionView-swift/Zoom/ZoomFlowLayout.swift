//
//  ZoomFlowLayout.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class ZoomFlowLayout: UICollectionViewFlowLayout {
  
  private let ITEM_SIDE: CGFloat = 50
  
  override func prepare() {
    super.prepare()
    itemSize = CGSize(width: ITEM_SIDE, height: collectionView!.frame.height / 2)
    scrollDirection = .horizontal
    minimumLineSpacing = ITEM_SIDE
    let inset = (collectionView!.frame.width - ITEM_SIDE) / 2
    sectionInset = UIEdgeInsets(top: 20, left: inset, bottom: 20, right: inset)
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    // 計算scroll view最後停留範圍
    var lastRect = collectionView?.frame
    lastRect?.origin = proposedContentOffset
    
    // 取出範圍內所有屬性
    let array = layoutAttributesForElements(in: lastRect!)
    
    // 取得螢幕最中間的X
    let centerX = proposedContentOffset.x + collectionView!.frame.width / 2
    print("targetContentOffset - centerX: \(centerX)")
    
    // 遍歷所有屬性
    var adjustOffsetX = CGFloat(MAXFLOAT)
    for attrs: UICollectionViewLayoutAttributes in array! {
      if abs(attrs.center.x - centerX) < abs(adjustOffsetX) {
        // 取出最小值
        adjustOffsetX = attrs.center.x - centerX
      }
    }
    
    return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleRect = collectionView?.frame
    visibleRect?.origin = collectionView!.contentOffset
    
    // 取得預設cell的UICollectionViewLayoutAttributes
    let array = super.layoutAttributesForElements(in: rect)
    
    // 取得螢幕最中間的X
    let centerX = collectionView!.contentOffset.x + collectionView!.frame.width / 2
    print("targetContentOffset - centerX: \(centerX)")
    
    // 遍歷所有屬性
    for attrs: UICollectionViewLayoutAttributes in array! {
      // 不是可見範圍就跳過
      if visibleRect?.intersects(attrs.frame) == false {
        continue
      }
      
      // 每個item的中心x
      let itemCenterX = attrs.center.x
      // 差距越小，縮放比例越大
      // 根據螢幕最中間的距離計算縮放比例
//      let scale: CGFloat = 1.0 + (1.0 - CGFloat(abs(itemCenterX - centerX)) / (collectionView!.frame.width) * 0.6) * 0.8
      let scale: CGFloat = 1.0 + (1.0 - CGFloat(abs(itemCenterX - centerX)) / (collectionView!.frame.width) * 1.2) * 0.9
      print("scale: \(scale)")
      attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0)
    }
    return array
  }
}
