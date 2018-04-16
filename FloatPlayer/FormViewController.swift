//
//  FormViewController.swift
//  FloatPlayer
//
//  Created by Martti on 11/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

class FormViewController: SubViewController, NSTextFieldDelegate {
    @IBOutlet var videoUrlTextField: NSTextField!

    @IBOutlet var loadVideoButton: NSButton!

    override func viewDidAppear() {
        super.viewDidAppear()
        
        // Catch key-events on input to toggle enabled-state
        videoUrlTextField.delegate = self
        
        loadVideoButton.isEnabled = false
        
        if let url = validUrlFromClipboard() {
            videoUrlTextField.stringValue = url
            loadVideoButton.isEnabled = true
        }
    }
    
    func validUrlFromClipboard() -> String? {
        let fromClipboard = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string)
        
        if fromClipboard != nil && YouTubeUrlParser.isValidUrl(url: fromClipboard!) {
            return fromClipboard!
        }

        return nil
    }
    
    public override func controlTextDidChange(_ obj: Notification) {
        let isValid = YouTubeUrlParser.isValidUrl(url: videoUrlTextField.stringValue)
        loadVideoButton.isEnabled = isValid
    }
    
    @IBAction func videoUrlTextFieldChangeAction(_ sender: Any) {
        submitForm()
    }
    
    @IBAction func loadVideoButtonClicked(_ sender: Any) {
        submitForm()
    }
    
    func submitForm() {
        let videoUrl = videoUrlTextField.stringValue
        
        if !YouTubeUrlParser.isValidUrl(url: videoUrl) {
            return
        }
        
        getWindowController().loadVideoViewController(videoUrl: videoUrl)
    }
}
