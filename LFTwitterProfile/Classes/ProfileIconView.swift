//
//  ProfileIconView.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 1/10/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import Foundation
import UIKit

internal class ProfileIconView: UIImageView {
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.layer.cornerRadius = 8.0
    self.layer.borderWidth = 3.0
    self.layer.borderColor = UIColor.white.cgColor
    self.clipsToBounds = true
  }
}
