//
//  GalleryThimbnailsViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class GalleryThimbnailsViewController: UIViewController {
    var gallery: Gallery? {
        didSet {
            title = gallery?.date
        }
    }
    
    @IBOutlet weak var thumbnailsCollectionView: UICollectionView!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let galleryImageVC = segue.destinationViewController as! GalleryImageViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = thumbnailsCollectionView.indexPathForCell(cell)
        let imageURL = gallery?.photos[indexPath!.row].URL
        galleryImageVC.imageURL = imageURL
    }
}

extension GalleryThimbnailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard gallery != nil else {
            return 0
        }
        
        return gallery!.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCell", forIndexPath: indexPath) as! ThumbnailCollectionViewCell
        if let thumbPath = gallery?.photos[indexPath.row].thumbURL {
            cell.imageView.setImageWithPath(thumbPath)
        } else {
            let fullImageURL = gallery?.photos[indexPath.row].URL
            cell.imageView.setImageWithPath(fullImageURL!)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemWidth = floor((CGRectGetWidth(collectionView.bounds) - 4*2) / 3)
        
        return CGSize(width: itemWidth, height: itemWidth*1.4)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
}
