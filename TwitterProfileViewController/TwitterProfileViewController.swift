//
//  TwitterProfileViewController.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 30/9/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import UIKit
import SnapKit

class TwitterProfileViewController: UIViewController {
  
  // Constants
  let stickyheaderContainerViewHeight: CGFloat = 125
  
  let bouncingThreshold: CGFloat = 100
  
  let scrollToScaleDownProfileIconDistance: CGFloat = 60
  
  let profileHeaderViewHeight: CGFloat = 160
  
  let segmentedControlContainerHeight: CGFloat = 46
  
  // Properties
  
  enum TableViewContentType: Int {
    case tweets = 0, photos = 1, favorites = 2
  }
  
  var contentType: TableViewContentType = .tweets {
    didSet { self.updateTableViewContent() }
  }
  
  var currentTableView: UITableView {
    switch contentType {
    case .tweets:
      return self.tweetTableView
    case .photos:
      return self.photosTableView
    case .favorites:
      return self.favoritesTableView
    default:
      return self.tweetTableView
    }
  }
  
  
  var mainScrollView: UIScrollView!
  
  var headerCoverView: UIImageView!
  
  var profileHeaderView: TwitterProfileHeaderView!
  
  var stickyHeaderContainerView: UIView!
  
  var blurEffectView: UIVisualEffectView!
  
  var tweetTableView: UITableView!
  var photosTableView: UITableView!
  var favoritesTableView: UITableView!
  
  var segmentedControl: UISegmentedControl!
  
  var segmentedControlContainer: UIView!
  
  var navigationDetailLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNeedsStatusBarAppearanceUpdate()
    
    self.prepareViews()
    
    self.setupTables()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // configure layout frames
    self.stickyHeaderContainerView.frame = self.computeStickyHeaderContainerViewFrame()
    
    self.profileHeaderView.frame = self.computeProfileHeaderViewFrame()
    
    self.segmentedControlContainer.frame = self.computeSegmentedControlContainerFrame()
    
    self.tweetTableView.frame = self.computeTableViewFrame(tableView: tweetTableView)
    self.photosTableView.frame = self.computeTableViewFrame(tableView: photosTableView)
    self.favoritesTableView.frame = self.computeTableViewFrame(tableView: favoritesTableView)
    
    self.updateMainScrollViewFrame()
    
    self.mainScrollView.scrollIndicatorInsets = computeMainScrollViewIndicatorInsets()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
}

extension TwitterProfileViewController {
  
  func prepareViews() {
    let _mainScrollView = TouchRespondScrollView(frame: self.view.bounds)
    _mainScrollView.delegate = self
    _mainScrollView.showsHorizontalScrollIndicator = false
    
    self.mainScrollView  = _mainScrollView
    
    self.view.addSubview(_mainScrollView)
    
    _mainScrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
    // sticker header Container view
    let _stickyHeaderContainer = UIView()
    _stickyHeaderContainer.clipsToBounds = true
    _mainScrollView.addSubview(_stickyHeaderContainer)
    self.stickyHeaderContainerView = _stickyHeaderContainer
    
    // Cover Image View
    let coverImageView = UIImageView()
    coverImageView.clipsToBounds = true
    _stickyHeaderContainer.addSubview(coverImageView)
    coverImageView.snp.makeConstraints { (make) in
      make.edges.equalTo(_stickyHeaderContainer)
    }
    
    coverImageView.image = UIImage(named: "background.png")
    coverImageView.contentMode = .scaleAspectFill
    coverImageView.clipsToBounds = true
    self.headerCoverView = coverImageView
    
    // blur effect on top of coverImageView
    let blurEffect = UIBlurEffect(style: .dark)
    let _blurEffectView = UIVisualEffectView(effect: blurEffect)
    _blurEffectView.alpha = 0
    self.blurEffectView = _blurEffectView
    
    _stickyHeaderContainer.addSubview(_blurEffectView)
    _blurEffectView.snp.makeConstraints { (make) in
      make.edges.equalTo(_stickyHeaderContainer)
    }
    
    // Detail Title
    let _navigationDetailLabel = UILabel()
    _navigationDetailLabel.text = "121 Tweets"
    _navigationDetailLabel.textColor = UIColor.white
    _navigationDetailLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
    _stickyHeaderContainer.addSubview(_navigationDetailLabel)
    _navigationDetailLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(_stickyHeaderContainer.snp.centerX)
      make.bottom.equalTo(_stickyHeaderContainer.snp.bottom).inset(8)
    }
    self.navigationDetailLabel = _navigationDetailLabel
    
    // Navigation Title
    let _navigationTitleLabel = UILabel()
    _navigationTitleLabel.text = "Roy Tang"
    _navigationTitleLabel.textColor = UIColor.white
    _navigationTitleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
    _stickyHeaderContainer.addSubview(_navigationTitleLabel)
    _navigationTitleLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(_stickyHeaderContainer.snp.centerX)
      make.bottom.equalTo(_navigationDetailLabel.snp.top).offset(4)
    }
    
    // ProfileHeaderView
    if let _profileHeaderView = Bundle.main.loadNibNamed("TwitterProfileHeaderView", owner: self, options: nil)?.first as? TwitterProfileHeaderView {
      _mainScrollView.addSubview(_profileHeaderView)
      self.profileHeaderView = _profileHeaderView
    }
    
    
    // Segmented Control Container
    let _segmentedControlContainer = UIView()
    _segmentedControlContainer.backgroundColor = UIColor.white
    _mainScrollView.addSubview(_segmentedControlContainer)
    self.segmentedControlContainer = _segmentedControlContainer
    
    // Segmented Control
    let _segmentedControl = UISegmentedControl()
    _segmentedControl.addTarget(self, action: #selector(self.segmentedControlValueDidChange(sender:)), for: .valueChanged)
    _segmentedControl.backgroundColor = UIColor.white

    _segmentedControl.insertSegment(withTitle: "Tweets", at: 0, animated: false)
    _segmentedControl.insertSegment(withTitle: "Photos", at: 1, animated: false)
    _segmentedControl.insertSegment(withTitle: "Favorites", at: 2, animated: false)
    _segmentedControl.selectedSegmentIndex = 0
    _segmentedControlContainer.addSubview(_segmentedControl)

    self.segmentedControl = _segmentedControl
    
    _segmentedControl.snp.makeConstraints { (make) in
//      make.edges.equalTo(_segmentedControlContainer).inset(UIEdgeInsetsMake(8, 16, 8, 16))
      make.leading.equalTo(_segmentedControlContainer.snp.leading).inset(8)
      make.right.equalTo(_segmentedControlContainer.snp.right).inset(8)
      make.centerY.equalTo(_segmentedControlContainer.snp.centerY)
    }
    
    
    // TableViews
    let _tweetTableView = UITableView(frame: _mainScrollView.bounds, style: .plain)
    _mainScrollView.addSubview(_tweetTableView)
    self.tweetTableView = _tweetTableView
    
    let _photosTableView = UITableView(frame: _mainScrollView.bounds, style: .plain)
    _mainScrollView.addSubview(_photosTableView)
    self.photosTableView = _photosTableView
    
    let _favoritesTableView = UITableView(frame: _mainScrollView.bounds, style: .plain)
    _mainScrollView.addSubview(_favoritesTableView)
    self.favoritesTableView = _favoritesTableView
  }
  
  func setupTables() {
    self.tweetTableView.delegate = self
    self.tweetTableView.dataSource = self
    self.tweetTableView.register(UITableViewCell.self, forCellReuseIdentifier: "tweetCell")
    
    self.photosTableView.delegate = self
    self.photosTableView.dataSource = self
    self.photosTableView.isHidden = true
    self.photosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "photoCell")
    
    self.favoritesTableView.delegate = self
    self.favoritesTableView.dataSource = self
    self.favoritesTableView.isHidden = true
    self.favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favCell")
  }
  
  func computeStickyHeaderContainerViewFrame() -> CGRect {
    return CGRect(x: 0, y: 0, width: mainScrollView.bounds.width, height: stickyheaderContainerViewHeight)
  }
  
  func computeProfileHeaderViewFrame() -> CGRect {
    return CGRect(x: 0, y: computeStickyHeaderContainerViewFrame().origin.y + stickyheaderContainerViewHeight, width: mainScrollView.bounds.width, height: profileHeaderViewHeight)
  }
  
  func computeTableViewFrame(tableView: UITableView) -> CGRect {
    let upperViewFrame = computeSegmentedControlContainerFrame()
    return CGRect(x: 0, y: upperViewFrame.origin.y + upperViewFrame.height , width: mainScrollView.bounds.width, height: tableView.contentSize.height)
  }
  
  func computeMainScrollViewIndicatorInsets() -> UIEdgeInsets {
    return UIEdgeInsetsMake(self.computeSegmentedControlContainerFrame().originBottom, 0, 0, 0)
  }
  
  func computeNavigationFrame() -> CGRect {
    return headerCoverView.convert(headerCoverView.bounds, to: self.view)
  }
  
  func computeSegmentedControlContainerFrame() -> CGRect {
    let rect = computeProfileHeaderViewFrame()
    return CGRect(x: 0, y: rect.origin.y + rect.height, width: mainScrollView.bounds.width, height: segmentedControlContainerHeight)
    
  }
  
  func updateMainScrollViewFrame() {
    
    let bottomHeight = max(currentTableView.bounds.height, 800)
    
    self.mainScrollView.contentSize = CGSize(
      width: view.bounds.width,
      height: stickyheaderContainerViewHeight + profileHeaderViewHeight + segmentedControlContainer.bounds.height + bottomHeight)
  }
}

extension TwitterProfileViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    
    let contentOffset = scrollView.contentOffset
    
    // sticky headerCover
    if contentOffset.y <= 0 {
      let bounceProgress = min(1, abs(contentOffset.y) / bouncingThreshold)
      
      let newHeight = abs(contentOffset.y) + self.stickyheaderContainerViewHeight
      
      // adjust stickyHeader frame
      self.stickyHeaderContainerView.frame = CGRect(x: 0, y: contentOffset.y, width: mainScrollView.bounds.width, height: newHeight)
      
      // blurring effect amplitude
      self.blurEffectView.alpha = min(1, bounceProgress * 2)
      
      // scaling effect
      let scalingFactor = 1 + min(log(bounceProgress + 1), 2)
//      print(scalingFactor)
      self.headerCoverView.transform = CGAffineTransform(scaleX: scalingFactor, y: scalingFactor)
      
      // adjust mainScrollView indicator insets
      var baseInset = computeMainScrollViewIndicatorInsets()
      baseInset.top += abs(contentOffset.y)
      self.mainScrollView.scrollIndicatorInsets = baseInset
    } else {
      
      // anything to be set if contentOffset.y is positive
      self.blurEffectView.alpha = 0
      self.mainScrollView.scrollIndicatorInsets = computeMainScrollViewIndicatorInsets()
    }
    
    // Universal
    // applied to every contentOffset.y
    let scaleProgress = max(0, min(1, contentOffset.y / self.scrollToScaleDownProfileIconDistance))
    self.profileHeaderView.animator(t: scaleProgress)
    
    if contentOffset.y > 0 {
    
      // When scroll View reached the threshold
      if contentOffset.y >= scrollToScaleDownProfileIconDistance {
        self.stickyHeaderContainerView.frame = CGRect(x: 0, y: contentOffset.y - scrollToScaleDownProfileIconDistance, width: mainScrollView.bounds.width, height: stickyheaderContainerViewHeight)
        
        // bring stickyHeader to the front
        self.mainScrollView.bringSubview(toFront: self.stickyHeaderContainerView)
      } else {
        self.mainScrollView.bringSubview(toFront: self.profileHeaderView)
        self.stickyHeaderContainerView.frame = computeStickyHeaderContainerViewFrame()
      }
      
      // Sticky Segmented Control
      let navigationLocation = CGRect(x: 0, y: 0, width: stickyHeaderContainerView.bounds.width, height: stickyHeaderContainerView.frame.origin.y - contentOffset.y + stickyHeaderContainerView.bounds.height)
      let navigationHeight = navigationLocation.height - abs(navigationLocation.origin.y)
      let segmentedControlContainerLocationY = stickyheaderContainerViewHeight + profileHeaderViewHeight - navigationHeight
      
      if contentOffset.y > 0 && contentOffset.y >= segmentedControlContainerLocationY {
  //    if segmentedControlLocation.origin.y <= navigationHeight {
        segmentedControlContainer.frame = CGRect(x: 0, y: contentOffset.y + navigationHeight, width: segmentedControlContainer.bounds.width, height: segmentedControlContainer.bounds.height)
      } else {
        segmentedControlContainer.frame = computeSegmentedControlContainerFrame()
      }
      
      // Override
      // When scroll View reached the top edge of Title label
      if let titleLabel = profileHeaderView.titleLabel, let usernameLabel = profileHeaderView.usernameLabel  {
        
        // titleLabel location relative to self.view
        let titleLabelLocationY = stickyheaderContainerViewHeight - 35
        
        let totalHeight = titleLabel.bounds.height + usernameLabel.bounds.height + 35
        let detailProgress = max(0, min((contentOffset.y - titleLabelLocationY) / totalHeight, 1))
        blurEffectView.alpha = detailProgress
        animateNaivationTitleAt(progress: detailProgress)
      }
    }
    // Segmented control is always on top in any situations
    self.mainScrollView.bringSubview(toFront: segmentedControlContainer)
  }
}

// MARK: Animators
extension TwitterProfileViewController {
  func animateNaivationTitleAt(progress: CGFloat) {
    
    guard let superview = self.navigationDetailLabel?.superview else {
      return
    }
    
    let totalDistance: CGFloat = 75
    
    if progress >= 0 {
      let distance = (1 - progress) * totalDistance
      self.navigationDetailLabel.snp.updateConstraints({ (make) in
        make.bottom.equalTo(superview.snp.bottom).inset(8 - distance)
      })
    }
  }
}

// MARK: UITableViewDelegates & DataSources
extension TwitterProfileViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case self.tweetTableView:
      return 30
    case self.photosTableView:
      return 10
    case self.favoritesTableView:
      return 0
    default:
      return 10
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView {
    case self.tweetTableView:
      let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
      cell.textLabel?.text = "Row \(indexPath.row)"
      return cell
      
    case self.photosTableView:
      let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
      cell.textLabel?.text = "Photo \(indexPath.row)"
      return cell
      
    case self.favoritesTableView:
      let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
      cell.textLabel?.text = "Fav \(indexPath.row)"
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}

// status bar style override
extension TwitterProfileViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

// Table View Switching

extension TwitterProfileViewController {
  func updateTableViewContent() {
    print("contentType did changed \(self.contentType)")
  }
  
  internal func segmentedControlValueDidChange(sender: AnyObject?) {
    self.contentType = TableViewContentType(rawValue: self.segmentedControl.selectedSegmentIndex)!
    
    let tableViewToBeShown: UITableView! = self.currentTableView
    
    [tweetTableView, photosTableView, favoritesTableView].forEach { (tableView) in
      tableView?.isHidden = tableView != tableViewToBeShown
    }
    
    tableViewToBeShown.frame = self.computeTableViewFrame(tableView: tableViewToBeShown)
    self.updateMainScrollViewFrame()
    
    // auto scroll to top if mainScrollView.contentOffset > navigationHeight + segmentedControl.height
    let navigationFrame = self.computeNavigationFrame()
    let navigationHeight = navigationFrame.height - abs(navigationFrame.origin.y)
    let threshold = self.computeProfileHeaderViewFrame().originBottom - navigationHeight
    
    if mainScrollView.contentOffset.y > threshold {
      self.mainScrollView.setContentOffset(CGPoint(x: 0, y: threshold), animated: false)
    }
  }
}

extension CGRect {
  var originBottom: CGFloat {
    return self.origin.y + self.height
  }
}
