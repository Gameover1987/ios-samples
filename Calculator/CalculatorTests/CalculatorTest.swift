
import XCTest
import Calculator

final class CalculatorTest: XCTestCase {

    private var calculator: Calculator!
    
    override func setUpWithError() throws {
        self.calculator = Calculator()
    }

    override func tearDownWithError() throws {
        self.calculator = nil
    }

    func testThatAdd() {
        // Given
        let expected = 4
        let a = 2
        let b = 2
        
        // When
        let actual = self.calculator.add(a, b)
        
        // Then
        XCTAssert(actual == expected, "Операция сложения \(a) и \(b)")
    }
    
    func testThatsubtract() {
        // Given
        let expected = 0
        let a = 2
        let b = 2
        
        // When
        let actual = self.calculator.subtract(a, b)
        
        // Then
        XCTAssert(actual == expected, "Операция вычитания \(a) и \(b)")
    }

}
