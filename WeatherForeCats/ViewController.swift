//
//  ViewController.swift
//  WeatherForeCats
//
//  Created by FumikoIshizawa on 2016/02/05.
//  Copyright © 2016年 fumikoi. All rights reserved.
//

import APIKit
import UIKit

class ViewController: UIViewController {
  let topViewModel = TopViewModel()
  var city: String = "新潟"
  var id: String = "150010"
  var detailLabelExpanded: Bool = false
  @IBOutlet weak var todayWeatherImageView: UIImageView!
  @IBOutlet weak var todayWeatherTitleLabel: UILabel!
  @IBOutlet weak var todayWeatherDetailLabel: UILabel!
  @IBOutlet weak var topNavigationItem: UINavigationItem!
  @IBOutlet weak var forecastCollectionView: UICollectionView!
  @IBOutlet weak var expandButton: UIButton!
  
  var firstLaunch: Bool {
    let ud = NSUserDefaults.standardUserDefaults()
    let data = ud.objectForKey("firstLaunch") as? Bool ?? false
    return data
  }
  
  @IBAction func expandButtonTouchUpInside(sender: UIButton) {
    detailLabelExpanded = detailLabelExpanded ? false : true
    updateDetailLabelExpand()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let configButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "onClickConfigButton:")
    topNavigationItem.setRightBarButtonItem(configButton, animated: true)
    todayWeatherDetailLabel.preferredMaxLayoutWidth = 250
    let successBlock = { [weak self] in
      self!.updateLabels()
    }
    
    prepareForUseCollectionView()
    
    if !firstLaunch {
      city = readLocalData("city")
      id = readLocalData("id")
    }
    topViewModel.prepareForeUse(id, block: successBlock)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func prepareForUseCollectionView() {
    forecastCollectionView.delegate = self
    forecastCollectionView.dataSource = self
    
    let nibName = "ForecastCollectionViewCell"
    let nib = UINib(nibName: nibName, bundle: nil)
    forecastCollectionView.registerNib(nib, forCellWithReuseIdentifier: nibName)
  }
}


// MARK: - View 
extension ViewController {
  private func updateLabels() {
    todayWeatherTitleLabel.text = topViewModel.todayWeatherTitle
    todayWeatherDetailLabel.text = topViewModel.todayWeatherDetail
    let imagePath = topViewModel.todayWeatherImageViewPath
    todayWeatherImageView.image = UIImage(named: imagePath)
    updateDetailLabelExpand()
    forecastCollectionView.reloadData()
    SVProgressHUD.dismiss()
  }
  
  private func updateDetailLabelExpand() {
    if detailLabelExpanded {
      expandButton.setImage(UIImage(named: "markUp"), forState: .Normal)
    } else {
      expandButton.setImage(UIImage(named: "markDown"), forState: .Normal)
    }
    todayWeatherDetailLabel.numberOfLines = detailLabelExpanded ? 0 : 2
  }
  
  private func configureCell(cell: ForecastCollectionViewCell, row: Int) {
    if let forecast = topViewModel.loadForecastOfCity(row) {
      cell.setLabelContent(forecast)
    }
  }
}


// MARK: - Action
extension ViewController {
  internal func onClickConfigButton(sender: UIButton) {
    let storyBoard = UIStoryboard(name: "PrefectureViewController", bundle: nil)
    if let prefectureViewController = storyBoard.instantiateInitialViewController() as? PrefectureViewController {
      prefectureViewController.dismissWindowBlock = { [weak self] (title: String, id: String) in
        self!.city = title
        self!.id = id
        self!.topViewModel.updateData(id)
        self!.storeLocalData(title, id: id)
      }
      let navController = UINavigationController(rootViewController: prefectureViewController)
      self.presentViewController(navController, animated: true, completion: nil)
    } 
  }
  
  func storeLocalData(title: String, id: String) {
    let ud = NSUserDefaults.standardUserDefaults()
    ud.setObject(title, forKey: "city")
    ud.setObject(id, forKey: "id")
    ud.setObject(false, forKey: "firstLaunch")
    ud.synchronize()
  }
  
  func readLocalData(key: String) -> String {
    let ud = NSUserDefaults.standardUserDefaults()
    let data = ud.objectForKey(key) as? String ?? ""
    return data
  }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ForecastCollectionViewCell", forIndexPath: indexPath)
    if let cell = cell as? ForecastCollectionViewCell {
      configureCell(cell, row: indexPath.row)
    }
    return cell
  }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
}


// MARK: - UICollectionViewLayoutFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let size = CGSizeMake(UIScreen.mainScreen().bounds.size.width / 2, 200)
    return size
  }
}
