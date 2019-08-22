//
//  CollectionViewFlowLayout.swift
//  collectionview-swift
//
//  Created by Han Chen on 21/06/2017.
//  Copyright © 2017 Han Chen. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func prepare() {
    super.prepare()
    minimumLineSpacing = 10 // 設定行與行之間最小距離(vertical)
    minimumInteritemSpacing = 10 // 設定兩個item之間最小距離(horizontal)
    itemSize = CGSize(width: 100, height: 100)
    estimatedItemSize = CGSize(width: 50, height: 50) // defaults to CGSize.zero - setting a non-zero size enables cells that self-size via preferredLayoutAttributesFittingAttributes
    scrollDirection = .horizontal // default is .vertical
    /*
     - 如果是垂直滑動，高度有作用，寬度無作用
     - 如果是水平滑動，高度無作用，寬度有作用
     */
    headerReferenceSize = CGSize(width: 100, height: 20) // 每個section的header的size
    footerReferenceSize = CGSize(width: 100, height: 50) // 每個section的footer的size
    sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // 設定section的內邊距
    sectionHeadersPinToVisibleBounds = false // Set these properties to true to get headers that pin to the top of the screen and footeds that pin to the bottom while scrolling (similar to UITableView)
    sectionFootersPinToVisibleBounds = false
  }
}

extension CollectionViewFlowLayout: UICollectionViewDelegateFlowLayout {
  
  /*
   以下代理方法是針對indexPath對應的item進行客製化設定
   如果使用的是UICollectionViewFlowLayout，將自動呼叫以下方法
   */
  
  // 設定特定cell大小(itemSize)
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 80, height: 80)
  }
  
  // 設定sections的每一個cell的上下左右空白距離(內邊距)
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
  }
  
  // 設定sections的cells行間距(vertical)
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  
  // 設定sections的items(列)間距(horizontal)
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  
  // 設定sections的header的size，其含義也會由滑動方向決定
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: 100, height: 30)
  }
  
  // 設定sections的footer的size，其含義也會由滑動方向決定
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: 100, height: 50)
  }
}
