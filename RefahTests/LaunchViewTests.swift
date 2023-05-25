//
//  LaunchViewTests.swift
//  RefahTests
//
//  Created by Jafar Khoshtabiat on 5/26/23.
//

import XCTest
@testable import Refah

final class LaunchViewTests: XCTestCase {
    private var sut: ViewWithProgressViewProtocol!
    
    override func setUp() {
        super.setUp()
        self.sut = LaunchView()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_setProgressOfProgressView_withFloatNumberBetween0And1_progressOfProgressViewShouldSetToSameValue() {
        // Arrange
        let progress: Float = 0.3
        
        // Act
        sut.setProgressOfProgressView(progress, animated: true)
        let result = sut.progressView.progress
        
        // Assert
        XCTAssertEqual(result, 0.3, accuracy: 0.0001)
    }
}
