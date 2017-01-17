//
//  TheCollectionViewController.swift
//  DragAndDropCollectionViewCell-swift
//
//  Created by Han Chen on 2017/1/17.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

// http://nshint.io/blog/2015/07/16/uicollectionviews-now-have-easy-reordering/

import Foundation
import UIKit

class TheCollectionViewController: UICollectionViewController {
  
  private var array: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupArray()
    self.setupCollectionView()
  }
  
  private func setupArray() {
    array = []
    for index in 0..<100 {
      array.append(index + 1)
    }
  }
  
  private func setupCollectionView() {
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
    collectionView?.addGestureRecognizer(longPressGesture)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.contentView.backgroundColor = UIColor.lightGray
    for view in cell.contentView.subviews {
      view.removeFromSuperview()
    }
    let label = UILabel(frame: cell.bounds)
    label.text = String(array[indexPath.row])
    label.textColor = UIColor.white
    label.textAlignment = .center
    cell.contentView.addSubview(label)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    print("collectionView(_:moveItemAt:to:) - sourceIndexPath: \(sourceIndexPath), destinationIndexPath: \(destinationIndexPath)")
  }
  
  func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
    switch gesture.state {
    case .began:
      print("handleLongPressGesture began")
      guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
        break
      }
      collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
    case .changed:
      print("handleLongPressGesture changed")
      collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
    case .ended:
      print("handleLongPressGesture ended")
      collectionView?.endInteractiveMovement()
    case .cancelled, .failed, .possible:
      print("handleLongPressGesture cancelled")
      collectionView?.cancelInteractiveMovement()
    }
  }
}
