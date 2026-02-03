import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Monotonicity {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Monotonicity.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Monotonicity.allCases.count == 3)
        #expect(Monotonicity.allCases.contains(.increasing))
        #expect(Monotonicity.allCases.contains(.decreasing))
        #expect(Monotonicity.allCases.contains(.constant))
    }

    @Test
    func `reversed swaps values`() {
        #expect(Monotonicity.reversed(.increasing) == .decreasing)
        #expect(Monotonicity.reversed(.decreasing) == .increasing)
        #expect(Monotonicity.reversed(.constant) == .constant)
    }

    @Test
    func `reversed property equals static function`() {
        for m in Monotonicity.allCases {
            #expect(m.reversed == Monotonicity.reversed(m))
        }
    }

    @Test
    func `negation operator equals reversed`() {
        for m in Monotonicity.allCases {
            #expect(!m == m.reversed)
        }
    }

    @Test(arguments: [
        (Monotonicity.increasing, true),
        (Monotonicity.decreasing, false),
        (Monotonicity.constant, false),
    ])
    func `isIncreasing is correct`(monotonicity: Monotonicity, expected: Bool) {
        #expect(monotonicity.isIncreasing == expected)
    }

    @Test(arguments: [
        (Monotonicity.increasing, false),
        (Monotonicity.decreasing, true),
        (Monotonicity.constant, false),
    ])
    func `isDecreasing is correct`(monotonicity: Monotonicity, expected: Bool) {
        #expect(monotonicity.isDecreasing == expected)
    }

    @Test(arguments: [
        (Monotonicity.increasing, false),
        (Monotonicity.decreasing, false),
        (Monotonicity.constant, true),
    ])
    func `isConstant is correct`(monotonicity: Monotonicity, expected: Bool) {
        #expect(monotonicity.isConstant == expected)
    }

    @Test(arguments: [
        (Monotonicity.increasing, true),
        (Monotonicity.constant, true),
        (Monotonicity.decreasing, false),
    ])
    func `isNonDecreasing is correct`(monotonicity: Monotonicity, expected: Bool) {
        #expect(monotonicity.isNonDecreasing == expected)
    }

    @Test(arguments: [
        (Monotonicity.decreasing, true),
        (Monotonicity.constant, true),
        (Monotonicity.increasing, false),
    ])
    func `isNonIncreasing is correct`(monotonicity: Monotonicity, expected: Bool) {
        #expect(monotonicity.isNonIncreasing == expected)
    }

    @Test(arguments: [
        (Monotonicity.increasing, Monotonicity.increasing, Monotonicity.increasing),
        (Monotonicity.increasing, Monotonicity.decreasing, Monotonicity.decreasing),
        (Monotonicity.decreasing, Monotonicity.decreasing, Monotonicity.increasing),
        (Monotonicity.constant, Monotonicity.increasing, Monotonicity.constant),
    ])
    func `composing is correct`(lhs: Monotonicity, rhs: Monotonicity, expected: Monotonicity) {
        #expect(Monotonicity.composing(lhs, rhs) == expected)
    }

    @Test
    func `composing property equals static function`() {
        for m in Monotonicity.allCases {
            let other = Monotonicity.increasing
            #expect(m.composing(other) == Monotonicity.composing(m, other))
        }
    }

    @Test
    func `Value typealias works`() {
        let paired: Monotonicity.Value<String> = .init(.increasing, "growth")
        #expect(paired.first == .increasing)
        #expect(paired.second == "growth")
    }
}

// MARK: - EdgeCase

extension Monotonicity.Test.EdgeCase {
    @Test
    func `reversed is involution for increasing and decreasing`() {
        for m in Monotonicity.allCases where m != .constant {
            #expect(Monotonicity.reversed(Monotonicity.reversed(m)) == m)
        }
    }

    @Test
    func `constant is fixed point of reversed`() {
        #expect(Monotonicity.reversed(.constant) == .constant)
    }
}
