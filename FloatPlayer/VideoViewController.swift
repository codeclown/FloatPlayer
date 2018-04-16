//
//  VideoViewController.swift
//  FloatPlayer
//
//  Created by Martti on 12/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa
import WebKit

class VideoViewController: SubViewController {
    @IBOutlet var embedWebView: EmbedWebView!
    @IBOutlet var closeButton: NSButton!
    @IBOutlet var overlayView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enforce layer order
        embedWebView.wantsLayer = true
        closeButton.wantsLayer = true
        overlayView.wantsLayer = true
        
        activateActiveState()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        getWindowController().loadFormViewController()
        embedWebView.stopVideo()
    }
    
    func loadVideoUrl(videoUrl: String) {
        embedWebView.loadVideoUrl(videoUrl: videoUrl)
    }
    
    override func windowDidResignKey() {
        activateInactiveState()
    }
    
    override func windowDidBecomeKey() {
        activateActiveState()
    }
    
    func activateInactiveState() {
        closeButton.isHidden = true
        overlayView.isHidden = false
    }
    
    func activateActiveState() {
        closeButton.isHidden = false
        overlayView.isHidden = true
    }
}
