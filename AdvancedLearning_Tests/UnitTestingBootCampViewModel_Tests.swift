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

    var viewModel: UnitTestingViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
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
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    func test_UnitTestingViewModel_dataArray_shouldNoAddBlankString() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    func test_UnitTestingViewModel_dataArray_shouldNoAddBlankString2() {
        // Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        // When
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    func test_UnitTestingViewModel_selectedItem_shouldStartNil() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        
        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        // Select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        // Select invalid item
        vm.selectItem(item: UUID().uuidString)
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    func test_UnitTestingViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectItem(item: randomItem)
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    func test_UnitTestingViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item Not Found Error") { error in
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound)
        }
    }
    func test_UnitTestingViewModel_saveItem_shouldThrowError_noData() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
    }
    func test_UnitTestingViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
}


