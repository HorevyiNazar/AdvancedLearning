//
//  UnitTestingBootCampViewModel_Tests.swift
//  AdvancedLearning_Tests
//
//  Created by Назар Горевой on 23/11/2023.
//

import XCTest
@testable import AdvancedLearning

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming Structure: test_[struct or class]_[variable or function]_[expected resultt]

// Testing Structure: Given, When, Then

final class UnitTestingBootCampViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTestingViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    func test_UnitTestingViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            let userIsPremium: Bool = Bool.random()
            
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    func test_UnitTestingViewModel_dataArray_shouldAddItems() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        vm.addItem(item: "hello")
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}


