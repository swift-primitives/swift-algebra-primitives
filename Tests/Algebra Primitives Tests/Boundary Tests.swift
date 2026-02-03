import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Boundary {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Boundary.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Boundary.allCases.count == 2)
        #expect(Boundary.allCases.contains(.open))
        #expect(Boundary.allCases.contains(.closed))
    }

    @Test
    func `opposite swaps values`() {
        #expect(Boundary.opposite(of: .open) == .closed)
        #expect(Boundary.opposite(of: .closed) == .open)
    }

    @Test
    func `opposite property equals static function`() {
        for boundary in Boundary.allCases {
            #expect(boundary.opposite == Boundary.opposite(of: boundary))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for boundary in Boundary.allCases {
            #expect(!boundary == boundary.opposite)
        }
    }

    @Test
    func `toggled is alias for opposite`() {
        for boundary in Boundary.allCases {
            #expect(boundary.toggled == boundary.opposite)
        }
    }

    @Test(arguments: [
        (Boundary.closed, true),
        (Boundary.open, false),
    ])
    func `isInclusive is correct`(boundary: Boundary, expected: Bool) {
        #expect(boundary.isInclusive == expected)
    }

    @Test(arguments: [
        (Boundary.closed, false),
        (Boundary.open, true),
    ])
    func `isExclusive is correct`(boundary: Boundary, expected: Bool) {
        #expect(boundary.isExclusive == expected)
    }

    @Test
    func `Value typealias works`() {
        let paired: Boundary.Value<Double> = .init(.closed, 1.0)
        #expect(paired.first == .closed)
        #expect(paired.second == 1.0)
    }
}

// MARK: - EdgeCase

extension Boundary.Test.EdgeCase {
    @Test
    func `opposite is involution`() {
        for boundary in Boundary.allCases {
            #expect(Boundary.opposite(of: Boundary.opposite(of: boundary)) == boundary)
        }
    }
}
