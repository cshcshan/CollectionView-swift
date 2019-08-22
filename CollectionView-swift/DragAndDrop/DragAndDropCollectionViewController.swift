//
//  DragAndDropCollectionViewController.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class DragAndDropCollectionViewController: UICollectionViewController {
  
  private var item_Array: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupArray()
    setupCollectionView()
  }
  
  private func setupArray() {
    item_Array = []
    for item in 0..<100 {
      item_Array.append(item + 1)
    }
  }
  
  private func setupCollectionView() {
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    collectionView?.addGestureRecognizer(longPressGesture)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return item_Array.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = UIColor.lightGray
    for view in cell.contentView.subviews {
      view.removeFromSuperview()
    }
    let label = UILabel(frame: cell.contentView.bounds)
    label.text = String(item_Array[indexPath.row])
    label.textColor = UIColor.white
    label.textAlignment = .center
    cell.contentView.addSubview(label)
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
  }
  
  @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
    switch gesture.state {
    case .began:
      guard let selectedIndexPath = collectionView?.indexPathForItem(at: gesture.location(in: collectionView)) else {
        break
      }
      collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
    case .changed:
      collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
    case .ended:
      collectionView?.endInteractiveMovement()
    case .cancelled, .failed, .possible:
      collectionView?.cancelInteractiveMovement()
    default:
      break
    }
  }
}
