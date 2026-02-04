import Testing

@testable import Algebra_Primitives
import Algebra_Primitives_Test_Support

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Z")
struct AlgebraZTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraZTests.Unit {
    typealias Z5 = Algebra.Z<5>
    typealias Z7 = Algebra.Z<7>

    @Test
    func `checked init accepts valid residues`() throws {
        let zero: Int = 0
        let four: Int = 4
        let a = try Z5(zero)
        #expect(a.intValue == 0)
        let b = try Z5(four)
        #expect(b.intValue == 4)
    }

    @Test
    func `checked init rejects out of bounds`() {
        let five: Int = 5
        let negOne: Int = -1
        #expect(throws: Algebra.Z<3>.Error.bounds(5)) {
            try Algebra.Z<3>(five)
        }
        #expect(throws: Algebra.Z<3>.Error.bounds(-1)) {
            try Algebra.Z<3>(negOne)
        }
    }

    @Test
    func `checked init rejects non-positive modulus`() {
        let zero: Int = 0
        #expect(throws: Algebra.Z<0>.Error.modulus) {
            try Algebra.Z<0>(zero)
        }
    }

    @Test
    func `wrapping init reduces positive values`() throws {
        let a = try Z5(wrapping: 7)
        #expect(a.intValue == 2)
        let b = try Z5(wrapping: 5)
        #expect(b.intValue == 0)
    }

    @Test
    func `wrapping init reduces negative values`() throws {
        let a = try Z5(wrapping: -1)
        #expect(a.intValue == 4)
        let b = try Z5(wrapping: -7)
        #expect(b.intValue == 3)
    }

    @Test
    func `zero and one constants`() {
        #expect(Z5.zero.intValue == 0)
        #expect(Z5.one.intValue == 1)
        #expect(Algebra.Z<1>.one.intValue == 0)
    }

    @Test(arguments: [
        (0, 2, 2),
        (1, 1, 2),
        (3, 4, 2),
        (0, 0, 0),
    ])
    func `addition mod 5`(a: Int, b: Int, expected: Int) throws {
        let lhs = try Z5(a)
        let rhs = try Z5(b)
        #expect((lhs + rhs).intValue == expected)
    }

    @Test(arguments: [
        (2, 3, 4),
        (0, 1, 4),
        (3, 3, 0),
    ])
    func `subtraction mod 5`(a: Int, b: Int, expected: Int) throws {
        let lhs = try Z5(a)
        let rhs = try Z5(b)
        #expect((lhs - rhs).intValue == expected)
    }

    @Test
    func `multiplication mod 5`() throws {
        let a: Z5 = 3
        let b: Z5 = 4
        let c = try a * b
        #expect(c.intValue == 2) // 12 mod 5 = 2
    }

    @Test
    func `negation`() {
        let a: Z5 = 3
        #expect((-a).intValue == 2)
        #expect((-Z5.zero).intValue == 0)
    }
}

// MARK: - Finite.Enumerable

extension AlgebraZTests.Unit {
    @Test
    func `count equals modulus`() {
        #expect(Z5.count == Cardinal(5))
        #expect(Algebra.Z<2>.count == Cardinal(2))
    }

    @Test
    func `ordinal matches residue`() {
        let a: Z5 = 3
        #expect(a.ordinal == Ordinal(3))
    }

    @Test
    func `allCases enumerates all residues`() {
        let cases = Array(Z5.allCases)
        #expect(cases.count == 5)
        for i in 0..<5 {
            #expect(cases[i].intValue == i)
        }
    }
}

// MARK: - Ring

extension AlgebraZTests.Unit {
    @Test
    func `ring witness exists for small moduli`() {
        #expect(Algebra.Z<2>.ring != nil)
        #expect(Algebra.Z<3>.ring != nil)
        #expect(Z5.ring != nil)
        #expect(Z7.ring != nil)
    }

    @Test
    func `ring distributivity`() {
        guard let ring = Z5.ring else {
            Issue.record("Ring should exist for n=5")
            return
        }
        for a in Z5.allCases {
            for b in Z5.allCases {
                for c in Z5.allCases {
                    // a * (b + c) == a*b + a*c
                    let lhs = ring.multiplying(a, ring.adding(b, c))
                    let rhs = ring.adding(ring.multiplying(a, b), ring.multiplying(a, c))
                    #expect(lhs == rhs)
                }
            }
        }
    }

    @Test
    func `ring zero annihilation`() {
        guard let ring = Z7.ring else {
            Issue.record("Ring should exist for n=7")
            return
        }
        for a in Z7.allCases {
            #expect(ring.multiplying(ring.zero, a) == ring.zero)
            #expect(ring.multiplying(a, ring.zero) == ring.zero)
        }
    }
}

// MARK: - Field

extension AlgebraZTests.Unit {
    @Test
    func `field exists for primes`() {
        #expect(Algebra.Z<2>.field() != nil)
        #expect(Algebra.Z<3>.field() != nil)
        #expect(Z5.field() != nil)
        #expect(Z7.field() != nil)
    }

    @Test
    func `field does not exist for composites`() {
        #expect(Algebra.Z<4>.field() == nil)
        #expect(Algebra.Z<6>.field() == nil)
        #expect(Algebra.Z<8>.field() == nil)
        #expect(Algebra.Z<9>.field() == nil)
    }

    @Test
    func `field does not exist for 1`() {
        #expect(Algebra.Z<1>.field() == nil)
    }

    @Test
    func `reciprocal exhaustive Z5`() throws {
        guard let field = Z5.field() else {
            Issue.record("Field should exist for n=5")
            return
        }
        for a in Z5.allCases where a.intValue != 0 {
            let inv = try field.reciprocal(a)
            #expect(field.multiplying(a, inv) == field.one)
        }
    }

    @Test
    func `reciprocal exhaustive Z7`() throws {
        guard let field = Z7.field() else {
            Issue.record("Field should exist for n=7")
            return
        }
        for a in Z7.allCases where a.intValue != 0 {
            let inv = try field.reciprocal(a)
            #expect(field.multiplying(a, inv) == field.one)
        }
    }

    @Test
    func `reciprocal of zero throws nonInvertible`() {
        guard let field = Z5.field() else {
            Issue.record("Field should exist for n=5")
            return
        }
        #expect(throws: Algebra.Field<Z5>.Error.nonInvertible) {
            try field.reciprocal(.zero)
        }
    }
}

// MARK: - Zero Modulus

extension AlgebraZTests.EdgeCase {
    @Test
    func `wrapping init with zero modulus throws`() {
        #expect(throws: Algebra.Z<0>.Error.modulus) {
            try Algebra.Z<0>(wrapping: 42)
        }
    }

    @Test
    func `checked init with zero modulus throws`() {
        let zero: Int = 0
        #expect(throws: Algebra.Z<0>.Error.modulus) {
            try Algebra.Z<0>(zero)
        }
    }
}

// MARK: - Overflow

extension AlgebraZTests.EdgeCase {
    @Test
    func `ring returns nil for zero modulus`() {
        #expect(Algebra.Z<0>.ring == nil)
    }
}

// MARK: - EdgeCase

extension AlgebraZTests.EdgeCase {
    typealias Z5 = Algebra.Z<5>

    @Test
    func `Z2 is smallest field`() throws {
        guard let field = Algebra.Z<2>.field() else {
            Issue.record("Field should exist for n=2")
            return
        }
        #expect(field.zero.intValue == 0)
        #expect(field.one.intValue == 1)
        let inv = try field.reciprocal(field.one)
        #expect(inv == field.one)
    }

    @Test
    func `Z1 has trivial ring`() {
        guard let ring = Algebra.Z<1>.ring else {
            Issue.record("Ring should exist for n=1")
            return
        }
        #expect(ring.zero == ring.one)
    }

    @Test
    func `compound assignment operators`() throws {
        var a: Z5 = 3
        let four: Z5 = 4
        a += four
        #expect(a.intValue == 2) // 3 + 4 = 7 mod 5 = 2
        let one: Z5 = 1
        a -= one
        #expect(a.intValue == 1)
        let three: Z5 = 3
        try (a *= three)
        #expect(a.intValue == 3)
    }
}
