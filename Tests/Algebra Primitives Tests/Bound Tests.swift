import Testing

@testable import Algebra_Primitives

// [TEST-003] Non-generic type uses type extension pattern.

extension Bound {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct EdgeCase {}
    }
}

// MARK: - Unit

extension Bound.Test.Unit {
    @Test
    func `cases exist`() {
        #expect(Bound.allCases.count == 2)
        #expect(Bound.allCases.contains(.lower))
        #expect(Bound.allCases.contains(.upper))
    }

    @Test
    func `opposite swaps values`() {
        #expect(Bound.opposite(of: .lower) == .upper)
        #expect(Bound.opposite(of: .upper) == .lower)
    }

    @Test
    func `opposite property equals static function`() {
        for bound in Bound.allCases {
            #expect(bound.opposite == Bound.opposite(of: bound))
        }
    }

    @Test
    func `negation operator equals opposite`() {
        for bound in Bound.allCases {
            #expect(!bound == bound.opposite)
        }
    }

    @Test
    func `aliases are correct`() {
        #expect(Bound.min == .lower)
        #expect(Bound.max == .upper)
        #expect(Bound.left == .lower)
        #expect(Bound.right == .upper)
    }

    @Test
    func `Value typealias works`() {
        let paired: Bound.Value<Int> = .init(.lower, 0)
        #expect(paired.first == .lower)
        #expect(paired.second == 0)
    }
}

// MARK: - EdgeCase

extension Bound.Test.EdgeCase {
    @Test
    func `opposite is involution`() {
        for bound in Bound.allCases {
            #expect(Bound.opposite(of: Bound.opposite(of: bound)) == bound)
        }
    }
}
