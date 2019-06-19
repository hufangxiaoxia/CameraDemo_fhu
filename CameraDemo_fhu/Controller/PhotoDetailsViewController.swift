//
//  PhotoDetailsViewController.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/19.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailsViewController: UIViewController {
  var photoDetails: PhotoModel?
  @IBOutlet weak var photoImageView: UIImageView!
  
  public func setup(photoDetails: PhotoModel) {
    self.photoDetails = photoDetails
    self.photoImageView.image = photoDetails.photoImage
  }

  @IBAction func backBtnTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
