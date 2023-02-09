
import Foundation

open class Calculator {
    
    public init() {
        
    }
    
    public func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    public func subtract(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    public func devide(_ a: Int, _ b: Int) -> Double {
        return Double(a) / Double(b)
    }
    
    public func multiply(_ a: Int, _ b: Int) -> Double {
        return Double(a) * Double(b)
    }
}
