//
//  ViewController.swift
//  Tanstagram
//
//  Created by Julian Mino on 5/1/19.
//  Copyright © 2019 Julian Mino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet var images: [UIImageView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGestures()
    }
    
    //Set Gesture
    
    @IBAction func saveToPhotosTapGesture(_ sender: UITapGestureRecognizer) {
        renderImage()
    }
    
    func renderImage() {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { (goTo) in view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        UIImageWriteToSavedPhotosAlbum(image, self,                                      #selector(ViewController.renderComplete), nil)
    }
    
    func renderComplete(_image: UIImage, didFinishSavingWithError
        error: Error?, contextInfo:UnsafeRawPointer) {
        if let error = error {
            // Error Occurred
            let alert = UIAlertController(title: "Something Went Wrong:(", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                present(alert, animated: true)
                } else {
                let alert = UIAlertController(title: "Photo Saved!", message: "Your image has been saved to your Camera Roll.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                present(alert, animated: true)
        }
    }
                
                
    func pinchGesture(imageView: UIImageView) -> UIPinchGestureRecognizer {
        return UIPinchGestureRecognizer(target: self, action: #selector(ViewController.handlePinch))
    }
    
    func panGesture(imageView: UIImageView) -> UIPanGestureRecognizer {
        return UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan))
    }
    
    func rotationGesture(imageView: UIImageView) -> UIRotationGestureRecognizer {
        return UIRotationGestureRecognizer(target: self, action: #selector(ViewController.handleRotation))
    }
    
    //Handle Gestures
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    //Create Gestures
    
    func createGestures() {
        for shapes in images {
            let pinch = pinchGesture(imageView: shapes)
            let pan = panGesture(imageView: shapes)
            let rotation = rotationGesture(imageView: shapes)
            shapes.addGestureRecognizer(pinch)
            shapes.addGestureRecognizer(pan)
            shapes.addGestureRecognizer(rotation)
        }
    }
    
    

}

