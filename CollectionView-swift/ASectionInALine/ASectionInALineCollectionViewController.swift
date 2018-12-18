//
//  ASectionInALineCollectionViewController.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2018/12/17.
//  Copyright © 2018 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class ASectionInALineCollectionViewController: UICollectionViewController {
    
    private var item_Array: [[String]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArray()
        setupCollectionView()
    }
    
    private func setupArray() {
        item_Array = []
        for i in 0..<5 {
            var sub_Array = [String]()
            for j in 0..<50 {
                sub_Array.append("\(i + 1) - \(j + 1)")
            }
            item_Array.append(sub_Array)
        }
    }
    
    private func setupCollectionView() {
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return item_Array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item_Array[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = item_Array[indexPath.section][indexPath.row]
        label.textColor = UIColor.white
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        cell.layer.cornerRadius = 5
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        var reusableView = UICollectionReusableView()
//        if kind == UICollectionElementKindSectionHeader {
//            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
//            reusableView.backgroundColor = UIColor.orange
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 40))
//            label.textAlignment = .center
//            label.text = "Section \(indexPath.section)"
//            label.textColor = UIColor.white
//            reusableView.addSubview(label)
//        } else if kind == UICollectionElementKindSectionFooter {
//
//        }
//        return reusableView
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell: \(indexPath.section + 1) - \(indexPath.row + 1)")
    }
}
