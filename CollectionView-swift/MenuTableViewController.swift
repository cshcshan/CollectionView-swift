//
//  MenuTableViewController.swift
//  CollectionView-swift
//
//  Created by Han Chen on 2017/1/18.
//  Copyright © 2017年 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController: UITableViewController {
  
  private let menu_Array = ["Drag and Drop Cell", "Zoom Cell", "Adsorb Cell", "Waterfall Cell", "A Section In A Line"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  private func setupTableView() {
    automaticallyAdjustsScrollViewInsets = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menu_Array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = menu_Array[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      performSegue(withIdentifier: "DragAndDropSegue", sender: nil)
    case 1:
      performSegue(withIdentifier: "ZoomSegue", sender: nil)
    case 2:
      performSegue(withIdentifier: "AdsorbSegue", sender: nil)
    case 3:
      performSegue(withIdentifier: "WaterfallSegue", sender: nil)
    case 4:
      performSegue(withIdentifier: "ASectionInALineSegue", sender: nil)
    default: break
    }
  }
}
