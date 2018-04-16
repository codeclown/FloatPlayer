//
//  EmbedWebView.swift
//  FloatPlayer
//
//  Created by Martti on 14/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import Cocoa
import WebKit

class EmbedWebView: WKWebView {
    func getTemplate() -> String {
        let htmlFile = Bundle.main.path(forResource: "embed", ofType: "html")
        return try! String(contentsOfFile: htmlFile!, encoding: .utf8)
    }
    
    func renderWithData(template: String, data: Dictionary<String, String>) -> String {
        let json = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let regex = try! NSRegularExpression(pattern: "__DATA__")
        let range = NSMakeRange(0, template.count)
        return regex.stringByReplacingMatches(
            in: template,
            options: [],
            range: range,
            withTemplate: String(data: json, encoding: .utf8)!
        )
    }
    
    func loadVideoUrl(videoUrl: String) {
        let videoId = YouTubeUrlParser.parseVideoIdFromUrl(url: videoUrl)!
        let template = getTemplate()
        let html = renderWithData(template: template, data: ["videoId": videoId])
        self.loadHTMLString(html, baseURL: nil)
    }
    
    func stopVideo() {
        self.evaluateJavaScript("window.controlFunctions.stopVideo()", completionHandler: nil)
    }
}
