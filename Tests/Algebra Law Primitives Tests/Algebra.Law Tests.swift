import Testing

@testable import Algebra_Law_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Law")
struct AlgebraLawTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Test Fixtures

extension AlgebraLawTests {
    /// Integer additive semigroup.
    static var intSemigroup: Algebra.Semigroup<Int> {
        .init(combining: { $0 &+ $1 })
    }

    /// Integer additive monoid.
    static var intMonoid: Algebra.Monoid<Int> {
        .init(identity: 0, combining: { $0 &+ $1 })
    }

    /// Integer additive group.
    static var intGroup: Algebra.Group<Int> {
        .init(identity: 0, combining: { $0 &+ $1 }, inverting: { 0 &- $0 })
    }

    /// Integer ring.
    static var intRing: Algebra.Ring<Int> {
        .init(
            additive: .init(group: intGroup),
            multiplicative: .init(identity: 1, combining: { $0 &* $1 })
        )
    }

    static var testElements: [Int] { [0, 1, -1, 2, 3] }

    /// A broken semigroup (not associative).
    static var brokenSemigroup: Algebra.Semigroup<Int> {
        .init(combining: { $0 - $1 }) // subtraction is not associative
    }

    /// A broken monoid (wrong identity).
    static var brokenMonoid: Algebra.Monoid<Int> {
        .init(identity: 1, combining: { $0 &+ $1 }) // 1 is not additive identity
    }

    /// A broken group (wrong inverse).
    static var brokenGroup: Algebra.Group<Int> {
        .init(identity: 0, combining: { $0 &+ $1 }, inverting: { $0 }) // identity is not inverse
    }
}

// MARK: - Unit: Good Witnesses Return Nil

extension AlgebraLawTests.Unit {
    @Test
    func `associativity passes for valid semigroup`() {
        let result = Algebra.Law.Associativity.check(
            of: AlgebraLawTests.intSemigroup,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `identity left passes for valid monoid`() {
        let result = Algebra.Law.Identity.left(
            of: AlgebraLawTests.intMonoid,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `identity right passes for valid monoid`() {
        let result = Algebra.Law.Identity.right(
            of: AlgebraLawTests.intMonoid,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `inverse left passes for valid group`() {
        let result = Algebra.Law.Inverse.left(
            of: AlgebraLawTests.intGroup,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `inverse right passes for valid group`() {
        let result = Algebra.Law.Inverse.right(
            of: AlgebraLawTests.intGroup,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `commutativity passes for commutative operation`() {
        let result = Algebra.Law.Commutativity.check(
            of: { (a: Int, b: Int) in a &+ b },
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `distributivity left passes for valid ring`() {
        let result = Algebra.Law.Distributivity.left(
            of: AlgebraLawTests.intRing,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `distributivity right passes for valid ring`() {
        let result = Algebra.Law.Distributivity.right(
            of: AlgebraLawTests.intRing,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }

    @Test
    func `annihilation passes for valid ring`() {
        let result = Algebra.Law.Annihilation.zero(
            of: AlgebraLawTests.intRing,
            over: AlgebraLawTests.testElements
        )
        #expect(result == nil)
    }
}

// MARK: - EdgeCase: Broken Witnesses Return Violation

extension AlgebraLawTests.EdgeCase {
    @Test
    func `associativity fails for broken semigroup`() {
        let result = Algebra.Law.Associativity.check(
            of: AlgebraLawTests.brokenSemigroup,
            over: [1, 2, 3]
        )
        #expect(result != nil)
    }

    @Test
    func `identity fails for broken monoid`() {
        let result = Algebra.Law.Identity.left(
            of: AlgebraLawTests.brokenMonoid,
            over: [0, 2]
        )
        #expect(result != nil)
    }

    @Test
    func `inverse fails for broken group`() {
        let result = Algebra.Law.Inverse.left(
            of: AlgebraLawTests.brokenGroup,
            over: [1, 2]
        )
        #expect(result != nil)
    }

    @Test
    func `commutativity fails for non-commutative operation`() {
        let result = Algebra.Law.Commutativity.check(
            of: { (a: Int, b: Int) in a - b },
            over: [1, 2]
        )
        #expect(result != nil)
    }
}
