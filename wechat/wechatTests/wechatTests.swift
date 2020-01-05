//
//  wechatTests.swift
//  wechatTests
//
//  Created by tongchao on 2019/12/21.
//  Copyright © 2019 tongchao. All rights reserved.
//

import XCTest
@testable import wechat

class wechatTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTweetModelParsing() {
        let expec = expectation(description: "TweetExpectation")
        let service = TweetService()
        service.fetchTweets(param: nil) { (tweets) in
            XCTAssert(tweets.first != nil)
            let firstTweet = tweets.first
            let firstTweetViewModel = TweetViewModel.init(model: firstTweet!)
            XCTAssert(firstTweet!.content == firstTweetViewModel.content.string)
            XCTAssert(firstTweet!.sender?.avatar == firstTweetViewModel.avatar)
            expec.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testImageCache() {
        let expec = expectation(description: "CacheExpectation")
        let cache = ImageCache.shareInstance
        let imageName = "Avatar_s"
        let avatar = UIImage.init(named: imageName)
        cache.set(key: imageName, value: avatar!, completion: nil)
        cache.get(key: imageName) { (image) in
            XCTAssert(avatar == image)
            expec.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
