//
//  FloatPlayerWindowController.swift
//  FloatPlayer
//
//  Created by Martti on 11/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

class FloatPlayerWindowController: NSWindowController, NSWindowDelegate {
    var originalStyleMaskRawValue: UInt?
    
    var currentWindowStyle: String = ""
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        originalStyleMaskRawValue = (window?.styleMask.rawValue)!
        
        loadFormViewController()
        
        // Catch window-events
        window?.delegate = self
        
        window?.level = .floating
        window?.collectionBehavior = [.canJoinAllSpaces, .transient]

        window?.isMovableByWindowBackground = true
        window?.makeKeyAndOrderFront(nil)
    }
    
    var viewControllers: Dictionary<String, SubViewController> = Dictionary()
    
    func getViewController(identifier: String) -> SubViewController {
        if let existingViewController = viewControllers[identifier] {
            return existingViewController
        } else {
            let sceneIdentifier = NSStoryboard.SceneIdentifier(identifier)
            let viewController = storyboard?.instantiateController(withIdentifier: sceneIdentifier) as! SubViewController
            viewControllers[identifier] = viewController
            return viewController
        }
    }
    
    func retainWindowSize(upcomingView: NSView) {
        if let contentView = window?.contentView {
            upcomingView.frame = contentView.bounds
        }
    }
    
    func loadViewController(identifier: String) -> SubViewController {
        let viewController = getViewController(identifier: identifier)
        retainWindowSize(upcomingView: viewController.view)
        window?.contentViewController = viewController
        return viewController
    }
    
    func setWindowStyle(mode: String) {
        var newStyleMask: NSWindow.StyleMask = NSWindow.StyleMask(rawValue: originalStyleMaskRawValue!)
        var titlebarAppearsTransparent: Bool = false
        
        switch mode {
            case "form":
                titlebarAppearsTransparent = true
                break
            
            case "videoInactive":
                newStyleMask.remove(.titled)
                newStyleMask.insert(.borderless)
                titlebarAppearsTransparent = true
                break
            
            case "videoActive":
                // Nothing out of the ordinary
                break
            
            default:
                ()
        }
        
        window?.styleMask = newStyleMask
        window?.titlebarAppearsTransparent = titlebarAppearsTransparent

        currentWindowStyle = mode
    }
    
    func loadFormViewController() {
        _ = loadViewController(identifier: "FormViewController")
        setWindowStyle(mode: "form")
    }
    
    func loadVideoViewController(videoUrl: String) {
        let viewController = loadViewController(identifier: "VideoViewController") as! VideoViewController
        viewController.loadVideoUrl(videoUrl: videoUrl)
        setWindowStyle(mode: "videoActive")
    }
    
    func windowDidResignKey(_ notification: Notification) {
        let viewController = window?.contentViewController as! SubViewController
        viewController.windowDidResignKey()
        
        if currentWindowStyle == "videoActive" {
            setWindowStyle(mode: "videoInactive")
        }
    }

    func windowDidBecomeKey(_ notification: Notification) {
        let viewController = window?.contentViewController as! SubViewController
        viewController.windowDidBecomeKey()

        if currentWindowStyle == "videoInactive" {
            setWindowStyle(mode: "videoActive")
        }
    }
}
