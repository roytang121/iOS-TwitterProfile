//
//  RoundButton.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 3/10/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import Foundation
import UIKit

class RoundButton: UIButton {
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIApplication.shared.delegate?.window??.tintColor.cgColor
    self.layer.cornerRadius = 4.0
  }
}
