//
//  PhotoViewController.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/18.
//  Copyright © 2019 Fhu. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import CoreData

class PhotoViewController: UIViewController {
  
  var captureSession: AVCaptureSession?
  var videoCaptureDevice: AVCaptureDevice?
  var stillImageOutput: AVCaptureStillImageOutput?
  var previewLayer: AVCaptureVideoPreviewLayer?
  var photoImage: UIImage!
  var takePhotoShowing: Bool = true
  var shootDate: String {
    let currentTime = Date()
    let formatter = DateFormatter.init()
    formatter.dateFormat = "yyyy/MM/dd hh:mma"
    let timeString = formatter.string(from: currentTime)
    return timeString
  }
  
  @IBOutlet weak var cameraContainerView: UIView!
  
  @IBOutlet weak var nameThePhotoView: UIView!
  
  @IBOutlet weak var nameField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCamera()
    setupView()
  }
  
  func setupView() {
    nameThePhotoView.isHidden = true
    view.sendSubviewToBack(nameThePhotoView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if takePhotoShowing {
      startCamera()
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    if takePhotoShowing {
      stopCamera()
    }
  }
  
  func showTakePhoto() {
    startCamera()
    view.layoutIfNeeded()
    takePhotoShowing = true
  }
  
  @IBAction func takePhotoButtonTapped(_ sender: Any) {
    takePhoto { [weak self] (image) in
      guard let weakSelf = self, let image = image else {
        print(#function + " weakSelf or the image was nil")
        return
      }
      weakSelf.photoImage = image
      weakSelf.takePhotoShowing = false
      weakSelf.nameThePhotoView.isHidden = false
      weakSelf.view.bringSubviewToFront(weakSelf.nameThePhotoView)
    }
  }
  
  @IBAction func namePhotoBtnTapped(_ sender: Any) {
    let name = nameField.text ?? "photo"
    saveThePhoto(with: name)
    nameThePhotoView.isHidden = true
    view.sendSubviewToBack(nameThePhotoView)
    stopCamera()
    
    navigationController?.popToRootViewController(animated: true)
  }
  
  func saveThePhoto(with name: String) {
    saveImageToDB(image: photoImage, imageName: name, shootDate: shootDate)
  }
  
  func saveImageToDB(image: UIImage, imageName: String, shootDate: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    //Insert data into Picture Entity
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context)
    
    // Save values getting from titleView in title coloum in database
    entity.setValue(imageName, forKey: "title")
    
    // Save value getting from dateView in date coloum in database
    entity.setValue(shootDate, forKey: "shootDate")
    
    // Save value getting from ImageUploadView in date coloum in database
    entity.setValue(image.pngData(), forKey: "image")
    
    do{
      try context.save()
      // alert to inform user, success of the submission
      let alert = UIAlertController(title: "Cogratulations", message: "Successfully Updated the Database", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      
      alert.show(self, sender: nil)
    }
    catch{
      //alert user to error of submission
      let alert = UIAlertController(title: "Sorry", message: "Error While Updating Database", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      alert.show(self, sender: nil)
    }
  }
}
