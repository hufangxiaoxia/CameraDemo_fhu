//
//  PictureTableViewCell.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/19.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PictureTableViewCell: UITableViewCell {
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var photoName: UILabel!
  @IBOutlet weak var shootDate: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
