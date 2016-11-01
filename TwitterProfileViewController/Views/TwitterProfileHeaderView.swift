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
}
