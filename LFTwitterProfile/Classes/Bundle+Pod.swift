//
//  Bundle+Pod.swift
//  Pods
//
//  Created by Roy Tang on 2/11/2016.
//
//

import Foundation

extension Bundle {
  static func bundleFromPod() -> Bundle? {
    let bundle = Bundle.init(for: TwitterProfileViewController.self)
    if let url = bundle.url(forResource: "LFTwitterProfile", withExtension: "bundle") {
      return Bundle.init(url: url)
    }
    
    return nil
  }
}
