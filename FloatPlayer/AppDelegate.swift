//
//  AppDelegate.swift
//  FloatPlayer
//
//  Created by Martti on 11/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

