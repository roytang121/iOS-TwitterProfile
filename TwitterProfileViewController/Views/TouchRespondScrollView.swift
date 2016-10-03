//
//  TouchRespondScrollView.swift
//  TwitterProfileViewController
//
//  Created by Roy Tang on 3/10/2016.
//  Copyright © 2016 NA. All rights reserved.
//

import Foundation
import UIKit

class TouchRespondScrollView: UIScrollView {
  
  required override init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.delaysContentTouches = false
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.delaysContentTouches = false
  }
  
  override func touchesShouldCancel(in view: UIView) -> Bool {
    if view.isKind(of: UIButton.self) {
      return true
    }
    
    return super.touchesShouldCancel(in: view)
  }
}
