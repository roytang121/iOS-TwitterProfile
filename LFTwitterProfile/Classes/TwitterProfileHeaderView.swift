//
//  TwitterProfileHeaderView.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 1/10/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import Foundation
import UIKit

class TwitterProfileHeaderView: UIView {
  @IBOutlet weak var iconHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  let maxHeight: CGFloat = 80
  let minHeight: CGFloat = 50
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.iconHeightConstraint.constant = maxHeight
  }
  
  func animator(t: CGFloat) {
//    print(t)
    
    if t < 0 {
      iconHeightConstraint.constant = maxHeight
      return
    }
    
    let height = max(maxHeight - (maxHeight - minHeight) * t, minHeight)
    
    iconHeightConstraint.constant = height
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    descriptionLabel.sizeToFit()
    let bottomFrame = descriptionLabel.frame
    let iSize = descriptionLabel.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    let resultSize = CGSize.init(width: size.width, height: bottomFrame.origin.y + iSize.height)
    return resultSize
  }
}
