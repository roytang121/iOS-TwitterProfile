//
//  RoundButton.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 3/10/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import Foundation
import UIKit

internal class RoundButton: UIButton {
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.borderWidth = 1.0
    self.layer.borderColor = TwitterProfileViewController.globalTint.cgColor
    self.layer.cornerRadius = 4.0
  }
}
