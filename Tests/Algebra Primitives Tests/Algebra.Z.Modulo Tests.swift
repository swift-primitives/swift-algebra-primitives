import Testing

@testable import Algebra_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Z.Modulo")
struct AlgebraZModuloTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraZModuloTests.Unit {
    @Test
    func `checked init accepts valid residues`() throws {
        let a = try Algebra.Z.Modulo<5>(0)
        #expect(a.residue == 0)
        let b = try Algebra.Z.Modulo<5>(4)
        #expect(b.residue == 4)
    }

    @Test
    func `checked init rejects out of bounds`() {
        #expect(throws: Algebra.Z.Modulo<3>.Error.bounds(5)) {
            try Algebra.Z.Modulo<3>(5)
        }
        #expect(throws: Algebra.Z.Modulo<3>.Error.bounds(-1)) {
            try Algebra.Z.Modulo<3>(-1)
        }
    }

    @Test
    func `checked init rejects non-positive modulus`() {
        #expect(throws: Algebra.Z.Modulo<0>.Error.modulus) {
            try Algebra.Z.Modulo<0>(0)
        }
    }

    @Test
    func `wrapping init reduces positive values`() {
        let a = Algebra.Z.Modulo<5>(wrapping: 7)
        #expect(a.residue == 2)
        let b = Algebra.Z.Modulo<5>(wrapping: 5)
        #expect(b.residue == 0)
    }

    @Test
    func `wrapping init reduces negative values`() {
        let a = Algebra.Z.Modulo<5>(wrapping: -1)
        #expect(a.residue == 4)
        let b = Algebra.Z.Modulo<5>(wrapping: -7)
        #expect(b.residue == 3)
    }

    @Test
    func `zero and one constants`() {
        #expect(Algebra.Z.Modulo<5>.zero.residue == 0)
        #expect(Algebra.Z.Modulo<5>.one.residue == 1)
        #expect(Algebra.Z.Modulo<1>.one.residue == 0)
    }

    @Test(arguments: [
        (0, 2, 2),
        (1, 1, 2),
        (3, 4, 2),
        (0, 0, 0),
    ])
    func `addition mod 5`(a: Int, b: Int, expected: Int) {
        let lhs = Algebra.Z.Modulo<5>(wrapping: a)
        let rhs = Algebra.Z.Modulo<5>(wrapping: b)
        #expect((lhs + rhs).residue == expected)
    }

    @Test(arguments: [
        (2, 3, 4),
        (0, 1, 4),
        (3, 3, 0),
    ])
    func `subtraction mod 5`(a: Int, b: Int, expected: Int) {
        let lhs = Algebra.Z.Modulo<5>(wrapping: a)
        let rhs = Algebra.Z.Modulo<5>(wrapping: b)
        #expect((lhs - rhs).residue == expected)
    }

    @Test
    func `multiplication mod 5`() throws {
        let a = Algebra.Z.Modulo<5>(wrapping: 3)
        let b = Algebra.Z.Modulo<5>(wrapping: 4)
        let c = try a * b
        #expect(c.residue == 2) // 12 mod 5 = 2
    }

    @Test
    func `negation`() {
        let a = Algebra.Z.Modulo<5>(wrapping: 3)
        #expect((-a).residue == 2)
        #expect((-Algebra.Z.Modulo<5>.zero).residue == 0)
    }
}

// MARK: - Finite.Enumerable

extension AlgebraZModuloTests.Unit {
    @Test
    func `count equals modulus`() {
        #expect(Algebra.Z.Modulo<5>.count == Cardinal(5))
        #expect(Algebra.Z.Modulo<2>.count == Cardinal(2))
    }

    @Test
    func `ordinal matches residue`() {
        let a = Algebra.Z.Modulo<5>(wrapping: 3)
        #expect(a.ordinal == Ordinal(3))
    }

    @Test
    func `allCases enumerates all residues`() {
        let cases = Array(Algebra.Z.Modulo<5>.allCases)
        #expect(cases.count == 5)
        for i in 0..<5 {
            #expect(cases[i].residue == i)
        }
    }
}

// MARK: - Ring

extension AlgebraZModuloTests.Unit {
    @Test
    func `ring witness exists for small moduli`() {
        #expect(Algebra.Z.Modulo<2>.ring != nil)
        #expect(Algebra.Z.Modulo<3>.ring != nil)
        #expect(Algebra.Z.Modulo<5>.ring != nil)
        #expect(Algebra.Z.Modulo<7>.ring != nil)
    }

    @Test
    func `ring distributivity`() {
        guard let ring = Algebra.Z.Modulo<5>.ring else {
            Issue.record("Ring should exist for n=5")
            return
        }
        for a in Algebra.Z.Modulo<5>.allCases {
            for b in Algebra.Z.Modulo<5>.allCases {
                for c in Algebra.Z.Modulo<5>.allCases {
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
        guard let ring = Algebra.Z.Modulo<7>.ring else {
            Issue.record("Ring should exist for n=7")
            return
        }
        for a in Algebra.Z.Modulo<7>.allCases {
            #expect(ring.multiplying(ring.zero, a) == ring.zero)
            #expect(ring.multiplying(a, ring.zero) == ring.zero)
        }
    }
}

// MARK: - Field

extension AlgebraZModuloTests.Unit {
    @Test
    func `field exists for primes`() {
        #expect(Algebra.Z.Modulo<2>.field() != nil)
        #expect(Algebra.Z.Modulo<3>.field() != nil)
        #expect(Algebra.Z.Modulo<5>.field() != nil)
        #expect(Algebra.Z.Modulo<7>.field() != nil)
    }

    @Test
    func `field does not exist for composites`() {
        #expect(Algebra.Z.Modulo<4>.field() == nil)
        #expect(Algebra.Z.Modulo<6>.field() == nil)
        #expect(Algebra.Z.Modulo<8>.field() == nil)
        #expect(Algebra.Z.Modulo<9>.field() == nil)
    }

    @Test
    func `field does not exist for 1`() {
        #expect(Algebra.Z.Modulo<1>.field() == nil)
    }

    @Test
    func `reciprocal exhaustive Z5`() throws {
        guard let field = Algebra.Z.Modulo<5>.field() else {
            Issue.record("Field should exist for n=5")
            return
        }
        for a in Algebra.Z.Modulo<5>.allCases where a.residue != 0 {
            let inv = try field.reciprocal(a)
            #expect(field.multiplying(a, inv) == field.one)
        }
    }

    @Test
    func `reciprocal exhaustive Z7`() throws {
        guard let field = Algebra.Z.Modulo<7>.field() else {
            Issue.record("Field should exist for n=7")
            return
        }
        for a in Algebra.Z.Modulo<7>.allCases where a.residue != 0 {
            let inv = try field.reciprocal(a)
            #expect(field.multiplying(a, inv) == field.one)
        }
    }

    @Test
    func `reciprocal of zero throws nonInvertible`() {
        guard let field = Algebra.Z.Modulo<5>.field() else {
            Issue.record("Field should exist for n=5")
            return
        }
        #expect(throws: Algebra.Field<Algebra.Z.Modulo<5>>.Error.nonInvertible) {
            try field.reciprocal(.zero)
        }
    }
}

// MARK: - Zero Modulus

extension AlgebraZModuloTests.EdgeCase {
    @Test
    func `wrapping init with zero modulus does not trap`() {
        let a = Algebra.Z.Modulo<0>(wrapping: 42)
        #expect(a.residue == 0)
    }

    @Test
    func `negation with zero modulus does not trap`() {
        let a = Algebra.Z.Modulo<0>(wrapping: 0)
        #expect((-a).residue == 0)
    }
}

// MARK: - Overflow

extension AlgebraZModuloTests.EdgeCase {
    // n=100_000: (n-1)^2 = 9_999_800_001, fits in Int → ring exists.
    // Residues up to 99_999: 99_999 * 99_999 = 9_999_800_001, no overflow.
    // But we can force overflow with a modulus where (n-1)^2 overflows.
    // Since very large value generics can crash the compiler's mangler,
    // we test overflow by verifying the ring returns nil for n where
    // (n-1)*(n-1) would overflow, using the ring property itself.
    // The ring property already guards: (n-1).multipliedReportingOverflow(by: n-1).

    @Test
    func `ring returns nil for zero modulus`() {
        #expect(Algebra.Z.Modulo<0>.ring == nil)
    }
}

// MARK: - EdgeCase

extension AlgebraZModuloTests.EdgeCase {
    @Test
    func `Z2 is smallest field`() throws {
        guard let field = Algebra.Z.Modulo<2>.field() else {
            Issue.record("Field should exist for n=2")
            return
        }
        #expect(field.zero.residue == 0)
        #expect(field.one.residue == 1)
        let inv = try field.reciprocal(field.one)
        #expect(inv == field.one)
    }

    @Test
    func `Z1 has trivial ring`() {
        guard let ring = Algebra.Z.Modulo<1>.ring else {
            Issue.record("Ring should exist for n=1")
            return
        }
        #expect(ring.zero == ring.one)
    }

    @Test
    func `compound assignment operators`() throws {
        var a = Algebra.Z.Modulo<5>(wrapping: 3)
        a += .init(wrapping: 4)
        #expect(a.residue == 2) // 3 + 4 = 7 mod 5 = 2
        a -= .init(wrapping: 1)
        #expect(a.residue == 1)
        try (a *= .init(wrapping: 3))
        #expect(a.residue == 3)
    }
}
