//
//  YouTubeUrlParser_Test.swift
//  Floating Player 5Tests
//
//  Created by Martti on 09/04/2018.
//  Copyright © 2018 Martti Laine. All rights reserved.
//

import XCTest
@testable import FloatPlayer

class YouTubeUrlParser_Test: XCTestCase {
    func testParseVideoIdFromUrl() {
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: ""), nil)
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "foo"), nil)
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://example.com"), nil)
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://youtube.com"), nil)
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://youtube.com/foobar"), nil)
        
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://www.youtube.com/watch?v=x0RV0kgdqJU"), "x0RV0kgdqJU")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://www.youtube.com/watch?v=x0RV0kgdqJU&foo"), "x0RV0kgdqJU")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "https://youtu.be/x0RV0kgdqJU"), "x0RV0kgdqJU")
        
        
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/watch?v=0zM3nApSvMg&feature=feedrec_grec_index"), "0zM3nApSvMg")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/user/IngridMichaelsonVEVO#p/a/u/1/QdK8U-VIH_o"), "QdK8U-VIH_o")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/v/0zM3nApSvMg?fs=1&amp;hl=en_US&amp;rel=0"), "0zM3nApSvMg")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/watch?v=0zM3nApSvMg#t=0m10s"), "0zM3nApSvMg")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/embed/0zM3nApSvMg?rel=0"), "0zM3nApSvMg")
        XCTAssertEqual(YouTubeUrlParser.parseVideoIdFromUrl(url: "http://www.youtube.com/watch?v=0zM3nApSvMg"), "0zM3nApSvMg")
    }
    
    func testIsValidUrl() {
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: ""), false)
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: "foo"), false)
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: "https://example.com"), false)
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: "https://youtube.com"), false)
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: "https://youtube.com/foobar"), false)
        
        XCTAssertEqual(YouTubeUrlParser.isValidUrl(url: "https://www.youtube.com/watch?v=x0RV0kgdqJU"), true)
    }
}
