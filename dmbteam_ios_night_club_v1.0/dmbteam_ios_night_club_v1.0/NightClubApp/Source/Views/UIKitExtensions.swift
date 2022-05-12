//
//  UIKitExtensions.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard layer.borderColor != nil else { return nil }
            
            return UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.CGColor
        }
    }
}

extension UIImage {
    
    class func navigationBarBackgroundImage(colors: [UIColor], frame: CGRect) -> UIImage {
        // start with a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        // add colors as CGCologRef to a new array and calculate the distances
        var colorsRef : [CGColorRef] = []
        
        for i in 0 ... colors.count-1 {
            colorsRef.append(colors[i].CGColor as CGColorRef)
        }
        
        gradientLayer.colors = colorsRef
        gradientLayer.locations = [0.0, 1.0]
        
        // now build a UIImage from the gradient
        UIGraphicsBeginImageContext(frame.size)
        gradientLayer.renderInContext(UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // return the gradient image
        return gradientImage
    }
    
     func scaledImage(scaledWidth: CGFloat) -> UIImage {
        let oldWidth = size.width;
        let scaleFactor = scaledWidth / oldWidth;
        let newHeight = size.height * scaleFactor;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledWidth, newHeight), false, 0);
        self.drawInRect(CGRectMake(0, 0, scaledWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
}

// MARK:
// MARK: UIImageView+AssetsCache
extension UIImageView {
    
    func setImageWithPath(imagePath: String, cacheIdentifier: String = "LOCAL") {
        
        if imagePath.hasPrefix("http") {
            if let url = NSURL(string: imagePath) {
                self.af_setImageWithURL(url)
            }
            
        } else {
            
            let dummyRequest = NSURLRequest(URL: NSURL(fileURLWithPath: imagePath))
            
            if let cachedProductPhoto = UIImageView.af_sharedImageDownloader.imageCache?.imageForRequest(dummyRequest, withAdditionalIdentifier:cacheIdentifier) {
                self.image = cachedProductPhoto
            } else {
                if let image = Image(named: imagePath) {
                    self.image = image
                    UIImageView.af_sharedImageDownloader.imageCache?.addImage(image, forRequest: dummyRequest, withAdditionalIdentifier: cacheIdentifier)
                }
            }
        }
    }
}
