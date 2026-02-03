import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Sign {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Sign.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Sign.allCases.count == 3)
        #expect(Sign.allCases.contains(.positive))
        #expect(Sign.allCases.contains(.negative))
        #expect(Sign.allCases.contains(.zero))
    }

    @Test
    func `negated swaps values`() {
        #expect(Sign.negated(.positive) == .negative)
        #expect(Sign.negated(.negative) == .positive)
        #expect(Sign.negated(.zero) == .zero)
    }

    @Test
    func `negated property equals static function`() {
        for sign in Sign.allCases {
            #expect(sign.negated == Sign.negated(sign))
        }
    }

    @Test
    func `negation operator equals negated`() {
        for sign in Sign.allCases {
            #expect(-sign == sign.negated)
        }
    }

    @Test(arguments: [
        (Sign.positive, Sign.positive, Sign.positive),
        (Sign.positive, Sign.negative, Sign.negative),
        (Sign.negative, Sign.negative, Sign.positive),
        (Sign.zero, Sign.positive, Sign.zero),
        (Sign.positive, Sign.zero, Sign.zero),
    ])
    func `multiplying is correct`(lhs: Sign, rhs: Sign, expected: Sign) {
        #expect(Sign.multiplying(lhs, rhs) == expected)
    }

    @Test
    func `multiplying property equals static function`() {
        for sign in Sign.allCases {
            let other = Sign.positive
            #expect(sign.multiplying(other) == Sign.multiplying(sign, other))
        }
    }

    @Test(arguments: [
        (42, Sign.positive),
        (-42, Sign.negative),
        (0, Sign.zero),
    ])
    func `init from integer is correct`(value: Int, expected: Sign) {
        #expect(Sign(value) == expected)
    }

    @Test(arguments: [
        (3.14, Sign.positive),
        (-3.14, Sign.negative),
        (0.0, Sign.zero),
    ])
    func `init from floating point is correct`(value: Double, expected: Sign) {
        #expect(Sign(value) == expected)
    }

    @Test
    func `Value typealias works`() {
        let paired: Sign.Value<Double> = .init(.positive, 3.14)
        #expect(paired.first == .positive)
        #expect(paired.second == 3.14)
    }
}

// MARK: - EdgeCase

extension Sign.Test.EdgeCase {
    @Test
    func `negated is involution`() {
        for sign in Sign.allCases {
            #expect(Sign.negated(Sign.negated(sign)) == sign)
        }
    }

    @Test
    func `zero is fixed point of negation`() {
        #expect(Sign.negated(.zero) == .zero)
    }

    @Test
    func `zero is absorbing element for multiplication`() {
        for sign in Sign.allCases {
            #expect(Sign.multiplying(.zero, sign) == .zero)
            #expect(Sign.multiplying(sign, .zero) == .zero)
        }
    }
}
