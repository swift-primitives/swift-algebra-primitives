import Testing

@testable import Algebra_Primitives

// Exhaustive law verification using Finite.Enumerable carriers.

// MARK: - Parity Z₂ Field Laws

@Suite("Parity Z₂ Law Verification")
struct ParityLawVerificationTests {
    @Suite struct Unit {}
}

extension ParityLawVerificationTests.Unit {
    var z2: Algebra.Field<Parity> { .z2 }
    var allParity: [Parity] { Array(Parity.allCases) }

    @Test
    func `additive associativity`() {
        let result = Algebra.Law.Associativity.check(
            of: Algebra.Field<Parity>.z2.additive.group.semigroup,
            over: allParity
        )
        #expect(result == nil)
    }

    @Test
    func `additive identity`() {
        let left = Algebra.Law.Identity.left(of: z2.additive.monoid, over: allParity)
        let right = Algebra.Law.Identity.right(of: z2.additive.monoid, over: allParity)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `additive inverse`() {
        let left = Algebra.Law.Inverse.left(of: z2.additive.group, over: allParity)
        let right = Algebra.Law.Inverse.right(of: z2.additive.group, over: allParity)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `additive commutativity`() {
        let result = Algebra.Law.Commutativity.check(
            of: z2.additive.combining,
            over: allParity
        )
        #expect(result == nil)
    }

    @Test
    func `multiplicative associativity`() {
        let result = Algebra.Law.Associativity.check(
            of: z2.multiplicative.monoid.semigroup,
            over: allParity
        )
        #expect(result == nil)
    }

    @Test
    func `multiplicative identity`() {
        let left = Algebra.Law.Identity.left(of: z2.multiplicative.monoid, over: allParity)
        let right = Algebra.Law.Identity.right(of: z2.multiplicative.monoid, over: allParity)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `multiplicative commutativity`() {
        let result = Algebra.Law.Commutativity.check(
            of: z2.multiplicative.combining, over: allParity
        )
        #expect(result == nil)
    }

    @Test
    func `distributivity`() {
        let left = Algebra.Law.Distributivity.left(of: z2.ring.ring, over: allParity)
        let right = Algebra.Law.Distributivity.right(of: z2.ring.ring, over: allParity)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `annihilation`() {
        let result = Algebra.Law.Annihilation.zero(of: z2.ring.ring, over: allParity)
        #expect(result == nil)
    }

    @Test
    func `reciprocal`() {
        let result = Algebra.Law.Reciprocal.check(of: z2, over: allParity)
        #expect(result == nil)
    }
}

// MARK: - Z₂ Group Laws (Bound, Boundary, Endpoint, Gradient)

@Suite("Z₂ Group Law Verification")
struct Z2GroupLawVerificationTests {
    @Suite struct Unit {}
}

extension Z2GroupLawVerificationTests.Unit {
    @Test
    func `Bound Z2 group laws`() {
        let group = Algebra.Group<Bound>.z2
        let all = Array(Bound.allCases)
        #expect(Algebra.Law.Associativity.check(of: group.semigroup, over: all) == nil)
        #expect(Algebra.Law.Identity.left(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Identity.right(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Inverse.left(of: group, over: all) == nil)
        #expect(Algebra.Law.Inverse.right(of: group, over: all) == nil)
    }

    @Test
    func `Boundary Z2 group laws`() {
        let group = Algebra.Group<Boundary>.z2
        let all = Array(Boundary.allCases)
        #expect(Algebra.Law.Associativity.check(of: group.semigroup, over: all) == nil)
        #expect(Algebra.Law.Identity.left(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Identity.right(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Inverse.left(of: group, over: all) == nil)
        #expect(Algebra.Law.Inverse.right(of: group, over: all) == nil)
    }

    @Test
    func `Endpoint Z2 group laws`() {
        let group = Algebra.Group<Endpoint>.z2
        let all = Array(Endpoint.allCases)
        #expect(Algebra.Law.Associativity.check(of: group.semigroup, over: all) == nil)
        #expect(Algebra.Law.Identity.left(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Identity.right(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Inverse.left(of: group, over: all) == nil)
        #expect(Algebra.Law.Inverse.right(of: group, over: all) == nil)
    }

    @Test
    func `Gradient Z2 group laws`() {
        let group = Algebra.Group<Gradient>.z2
        let all = Array(Gradient.allCases)
        #expect(Algebra.Law.Associativity.check(of: group.semigroup, over: all) == nil)
        #expect(Algebra.Law.Identity.left(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Identity.right(of: group.monoid, over: all) == nil)
        #expect(Algebra.Law.Inverse.left(of: group, over: all) == nil)
        #expect(Algebra.Law.Inverse.right(of: group, over: all) == nil)
    }
}

// MARK: - Z Law Verification

@Suite("Z Law Verification")
struct ZLawVerificationTests {
    @Suite struct Unit {}
}

extension ZLawVerificationTests.Unit {
    @Test
    func `Z5 ring laws`() {
        guard let ring = Algebra.Z<5>.ring else {
            Issue.record("Ring should exist for n=5")
            return
        }
        let all = Array(Algebra.Z<5>.allCases)
        #expect(Algebra.Law.Distributivity.left(of: ring.ring, over: all) == nil)
        #expect(Algebra.Law.Distributivity.right(of: ring.ring, over: all) == nil)
        #expect(Algebra.Law.Annihilation.zero(of: ring.ring, over: all) == nil)
    }

    @Test
    func `Z7 ring laws`() {
        guard let ring = Algebra.Z<7>.ring else {
            Issue.record("Ring should exist for n=7")
            return
        }
        let all = Array(Algebra.Z<7>.allCases)
        #expect(Algebra.Law.Distributivity.left(of: ring.ring, over: all) == nil)
        #expect(Algebra.Law.Distributivity.right(of: ring.ring, over: all) == nil)
        #expect(Algebra.Law.Annihilation.zero(of: ring.ring, over: all) == nil)
    }

    @Test
    func `Z5 field laws`() {
        guard let field = Algebra.Z<5>.field() else {
            Issue.record("Field should exist for n=5")
            return
        }
        let all = Array(Algebra.Z<5>.allCases)
        #expect(Algebra.Law.Reciprocal.check(of: field, over: all) == nil)
    }

    @Test
    func `Z7 field laws`() {
        guard let field = Algebra.Z<7>.field() else {
            Issue.record("Field should exist for n=7")
            return
        }
        let all = Array(Algebra.Z<7>.allCases)
        #expect(Algebra.Law.Reciprocal.check(of: field, over: all) == nil)
    }
}
