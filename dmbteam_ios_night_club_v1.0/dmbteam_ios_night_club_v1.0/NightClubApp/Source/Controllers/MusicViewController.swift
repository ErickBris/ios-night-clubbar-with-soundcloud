//
//  MusicViewController.swift
//  NightClubApp
//
//  Copyright © 2016 dmbTEAM. All rights reserved.
//

import UIKit
import Soundcloud
import AVFoundation
import KDEAudioPlayer
import AlamofireImage

enum Status: String {
    case NotLoaded = "NotLoaded"
    case Loading = "Loading"
    
    case LoadedButNotPlaying = "LoadedButNotPlaying"
    
    case Playing = "Playing"
    case Paused = "Paused"
}

class MusicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentPlayingTrackIndex = -1
    var status = Status.NotLoaded
    var currentTrackProgress = Float(0)
    
    let musicPlayer = AudioPlayer()
    
    var audioItems = [AudioItem]()
    var tracks = [Track]()
    
    var progressBar = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicPlayer.delegate = self
        Soundcloud.clientIdentifier = xmlClubInfo?.soundcloudSettings.clientID
        Soundcloud.clientSecret = xmlClubInfo?.soundcloudSettings.clientSecret
        
        title = "Music"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureFurCurrentStatus(false)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 && (status == .Playing || status == .Paused) {
            return 300
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 && (status == .Playing || status == .Paused) {
            let header = tableView.dequeueReusableCellWithIdentifier("NowPlayingSectionHeader") as! NowPlayingSectionHeaderCell
            if currentPlayingTrackIndex >= 0 {
                header.titleLabel.text = tracks[currentPlayingTrackIndex].title
                header.titleLabel.resetLabel()
                header.artistLabel.text = tracks[currentPlayingTrackIndex].createdBy.username
            }
            
            progressBar = header.progressBar
            progressBar.progress = currentTrackProgress
            
            header.playPauseButton.selected = status == .Paused
            
            if status == .Paused && !header.titleLabel.isPaused {
                header.titleLabel.pauseLabel()
            } else if status == .Playing {
                header.titleLabel.unpauseLabel()
            }
            
            header.nextButton.enabled = musicPlayer.items?.last != musicPlayer.currentItem
            header.prevButton.enabled = musicPlayer.items?.first != musicPlayer.currentItem
            
            if let coverURL = tracks[currentPlayingTrackIndex].artworkImageURL.highURL {
                header.coverImageView.af_setImageWithURL(coverURL)
            } else if let waveFormURL = tracks[currentPlayingTrackIndex].waveformImageURL.highURL {
                header.coverImageView.af_setImageWithURL(waveFormURL)
            }
            
            
            return header.contentView
        }
        
        return nil
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return tracks.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MusicCell")! as! TrackTableViewCell
        cell.configureForTrack(tracks[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if currentPlayingTrackIndex == indexPath.row {
            if status == .Playing {
                pauseCurrentTrack()
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            } else {
                playTrackWithIndex(indexPath.row, forceChangeTrack: false)
            }
        } else {
            playTrackWithIndex(indexPath.row, forceChangeTrack: true)
        }
    }
}

extension MusicViewController: AudioPlayerDelegate {
    
    @IBAction func prevButtonTapped(sender: UIButton) {
        musicPlayer.previous()
        currentTrackProgress = 0
        configureFurCurrentStatus(false)
    }
    
    @IBAction func playPauseButtonTapped(sender: UIButton) {
        playPauseTrackWithIndex(currentPlayingTrackIndex)
        
        if tableView.indexPathForSelectedRow == nil && status == .Playing {
            let newIndexPath = NSIndexPath(forRow: currentPlayingTrackIndex, inSection: 1)
            tableView.selectRowAtIndexPath(newIndexPath, animated: false, scrollPosition: .None)
        }
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        musicPlayer.next()
        currentTrackProgress = 0
        configureFurCurrentStatus(false)
    }
    
    func configureFurCurrentStatus(animated: Bool) {
        
        var insets = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        switch status {
        case .NotLoaded:
            startLoading()
        case .Loading:
            activityIndicator.startAnimating()
            tableView.hidden = true
            
        case .LoadedButNotPlaying:
            activityIndicator.stopAnimating()
            tableView.hidden = false
            tableView.reloadData()
            
        case .Playing, .Paused:
            insets = UIEdgeInsetsZero
            let firstSection = NSIndexSet(index: 0)
            tableView.reloadSections(firstSection, withRowAnimation: animated ? .Fade : .None)
        }
        
        tableView.contentInset = insets
    }
    
    func unableToLoadAction() {
        self.status = .LoadedButNotPlaying
        dispatch_async(dispatch_get_main_queue()) {
            self.configureFurCurrentStatus(true)
            self.status = .NotLoaded
            self.showUnableToLoadAlert()
        }
    }
    
    func showUnableToLoadAlert() {
        let alertController = UIAlertController(title: nil, message: "Cannot connect to SoundCloud. \nPlease try again later.", preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) in
            // Dismiss button tapped, do nothing
        }
        alertController.addAction(dismissAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func startLoading() {
        status = .Loading
        configureFurCurrentStatus(false)
        if let scPlaylistURL = xmlClubInfo?.soundcloudSettings.playlistURL {
            Soundcloud.resolve(scPlaylistURL) { resolve -> Void in
                
                if resolve.response.isSuccessful {
                    
                    if let playlistId = resolve.response.result?.playlist?.identifier {
                        self.loadPlaylist(playlistId)
                    } else {
                        self.unableToLoadAction()
                    }
                } else {
                    self.unableToLoadAction()
                }
            }
        } else {
            self.unableToLoadAction()
        }
    }
    
    func loadPlaylist(identifier: Int) {
        Playlist.playlist(identifier) { playlistResponse in
            if let tracks = playlistResponse.response.result?.tracks {
                self.tracks = tracks
                
                let trackUrls = tracks.map {
                    $0.streamURL
                }
                
                let audioItems = trackUrls.map {
                    AudioItem(mediumQualitySoundURL: $0)
                }
                
                var streamableItems = [AudioItem]()
                
                audioItems.forEach {
                    if let audionItem = $0 {
                        streamableItems.append(audionItem)
                    }
                }
                
                self.audioItems = streamableItems
                
                self.status = .LoadedButNotPlaying
            } else {
                self.status = .NotLoaded
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.configureFurCurrentStatus(true)
            }
        }
    }
    
    func playPauseTrackWithIndex(trackIndex: Int) {
        if currentPlayingTrackIndex == trackIndex {
            if status == .Playing {
                pauseCurrentTrack()
            } else {
                playTrackWithIndex(trackIndex, forceChangeTrack: false)
            }
        } else {
            playTrackWithIndex(trackIndex, forceChangeTrack: true)
        }
    }
    
    func playTrackWithIndex(trackIndex: Int, forceChangeTrack: Bool) {
        if !forceChangeTrack && musicPlayer.state == .Paused {
            guard musicPlayer.currentItem != nil else { return }
            
            if let currentItem = musicPlayer.currentItem {
                if let currentItemIndex = audioItems.indexOf(currentItem) {
                    if currentItemIndex  == currentPlayingTrackIndex {
                        status = .Playing
                        musicPlayer.resume()
                        configureFurCurrentStatus(false)
                        return
                    }
                }
            }
        }
        
        status = .Playing
        
        if currentPlayingTrackIndex < 0 {
            tableView.setContentOffset(CGPointZero, animated: true)
        }
        
        currentPlayingTrackIndex = trackIndex
        musicPlayer.playItems(audioItems, startAtIndex: trackIndex)
    }
    
    func pauseCurrentTrack() {
        musicPlayer.pause()
        status = .Paused
        currentTrackProgress = 0
        configureFurCurrentStatus(false)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: false)
        }
    }
    
    func audioPlayer(audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, toState to: AudioPlayerState) {
        
        if to == .Paused && status != .Paused {
            pauseCurrentTrack()
        }
        
        if to == .Playing && status != .Playing {
            playTrackWithIndex(currentPlayingTrackIndex, forceChangeTrack: true)
        }
    }
    
    func audioPlayer(audioPlayer: AudioPlayer, willStartPlayingItem item: AudioItem) {
        status = .Playing
        configureFurCurrentStatus(false)
        progressBar.progress = 0
        
        guard let itemIndex = audioItems.indexOf(item) else { return }
        
        currentPlayingTrackIndex = itemIndex
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if currentPlayingTrackIndex != selectedIndexPath.row {
                let newIndexPath = NSIndexPath(forRow: currentPlayingTrackIndex, inSection: 1)
                tableView.deselectRowAtIndexPath(selectedIndexPath, animated: false)
                tableView.selectRowAtIndexPath(newIndexPath, animated: false, scrollPosition: .None)
                configureFurCurrentStatus(false)
            }
        }
    }
    
    func audioPlayer(audioPlayer: AudioPlayer, didUpdateProgressionToTime time: NSTimeInterval, percentageRead: Float) {
        currentTrackProgress = percentageRead/100.0
        progressBar.progress = currentTrackProgress
    }
    
    func audioPlayer(audioPlayer: AudioPlayer, didFindDuration duration: NSTimeInterval, forItem item: AudioItem) {
        
    }
    
    func audioPlayer(audioPlayer: AudioPlayer, didLoadRange range: AudioPlayer.TimeRange, forItem item: AudioItem) {
        
    }
    
}
