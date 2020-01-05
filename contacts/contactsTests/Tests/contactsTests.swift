//
//  contactsTests.swift
//  contactsTests
//
//  Created by tongchao on 2019/12/23.
//  Copyright © 2019 tongchao. All rights reserved.
//

import XCTest
@testable import contacts

class contactsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: ===== Network request json parsing =====
    func testContactModelParsing() {
        let expec = expectation(description: "ContactsExpectation")
        let service = ContactsService()
        service.fetchContacts(param: nil) { (fetchResult) in
            switch fetchResult {
            case .success(let contacts):
                XCTAssert(contacts.count == 28)
                let firstContact = contacts.first
                XCTAssert(firstContact?.firstName == "Allan")
                XCTAssert(firstContact?.lastName == "Munger")
                XCTAssert(firstContact?.avatarFileName == "Allan Munger.png")
                XCTAssert(firstContact?.title == "Writer")
                XCTAssert(firstContact?.intro == "Ut malesuada sollicitudin tincidunt. Maecenas volutpat suscipit efficitur. Curabitur ut tortor sit amet lacus pellentesque convallis in laoreet lectus. Curabitur lorem velit, bibendum et vulputate vulputate, commodo in tortor. Curabitur a dapibus mauris. Vestibulum hendrerit euismod felis at hendrerit. Pellentesque imperdiet volutpat molestie. Nam vehicula dui eu consequat finibus. Phasellus sed placerat lorem. Nulla pretium a magna sit amet iaculis. Aenean eget eleifend elit. Ut eleifend aliquet interdum. Cras pulvinar elit a dapibus iaculis. Nullam fermentum porttitor ultrices.")
            case .failure:
                XCTAssertTrue(false)
            }
            expec.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    // MARK: ===== Model -> viewModel converting =====
    func testViewModelConverting() -> Void {
        let expec = expectation(description: "ContactsExpectation")
        let service = ContactsService()
        service.fetchContacts(param: nil) { (fetchResult) in
            switch fetchResult {
            case .success(let contacts):
                let contact = contacts.first
                XCTAssertNotNil(contact)
                
                let avatarViewModel = AvatarViewModel.init(contact: contact!)
                XCTAssert(contact?.avatarFileName == avatarViewModel.imageName)
                
                let introViewModel = IntroViewModel.init(contact: contact!)
                XCTAssert(contact?.firstName == introViewModel.firstName)
                XCTAssert(contact?.lastName == introViewModel.lastName)
                
            case .failure:
                XCTAssertTrue(false)
            }
            expec.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    // MARK: ===== Syncronizer Updating =====
    func testSyncronizerUpdateObservers() -> Void {
        let synchronizer = ProgressSynchronizer()
        let observer = MockProgressObserver()
        
        synchronizer.addObserver(observer: observer)
        synchronizer.didUpdate(subject: self, progress: 0.25)
        
        XCTAssert(observer.updated == true)
        XCTAssert(observer.progress == 0.25)
    }
    
    func testSyncronizerFilterSubjects() -> Void {
        let synchronizer = ProgressSynchronizer()
        let observer = MockProgressObserver()
        
        synchronizer.addObserver(observer: observer)
        synchronizer.didUpdate(subject: observer, progress: 0.25)
        
        XCTAssert(observer.updated == false)
    }
    
    // MARK: ===== WeakArray =====
    func testWeakArray() -> Void {
        let weakArray = WeakArray<MockProgressObserver>()
        let observer = MockProgressObserver()
        let oldRetainCount = CFGetRetainCount(observer)
        weakArray.add(observer)
        let newRetainCount = CFGetRetainCount(observer)
        XCTAssert(oldRetainCount == newRetainCount)
    }
    
    func testWeakArrayAddRemove() -> Void {
        let weakArray = WeakArray<MockProgressObserver>()
        let observer = MockProgressObserver()
        let oldCount = weakArray.count
        weakArray.add(observer)
        let newCount = weakArray.count
        XCTAssert(oldCount + 1 == newCount)
    }

    // MARK: ===== WeakArray Performance =====
    func testPerformanceWeakArray() {
        self.measure {
            let weakArray = WeakArray<MockProgressObserver>()
            let observer = MockProgressObserver()
            for _ in 1 ..< 10000 {
                weakArray.add(observer)
            }
        }
    }
}
