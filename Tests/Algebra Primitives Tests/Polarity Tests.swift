import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Polarity {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Polarity.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Polarity.allCases.count == 3)
        #expect(Polarity.allCases.contains(.positive))
        #expect(Polarity.allCases.contains(.negative))
        #expect(Polarity.allCases.contains(.neutral))
    }

    @Test
    func `opposite swaps values`() {
        #expect(Polarity.opposite(of: .positive) == .negative)
        #expect(Polarity.opposite(of: .negative) == .positive)
        #expect(Polarity.opposite(of: .neutral) == .neutral)
    }

    @Test
    func `opposite property equals static function`() {
        for polarity in Polarity.allCases {
            #expect(polarity.opposite == Polarity.opposite(of: polarity))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for polarity in Polarity.allCases {
            #expect(!polarity == polarity.opposite)
        }
    }

    @Test(arguments: [
        (Polarity.positive, true),
        (Polarity.negative, true),
        (Polarity.neutral, false),
    ])
    func `isCharged is correct`(polarity: Polarity, expected: Bool) {
        #expect(polarity.isCharged == expected)
    }

    @Test(arguments: [
        (Polarity.positive, true),
        (Polarity.negative, false),
        (Polarity.neutral, false),
    ])
    func `isPositive is correct`(polarity: Polarity, expected: Bool) {
        #expect(polarity.isPositive == expected)
    }

    @Test(arguments: [
        (Polarity.positive, false),
        (Polarity.negative, true),
        (Polarity.neutral, false),
    ])
    func `isNegative is correct`(polarity: Polarity, expected: Bool) {
        #expect(polarity.isNegative == expected)
    }

    @Test(arguments: [
        (Polarity.positive, false),
        (Polarity.negative, false),
        (Polarity.neutral, true),
    ])
    func `isNeutral is correct`(polarity: Polarity, expected: Bool) {
        #expect(polarity.isNeutral == expected)
    }

    @Test
    func `Value typealias works`() {
        let paired: Polarity.Value<Int> = .init(.positive, 1)
        #expect(paired.first == .positive)
        #expect(paired.second == 1)
    }
}

// MARK: - EdgeCase

extension Polarity.Test.EdgeCase {
    @Test
    func `opposite is involution for charged values`() {
        for polarity in Polarity.allCases where polarity != .neutral {
            #expect(Polarity.opposite(of: Polarity.opposite(of: polarity)) == polarity)
        }
    }

    @Test
    func `neutral is fixed point of opposite`() {
        #expect(Polarity.opposite(of: .neutral) == .neutral)
    }
}
