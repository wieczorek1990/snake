extension SystemRandomNumberGenerator {
    mutating func nextUnsignedInteger(_ value: Int) -> Int {
        return Int(next(upperBound: UInt(value)))
    }
}

extension Array {
    var head: Element? {
        return first
    }
    var tail: [Element] {
        return Array(dropFirst())
    }
}
