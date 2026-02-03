import Testing

@testable import Algebra_Primitives

// MARK: - Bool Semiring

@Suite("Bool OR/AND Semiring")
struct BoolSemiringTests {
    @Suite struct Unit {}
}

extension BoolSemiringTests {
    static var allBool: [Bool] { [false, true] }
}

extension BoolSemiringTests.Unit {
    @Test
    func `boolean semiring has correct identities`() {
        let sr = Algebra.Semiring<Bool>.boolean
        #expect(sr.zero == false)
        #expect(sr.one == true)
    }

    @Test
    func `boolean semiring addition is OR`() {
        let sr = Algebra.Semiring<Bool>.boolean
        #expect(sr.adding(false, false) == false)
        #expect(sr.adding(false, true) == true)
        #expect(sr.adding(true, false) == true)
        #expect(sr.adding(true, true) == true)
    }

    @Test
    func `boolean semiring multiplication is AND`() {
        let sr = Algebra.Semiring<Bool>.boolean
        #expect(sr.multiplying(true, true) == true)
        #expect(sr.multiplying(true, false) == false)
        #expect(sr.multiplying(false, true) == false)
        #expect(sr.multiplying(false, false) == false)
    }

    @Test
    func `boolean semiring additive identity law`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let left = Algebra.Law.Identity.left(of: sr.semiring.additive.monoid, over: BoolSemiringTests.allBool)
        let right = Algebra.Law.Identity.right(of: sr.semiring.additive.monoid, over: BoolSemiringTests.allBool)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `boolean semiring multiplicative identity law`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let left = Algebra.Law.Identity.left(of: sr.semiring.multiplicative, over: BoolSemiringTests.allBool)
        let right = Algebra.Law.Identity.right(of: sr.semiring.multiplicative, over: BoolSemiringTests.allBool)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `boolean semiring additive associativity`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let result = Algebra.Law.Associativity.check(
            of: sr.semiring.additive.monoid.semigroup,
            over: BoolSemiringTests.allBool
        )
        #expect(result == nil)
    }

    @Test
    func `boolean semiring multiplicative associativity`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let result = Algebra.Law.Associativity.check(
            of: sr.semiring.multiplicative.semigroup,
            over: BoolSemiringTests.allBool
        )
        #expect(result == nil)
    }

    @Test
    func `boolean semiring additive commutativity`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let result = Algebra.Law.Commutativity.check(
            of: sr.semiring.additive.combining,
            over: BoolSemiringTests.allBool
        )
        #expect(result == nil)
    }

    @Test
    func `boolean semiring multiplicative commutativity`() {
        let sr = Algebra.Semiring<Bool>.boolean
        let result = Algebra.Law.Commutativity.check(
            of: sr.semiring.multiplicative.combining,
            over: BoolSemiringTests.allBool
        )
        #expect(result == nil)
    }
}

// MARK: - Bool Monoids

@Suite("Bool Monoids")
struct BoolMonoidTests {
    @Suite struct Unit {}
}

extension BoolMonoidTests {
    static var allBool: [Bool] { [false, true] }
}

extension BoolMonoidTests.Unit {
    @Test
    func `conjunction identity is true`() {
        #expect(Algebra.Monoid<Bool>.conjunction.identity == true)
    }

    @Test
    func `disjunction identity is false`() {
        #expect(Algebra.Monoid<Bool>.disjunction.identity == false)
    }

    @Test
    func `conjunction identity law`() {
        let m = Algebra.Monoid<Bool>.conjunction
        let left = Algebra.Law.Identity.left(of: m, over: BoolMonoidTests.allBool)
        let right = Algebra.Law.Identity.right(of: m, over: BoolMonoidTests.allBool)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `disjunction identity law`() {
        let m = Algebra.Monoid<Bool>.disjunction
        let left = Algebra.Law.Identity.left(of: m, over: BoolMonoidTests.allBool)
        let right = Algebra.Law.Identity.right(of: m, over: BoolMonoidTests.allBool)
        #expect(left == nil)
        #expect(right == nil)
    }

    @Test
    func `conjunction associativity`() {
        let result = Algebra.Law.Associativity.check(
            of: Algebra.Monoid<Bool>.conjunction.semigroup,
            over: BoolMonoidTests.allBool
        )
        #expect(result == nil)
    }

    @Test
    func `disjunction associativity`() {
        let result = Algebra.Law.Associativity.check(
            of: Algebra.Monoid<Bool>.disjunction.semigroup,
            over: BoolMonoidTests.allBool
        )
        #expect(result == nil)
    }
}
