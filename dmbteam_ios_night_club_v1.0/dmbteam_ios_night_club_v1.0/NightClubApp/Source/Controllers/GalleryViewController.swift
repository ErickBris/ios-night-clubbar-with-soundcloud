//
//  GalleryViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var galleryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        title = "Gallery"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let galleryThumbsVC = segue.destinationViewController as! GalleryThimbnailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = galleryTableView.indexPathForCell(cell)
        let gallery = Galleries.sharedGalleries.galleries[indexPath!.row]
        galleryThumbsVC.gallery = gallery
    }
}

extension GalleryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Galleries.sharedGalleries.galleries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GalleryCell", forIndexPath: indexPath) as! GalleryTableViewCell
        let gallery = Galleries.sharedGalleries.galleries[indexPath.row]
        cell.galleryImageView.setImageWithPath(gallery.coverImage)
        cell.dateLabel.text = gallery.date
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
