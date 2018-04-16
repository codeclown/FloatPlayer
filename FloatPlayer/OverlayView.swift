//
//  OverlayView.swift
//  FloatPlayer
//
//  Created by Martti on 15/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

class OverlayView: NSView {
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    override func shouldDelayWindowOrdering(for event: NSEvent) -> Bool {
        return true
    }
    
    override func mouseDown(with event: NSEvent) {
        var shouldCallSuper: Bool = false
        
        // https://developer.apple.com/library/content/samplecode/PhotoEditor/Listings/Photo_Editor_WindowDraggableButton_swift.html
        self.window?.trackEvents(matching: [.leftMouseDragged, .leftMouseUp], timeout: .infinity, mode: .defaultRunLoopMode) { event, stop in
            switch event!.type {
            case .leftMouseUp:
                shouldCallSuper = true
                NSApp.postEvent(event!, atStart: false)
                stop.pointee = true
                
            case .leftMouseDragged:
                self.window?.performDrag(with: event!)
                stop.pointee = true
                NSApp.preventWindowOrdering()
                
            default:
                break
            }
        }
        
        if shouldCallSuper {
            super.mouseDown(with: event)
        }
    }
}
