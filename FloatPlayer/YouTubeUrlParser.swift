//
//  YouTubeUrlParser.swift
//  FloatPlayer
//
//  Created by Martti on 08/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa

class YouTubeUrlParser: NSObject {
    static func parseVideoIdFromUrl(url: String) -> String? {
        // https://stackoverflow.com/a/8260383/239527
        let pattern = ".*(?:youtu.be\\/|v\\/|u\\/\\w\\/|embed\\/|watch\\?v=)([^#\\&\\?]*).*"
        let regex = try! NSRegularExpression(pattern: pattern)
        let match = regex.firstMatch(in: url, range: NSRange(url.startIndex..., in: url))
        
        if match == nil {
            return nil
        }
        
        return String(url[Range((match?.range(at: 1))!, in: url)!])
    }
    
    static func isValidUrl(url: String) -> Bool {
        let videoId = parseVideoIdFromUrl(url: url)
        return videoId != nil
    }
}
