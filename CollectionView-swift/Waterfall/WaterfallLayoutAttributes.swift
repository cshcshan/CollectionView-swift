//
//  WaterfallLayoutAttributes.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class WaterfallLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // This declares the photoHeight property that the cell will use to resize its image view.
  var photoHeight: CGFloat = 0.0
  
  /* Override copyWithZero to conform to NSCopying protocol
   Subclasses of UICollectionViewLayoutAttributes need to conform to the NSCopying protocol because the attribute's objects can be copied internally.
   You override this method to guarantee that the photoHeight property is set when the object is copied.
   */
  override func copy(with zone: NSZone? = nil) -> Any {
    let copy = super.copy(with: zone) as! WaterfallLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  /* Override isEqual
   The collection view determines whether the attributes have changed by comparing the old and new attribute objects using isEqual(_:).
   You must implement it to compare the custom properties of your subclass.
   The code compares the photoHeight of both instances, and if they are equal, calls super to determine if the inherited attributes are the same; if the photo heights are different, it return false.
   */
  override func isEqual(_ object: Any?) -> Bool {
    if let attributes = object as? WaterfallLayoutAttributes {
      if attributes.photoHeight == photoHeight {
        return super.isEqual(object)
      }
    }
    return false
  }
}
