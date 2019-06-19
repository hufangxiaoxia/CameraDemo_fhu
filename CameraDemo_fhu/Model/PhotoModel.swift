//
//  PhotoModel.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/19.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Foundation
import UIKit

struct PhotoModel {
  let photoImage: UIImage
  let photoName: String
  let shootDate: String
  
  init(photoImage: UIImage,
       photoName: String,
       shootDate: String) {
    self.photoImage = photoImage
    self.photoName = photoName
    self.shootDate = shootDate
  }
}
