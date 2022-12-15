//
//  ViewModel_Tests.swift
//  SpaceXMissions_Tests
//
//  Created by MaksBarbaruk on 15.12.2022.
//

import XCTest
@testable import SpaceX_Missions

class ViewModel_Tests: XCTestCase, @unchecked Sendable {
    
    var rockets: [Rocket] = []
    var launches: [Launch] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ViewModel_rocketsURLString_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let rocketsURLString = UUID().uuidString
            
            // When
            let vm = ViewModel(rocketsURLString: rocketsURLString)
            
            // Then
            XCTAssertEqual(vm.rocketsURLString, rocketsURLString)
        }
        
    }
    
    func test_ViewModel_launchesURLString_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let launchesURLString = UUID().uuidString
            
            // When
            let vm = ViewModel(launchesURLString: launchesURLString)
            
            // Then
            XCTAssertEqual(vm.launchesURLString, launchesURLString)
        }
        
    }
    
    func test_ViewModel_rockets_isEmpty() async {
        // Given
        let vm = ViewModel()
        
        // When
        Task {
            for await value in vm.$rockets.values {
                await MainActor.run(body: {
                    self.rockets = value
                })
            }
        }
        
        // Then
        XCTAssertTrue(rockets.isEmpty)
        
    }
    
    func test_ViewModel_launches_isEmpty() async {
        // Given
        let vm = ViewModel()
        
        // When
        Task {
            for await value in vm.$launches.values {
                await MainActor.run(body: {
                    self.launches = value
                })
            }
        }
        
        // Then
        XCTAssertTrue(launches.isEmpty)
        
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
