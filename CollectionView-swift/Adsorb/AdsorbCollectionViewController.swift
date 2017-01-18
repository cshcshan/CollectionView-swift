//
//  AdsorbCollectionViewController.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class AdsorbCollectionViewController: UICollectionViewController {
  
  private var array: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupArray()
    setupCollectionView()
  }
  
  private func setupArray() {
    array = []
    for item in 0..<100 {
      array.append(item + 1)
    }
  }
  
  private func setupCollectionView() {
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = UIColor.lightGray
    for view in cell.contentView.subviews {
      view.removeFromSuperview()
    }
    let label = UILabel(frame: cell.contentView.bounds)
    label.text = String(array[indexPath.row])
    label.textColor = UIColor.white
    label.textAlignment = .center
    cell.contentView.addSubview(label)
    return cell
  }
}
