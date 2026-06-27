import Testing

@testable import Algebra_Group_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Group.Abelian")
struct AlgebraGroupAbelianTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraGroupAbelianTests.Unit {
    @Test
    func `init wraps group`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        #expect(abelian.identity == 0)
        #expect(abelian.combining(3, 4) == 7)
        #expect(abelian.inverting(5) == -5)
    }

    @Test
    func `identity delegates to underlying group`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        #expect(abelian.identity == group.identity)
    }

    @Test
    func `combining delegates to underlying group`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        #expect(abelian.combining(3, 4) == group.combining(3, 4))
    }

    @Test
    func `inverting delegates to underlying group`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        #expect(abelian.inverting(5) == group.inverting(5))
    }

    @Test
    func `commutativity holds for addition`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        #expect(abelian.combining(3, 4) == abelian.combining(4, 3))
    }

    @Test
    func `monoid projection preserves identity and combining`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        let monoid = abelian.monoid
        #expect(monoid.identity == abelian.identity)
        #expect(monoid.combining(3, 4) == abelian.combining(3, 4))
    }

    @Test
    func `commutative monoid projection preserves identity and combining`() {
        let group = Algebra.Group<Int>(
            identity: 0,
            combining: { $0 &+ $1 },
            inverting: { 0 &- $0 }
        )
        let abelian = Algebra.Group<Int>.Abelian(group: group)
        let commutative = abelian.commutative
        #expect(commutative.identity == abelian.identity)
        #expect(commutative.combining(3, 4) == abelian.combining(3, 4))
    }
}

// MARK: - EdgeCase

extension AlgebraGroupAbelianTests.EdgeCase {
    @Test
    func `abelian group with self-inverse elements`() {
        // Z₂ addition: every element is its own inverse
        let group = Algebra.Group<Bool>(
            identity: false,
            combining: { $0 != $1 },  // XOR
            inverting: { $0 }  // self-inverse
        )
        let abelian = Algebra.Group<Bool>.Abelian(group: group)
        #expect(abelian.combining(true, abelian.inverting(true)) == abelian.identity)
    }
}
