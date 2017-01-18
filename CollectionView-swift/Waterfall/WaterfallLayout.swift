//
//  WaterfallLayout.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

protocol WaterfallLayoutDelegate {
  
  // Request height of photo
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
  
  // Request annotation for photo
  func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
  
  var delegate: WaterfallLayoutDelegate!
  
  // Configure number of columns and cell padding.
  var numberOfColumns = 2
  var cellPadding: CGFloat = 6.0
  
  // This is an array to cache the calculated attributes.
  /*
   When you call prepareLayout(), you'll calculate the attribute for all items and add them to the cache.
   When the collection view later requests the layout attributes, you can be efficient and query the cache instead of recalculating them every time.
   */
  private var cache = [WaterfallLayoutAttributes]()
  
  // This declares two properties to store the content size.
  // contentHeight is incremented as photos are added
  private var contentHeight: CGFloat = 0.0
  // contentWidth is calculated based on the collection view width and its content inset
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return collectionView!.bounds.width - (insets.left + insets.right)
  }
  
  // Variable overrides
  
  /*
   This overrides collectionViewContentSize variable of the abstract parent class, and returns the size of the collection view's contents.
   To do this, you use both contentWidth and contentHeight calculated in the previous steps.
   */
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  /*
   This overrides layoutAttributesClass variable to tell the collection view to use WaterfallLayoutAttributes whenever it creates layout attributes objects.
   */
  
  override class var layoutAttributesClass: AnyClass {
    return WaterfallLayoutAttributes.self
  }
  
  override func prepare() {
    // Only calculate if cache is empty
    if cache.isEmpty {
      /*
       This declares and fills the xOffset array with the x-coordinate for every column based on the column widths.
       */
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset = [CGFloat]()
      for column in 0..<numberOfColumns {
        xOffset.append(CGFloat(column) * columnWidth)
      }
      
      /*
       This yOffset array tracks the y-position for every column.
       You initialize each value in yOffset to 0, since this is the offset of the first time in each column.
       */
      var column = 0
      var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
      
      // Iterates through the list of items in the first section
      for item in 0..<collectionView!.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        
        // Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
        // Width is the previously calculated cellWidth, with the padding between cells removed.
        let width = columnWidth - cellPadding * 2
        let photoHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
        let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
        
        // Calculate the frame height based on those heights and the predefined cellPadding.
        // for the top and bottom
        let height = cellPadding + photoHeight + annotationHeight + cellPadding
        
        /*
         Combine this with the x and y offsets of the current column to create the insetFrame used by the attribute
         */
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // Creates an instance of WaterfallLayoutAttributes.
        let attributes = WaterfallLayoutAttributes(forCellWith: indexPath)
        attributes.photoHeight = photoHeight
        // Sets its frame using insetFrame.
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // Updates the collection view content height
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        if column >= (numberOfColumns - 1) {
          column = 0
        } else {
          column = column + 1
        }
      }
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
}
