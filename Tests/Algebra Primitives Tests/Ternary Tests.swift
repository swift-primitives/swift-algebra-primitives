import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Ternary {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Ternary.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Ternary.allCases.count == 3)
        #expect(Ternary.allCases.contains(.negative))
        #expect(Ternary.allCases.contains(.zero))
        #expect(Ternary.allCases.contains(.positive))
    }

    @Test
    func `negated swaps values`() {
        #expect(Ternary.negated(.negative) == .positive)
        #expect(Ternary.negated(.positive) == .negative)
        #expect(Ternary.negated(.zero) == .zero)
    }

    @Test
    func `negated property equals static function`() {
        for ternary in Ternary.allCases {
            #expect(ternary.negated == Ternary.negated(ternary))
        }
    }

    @Test
    func `negation operator equals negated`() {
        for ternary in Ternary.allCases {
            #expect(-ternary == ternary.negated)
        }
    }

    @Test(arguments: [
        (Ternary.positive, Ternary.positive, Ternary.positive),
        (Ternary.positive, Ternary.negative, Ternary.negative),
        (Ternary.negative, Ternary.negative, Ternary.positive),
        (Ternary.zero, Ternary.positive, Ternary.zero),
    ])
    func `multiplying is correct`(lhs: Ternary, rhs: Ternary, expected: Ternary) {
        #expect(Ternary.multiplying(lhs, rhs) == expected)
    }

    @Test
    func `multiplying property equals static function`() {
        for ternary in Ternary.allCases {
            let other = Ternary.positive
            #expect(ternary.multiplying(other) == Ternary.multiplying(ternary, other))
        }
    }

    @Test(arguments: [
        (Ternary.negative, -1),
        (Ternary.zero, 0),
        (Ternary.positive, 1),
    ])
    func `intValue is correct`(ternary: Ternary, expected: Int) {
        #expect(ternary.intValue == expected)
    }

    @Test(arguments: [
        (Sign.negative, Ternary.negative),
        (Sign.zero, Ternary.zero),
        (Sign.positive, Ternary.positive),
    ])
    func `init from Sign is correct`(sign: Sign, expected: Ternary) {
        #expect(Ternary(sign) == expected)
    }

    @Test
    func `Value typealias works`() {
        let paired: Ternary.Value<Double> = .init(.positive, 1.0)
        #expect(paired.first == .positive)
        #expect(paired.second == 1.0)
    }
}

// MARK: - EdgeCase

extension Ternary.Test.EdgeCase {
    @Test
    func `negated is involution`() {
        for ternary in Ternary.allCases {
            #expect(Ternary.negated(Ternary.negated(ternary)) == ternary)
        }
    }

    @Test
    func `zero is fixed point of negation`() {
        #expect(Ternary.negated(.zero) == .zero)
    }
}
