//
//  PhotoViewController+Camera.swift
//  CameraDemo_fhu
//
//  Created by Hufang on 2019/6/18.
//  Copyright © 2019 Fhu. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

extension PhotoViewController {
  func setupCamera() {
    captureSession = AVCaptureSession()
    guard let captureSession = captureSession else {
      print("unable to create AVCaptureSession")
      return
    }
    
    videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
    
    guard let videoCaptureDevice = videoCaptureDevice else {
      print("unable to create AVCaptureDevice")
      return
    }
    
    var videoInput: AVCaptureDeviceInput?
    
    do {
      videoInput = try AVCaptureDeviceInput( device: videoCaptureDevice )
    }
    catch {
      print("Failed to get video input")
      handleFailure()
      return
    }
    
    if captureSession.canSetSessionPreset(AVCaptureSession.Preset.photo) {
      captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    if let videoInput = videoInput,
      captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    }
    else {
      print("Failed to add input to capture session")
      handleFailure()
      return
    }
    
    stillImageOutput = AVCaptureStillImageOutput()
    stillImageOutput?.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
    if let stillImageOutput = stillImageOutput,
      captureSession.canAddOutput(stillImageOutput) {
      captureSession.addOutput(stillImageOutput)
    }
    else {
      print("Failed to add output to capture session")
      handleFailure()
      return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer( session: captureSession )
    guard let previewLayer = previewLayer else {
      print("unable to create AVCaptureVideoPreviewLayer")
      return
    }
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    cameraContainerView.layer.addSublayer(previewLayer)
  }
  
  fileprivate func handleFailure() {
    captureSession = nil
  }
  
  func startCamera() {
    if let captureSession = captureSession, captureSession.isRunning == false {
      captureSession.startRunning()
    }
  }
  
  func stopCamera() {
    if let captureSession = captureSession, captureSession.isRunning == true {
      captureSession.stopRunning()
    }
  }

  func takePhoto(_ imageBlock: @escaping (_ image: UIImage?)->()) {
    guard let stillImageOutput = stillImageOutput else {
      print("failed to get still image output")
      imageBlock(nil)
      return
    }
    
    guard let videoConnection = stillImageOutput.connection(with: AVMediaType.video) else {
      print("failed to get still connectionWithMediaType")
      imageBlock(nil)
      return
    }
    
    stillImageOutput.captureStillImageAsynchronously(from: videoConnection) { (imageDataSampleBuffer, error) -> Void in
      if error != nil {
        print("Error capturing still image: \(error)")
        imageBlock(nil)
      }
      else {
        guard let imageDataSampleBuffer = imageDataSampleBuffer,
          let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer) else {
          print("Error converting image to jpeg")
          imageBlock(nil)
          return
        }
        let image = UIImage(data: imageData)
        self.photoImage = image
        imageBlock(image)
      }
    }
  }
}
