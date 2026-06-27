import Testing

@testable import Algebra_Semiring_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Semiring")
struct AlgebraSemiringTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Test Fixture

extension AlgebraSemiringTests {
    /// Bool OR/AND semiring for testing.
    static var boolSemiring: Algebra.Semiring<Bool> {
        .init(
            additive: .init(monoid: .init(identity: false, combining: { $0 || $1 })),
            multiplicative: .init(identity: true, combining: { $0 && $1 })
        )
    }
}

// MARK: - Unit

extension AlgebraSemiringTests.Unit {
    @Test
    func `init stores additive and multiplicative structures`() {
        let sr = AlgebraSemiringTests.boolSemiring
        #expect(sr.additive.identity == false)
        #expect(sr.multiplicative.identity == true)
    }

    @Test
    func `zero returns additive identity`() {
        let sr = AlgebraSemiringTests.boolSemiring
        #expect(sr.zero == false)
    }

    @Test
    func `one returns multiplicative identity`() {
        let sr = AlgebraSemiringTests.boolSemiring
        #expect(sr.one == true)
    }

    @Test
    func `adding delegates to additive monoid`() {
        let sr = AlgebraSemiringTests.boolSemiring
        #expect(sr.adding(false, false) == false)
        #expect(sr.adding(false, true) == true)
        #expect(sr.adding(true, false) == true)
        #expect(sr.adding(true, true) == true)
    }

    @Test
    func `multiplying delegates to multiplicative monoid`() {
        let sr = AlgebraSemiringTests.boolSemiring
        #expect(sr.multiplying(true, true) == true)
        #expect(sr.multiplying(true, false) == false)
        #expect(sr.multiplying(false, true) == false)
        #expect(sr.multiplying(false, false) == false)
    }
}

// MARK: - EdgeCase

extension AlgebraSemiringTests.EdgeCase {
    @Test
    func `distributivity left holds`() {
        let sr = AlgebraSemiringTests.boolSemiring
        for a in [true, false] {
            for b in [true, false] {
                for c in [true, false] {
                    // a * (b + c) == a*b + a*c
                    let lhs = sr.multiplying(a, sr.adding(b, c))
                    let rhs = sr.adding(sr.multiplying(a, b), sr.multiplying(a, c))
                    #expect(lhs == rhs)
                }
            }
        }
    }

    @Test
    func `distributivity right holds`() {
        let sr = AlgebraSemiringTests.boolSemiring
        for a in [true, false] {
            for b in [true, false] {
                for c in [true, false] {
                    // (a + b) * c == a*c + b*c
                    let lhs = sr.multiplying(sr.adding(a, b), c)
                    let rhs = sr.adding(sr.multiplying(a, c), sr.multiplying(b, c))
                    #expect(lhs == rhs)
                }
            }
        }
    }

    @Test
    func `zero annihilates under multiplication`() {
        let sr = AlgebraSemiringTests.boolSemiring
        for a in [true, false] {
            #expect(sr.multiplying(sr.zero, a) == sr.zero)
            #expect(sr.multiplying(a, sr.zero) == sr.zero)
        }
    }
}

// MARK: - Commutative

@Suite("Algebra.Semiring.Commutative")
struct AlgebraSemiringCommutativeTests {
    @Suite struct Unit {}
}

extension AlgebraSemiringCommutativeTests.Unit {
    static var commutative: Algebra.Semiring<Bool>.Commutative {
        .init(semiring: AlgebraSemiringTests.boolSemiring)
    }

    @Test
    func `init stores semiring`() {
        let csr = Self.commutative
        #expect(csr.semiring.zero == false)
        #expect(csr.semiring.one == true)
    }

    @Test
    func `convenience delegates to underlying semiring`() {
        let csr = Self.commutative
        #expect(csr.zero == false)
        #expect(csr.one == true)
        #expect(csr.adding(true, false) == true)
        #expect(csr.multiplying(true, false) == false)
    }
}

// MARK: - Monoid Erasure

@Suite("Algebra.Semiring Monoid Erasure")
struct AlgebraSemiringMonoidTests {
    @Suite struct Unit {}
}

extension AlgebraSemiringMonoidTests.Unit {
    @Test
    func `commutative monoid from semiring preserves additive identity`() {
        let sr = AlgebraSemiringTests.boolSemiring
        let monoid = Algebra.Monoid<Bool>.Commutative(sr)
        #expect(monoid.identity == false)
    }

    @Test
    func `commutative monoid from semiring preserves additive combining`() {
        let sr = AlgebraSemiringTests.boolSemiring
        let monoid = Algebra.Monoid<Bool>.Commutative(sr)
        #expect(monoid.combining(false, true) == true)
        #expect(monoid.combining(false, false) == false)
    }
}
