import Testing

@testable import Algebra_Ring_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Ring")
struct AlgebraRingTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraRingTests.Unit {
    static var intRing: Algebra.Ring<Int> {
        .init(
            additive: .init(group: .init(
                identity: 0,
                combining: { $0 &+ $1 },
                inverting: { 0 &- $0 }
            )),
            multiplicative: .init(identity: 1, combining: { $0 &* $1 })
        )
    }

    @Test
    func `init stores additive and multiplicative structures`() {
        let ring = Self.intRing
        #expect(ring.additive.identity == 0)
        #expect(ring.multiplicative.identity == 1)
    }

    @Test
    func `zero returns additive identity`() {
        let ring = Self.intRing
        #expect(ring.zero == 0)
    }

    @Test
    func `one returns multiplicative identity`() {
        let ring = Self.intRing
        #expect(ring.one == 1)
    }

    @Test
    func `adding delegates to additive group`() {
        let ring = Self.intRing
        #expect(ring.adding(3, 4) == 7)
    }

    @Test
    func `negating delegates to additive inverse`() {
        let ring = Self.intRing
        #expect(ring.negating(5) == -5)
    }

    @Test
    func `multiplying delegates to multiplicative monoid`() {
        let ring = Self.intRing
        #expect(ring.multiplying(3, 4) == 12)
    }

    @Test
    func `additiveGroup projection returns additive abelian group`() {
        let ring = Self.intRing
        let additive = ring.additiveGroup
        #expect(additive.identity == 0)
        #expect(additive.combining(3, 4) == 7)
    }

    @Test
    func `multiplicativeMonoid projection returns multiplicative monoid`() {
        let ring = Self.intRing
        let multiplicative = ring.multiplicativeMonoid
        #expect(multiplicative.identity == 1)
        #expect(multiplicative.combining(3, 4) == 12)
    }
}

// MARK: - EdgeCase

extension AlgebraRingTests.EdgeCase {
    @Test
    func `zero annihilates under multiplication`() {
        let ring = AlgebraRingTests.Unit.intRing
        #expect(ring.multiplying(ring.zero, 42) == ring.zero)
        #expect(ring.multiplying(42, ring.zero) == ring.zero)
    }

    @Test
    func `distributivity left holds`() {
        let ring = AlgebraRingTests.Unit.intRing
        let a = 2, b = 3, c = 4
        // a * (b + c) == a*b + a*c
        let lhs = ring.multiplying(a, ring.adding(b, c))
        let rhs = ring.adding(ring.multiplying(a, b), ring.multiplying(a, c))
        #expect(lhs == rhs)
    }

    @Test
    func `distributivity right holds`() {
        let ring = AlgebraRingTests.Unit.intRing
        let a = 2, b = 3, c = 4
        // (a + b) * c == a*c + b*c
        let lhs = ring.multiplying(ring.adding(a, b), c)
        let rhs = ring.adding(ring.multiplying(a, c), ring.multiplying(b, c))
        #expect(lhs == rhs)
    }
}
