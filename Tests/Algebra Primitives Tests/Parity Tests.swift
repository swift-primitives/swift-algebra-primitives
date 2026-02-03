import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Parity {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Parity.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Parity.allCases.count == 2)
        #expect(Parity.allCases.contains(.even))
        #expect(Parity.allCases.contains(.odd))
    }

    @Test
    func `opposite swaps cases`() {
        #expect(Parity.opposite(of: .even) == .odd)
        #expect(Parity.opposite(of: .odd) == .even)
    }

    @Test
    func `opposite property equals static function`() {
        for parity in Parity.allCases {
            #expect(parity.opposite == Parity.opposite(of: parity))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for parity in Parity.allCases {
            #expect(!parity == parity.opposite)
        }
    }

    @Test(arguments: [
        (Parity.even, Parity.even, Parity.even),
        (Parity.odd, Parity.odd, Parity.even),
        (Parity.even, Parity.odd, Parity.odd),
        (Parity.odd, Parity.even, Parity.odd),
    ])
    func `adding is correct`(lhs: Parity, rhs: Parity, expected: Parity) {
        #expect(Parity.adding(lhs, rhs) == expected)
    }

    @Test(arguments: [
        (Parity.even, Parity.even, Parity.even),
        (Parity.odd, Parity.odd, Parity.odd),
        (Parity.even, Parity.odd, Parity.even),
        (Parity.odd, Parity.even, Parity.even),
    ])
    func `multiplying is correct`(lhs: Parity, rhs: Parity, expected: Parity) {
        #expect(Parity.multiplying(lhs, rhs) == expected)
    }

    @Test(arguments: [
        (0, Parity.even),
        (1, Parity.odd),
        (2, Parity.even),
        (-1, Parity.odd),
        (-2, Parity.even),
        (42, Parity.even),
        (43, Parity.odd),
    ])
    func `init from integer is correct`(value: Int, expected: Parity) {
        #expect(Parity(value) == expected)
    }

    @Test
    func `Value typealias works`() {
        let paired: Parity.Value<Int> = .init(.even, 42)
        #expect(paired.first == .even)
        #expect(paired.second == 42)
    }
}

// MARK: - EdgeCase

extension Parity.Test.EdgeCase {
    @Test
    func `opposite is involution`() {
        for parity in Parity.allCases {
            #expect(Parity.opposite(of: Parity.opposite(of: parity)) == parity)
        }
    }
}
