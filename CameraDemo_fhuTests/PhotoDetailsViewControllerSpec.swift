//
//  PhotoDetailsViewControllerSpec.swift
//  CameraDemo_fhuTests
//
//  Created by Hufang on 2019/6/23.
//  Copyright © 2019 Fhu. All rights reserved.
//

import Quick
import Nimble
import SpecTools

@testable import CameraDemo_fhu
class PhotoDetailsViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: PhotoDetailsViewController!
    
    describe("PhotoDetailsViewControllerSpec") {
      beforeEach {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoDetailsViewController = storyboard.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as? PhotoDetailsViewController else {
          print(#function + " failed to create photoDetailsViewController.")
          return
        }
        subject = photoDetailsViewController
        
        guard let image = UIImage.init(named: "kid") else {
          print(#function + " failed to create image.")
          return
        }
        let photoModel = PhotoModel.init(photoImage: image,
                                         photoName: "photoName",
                                         shootDate: "2019/06/22 01:01PM")
        subject.setup(photoDetails: photoModel)
        
      }
      context("check view") {
        
        it("view can display") {
          expect(subject.photoDetails).toNot(beNil())
          expect(subject.photoImageView).toNot(beNil())
        }
      }
    }
  }
}
