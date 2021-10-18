// moviesUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MoviesUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testPress() throws {
        let latestScrollView = app.scrollViews.containing(.button, identifier: "Popular").element
        app.buttons["Latest"].staticTexts["Latest"].tap()
        latestScrollView.swipeLeft()
        latestScrollView.swipeRight()
        app.swipeUp()
        app.collectionViews.children(matching: .cell).element(boundBy: 5).children(matching: .other).element.tap()
        sleep(2)
        app.navigationBars["movies.AboutMovieView"].buttons["Library"].tap()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.buttons["Popular"].staticTexts["Popular"].tap()
        sleep(1)
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.buttons["TopRated"].staticTexts["TopRated"].tap()
        sleep(1)
        app.collectionViews.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        sleep(2)
        app.navigationBars["movies.AboutMovieView"].buttons["Library"].tap()
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()

        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.buttons["Upcoming"].staticTexts["Upcoming"].tap()

        sleep(1)
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.buttons["  NowPlaying  "].staticTexts["  NowPlaying  "].tap()
        sleep(1)
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
    }
}
