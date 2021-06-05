//
//  IntercorpChallengeTests.swift
//  IntercorpChallengeTests
//
//  Created by David Diego Gomez on 05/06/2021.
//

import XCTest
@testable import IntercorpChallenge

class TestServiceManager: XCTestCase {
    let service = MockService()
    
    func testLoadRegisters() {
        let expectation = self.expectation(description: "Wait for data...")
        
        let registers = service.loadMockData()
        XCTAssertEqual(registers?.first?.lastName, "Gomez")
        expectation.fulfill()
    
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockService {
    func loadMockData() -> [RegisterModel]? {
        guard let jsonData = readLocalFile(forName: "mock_firebase_response") else {
            return nil
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
            XCTFail("data format is not correct")
            return nil
        }
        
        guard let dictionary = json as? [String: Any] else {
            XCTFail()
            return nil
        }
        
        let array = removeKeys(source: dictionary)
        
        guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else {
            XCTFail()
            return nil
        }
        
        guard let registers = try? JSONDecoder().decode([RegisterModel].self, from: data) else {
            XCTFail()
            return nil
        }
        
        return registers
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            let bundle = Bundle(for: TestServiceManager.self)
            if let bundlePath = bundle.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch { }
        XCTFail()
        return nil
    }
}
