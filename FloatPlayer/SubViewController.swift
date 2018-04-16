//
//  SubViewController.swift
//  FloatPlayer
//
//  Created by Martti on 12/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

class SubViewController: NSViewController {
    func getWindowController() -> FloatPlayerWindowController {
        return view.window?.windowController as! FloatPlayerWindowController
    }
    
    func windowDidResignKey() {}
    
    func windowDidBecomeKey() {}
}
