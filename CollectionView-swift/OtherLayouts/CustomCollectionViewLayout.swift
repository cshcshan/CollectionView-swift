//
//  CustomCollectionViewLayout.swift
//  collectionview-swift
//
//  Created by Han Chen on 21/06/2017.
//  Copyright © 2017 Han Chen. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
  
  /*
   自定義layout中5個override的功能
   */

  /*
   呼叫時機：
   - collectionview第一次佈局
   - collectionview更新時
   */
  override func prepare() {
    super.prepare()
  }
  
  /*
   指定給定的區域cell的尺寸(可一次性返回所有cell尺寸，也可每隔一個距離返回cells)
   input: 系統傳入一個區域的rect
   output: 回傳該區域內的item資訊
   
   [UICollectionViewLayoutAttributes]
   @property (nonatomic) CGRect frame; // view的frame
   @property (nonatomic) CGPoint center; // view中心點
   @property (nonatomic) CGSize size; // view尺寸
   @property (nonatomic) CATransform3D transform3D; // 可用來作3D動畫
   @property (nonatomic) CGRect bounds;
   @property (nonatomic) CGAffineTransform transform; // 轉場屬性
   @property (nonatomic) CGFloat alpha; // 透明度
   @property (nonatomic) NSInteger zIndex; // default is 0，數字越大層級越高，放的越上面
   @property (nonatomic,  getter=isHidden) BOOL hidden; // As an optimization, UICollectionView might not create a view for items whose hidden attributes is true
   @property (nonatomic, strong) NSIndexPath *indexPath; // 如果是cell會有對應的indexPath
   // 判斷view是cell、supplementary view或是decoration view
   @property (nonatomic, readonly) UICollectionElementCategory representedElementCategory;
   @property (nonatomic, readonlym nullable) NSString *representedElementKind; // nil when representedElementCategory is UICollectionElementCategoryCell
   */
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var array = [UICollectionViewLayoutAttributes]()
    for indexPath in collectionView!.indexPathsForVisibleItems {
      if let attributes = collectionView!.layoutAttributesForItem(at: indexPath) {
        array.append(attributes)
      }
    }
    return array
  }
  
  /*
   設定scroll時是否更新(invalidate)佈局
   return true to cause the collection view to requery the layout for geometry information
   */
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  /*
   user手指放開時呼叫，用來設定最後偏移量
   */
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    // a layout can return the content offset to be applied during transition or update animations
    return proposedContentOffset
  }
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    // return a point at which to reset after scrolling - for layouts that want snap-to-point scrolling behavior
    return proposedContentOffset
  }
  
  /*
   因為collectionview繼承自scrollview，所以需要覆寫這個function，告訴contentSize大小
   */
  override var collectionViewContentSize: CGSize {
    return CGSize(width: collectionView!.bounds.width + 1, height: collectionView!.bounds.height + 1)
  }
}
