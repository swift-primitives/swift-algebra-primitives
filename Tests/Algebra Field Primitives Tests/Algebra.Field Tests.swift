import Testing

@testable import Algebra_Field_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Field")
struct AlgebraFieldTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraFieldTests.Unit {
    static var boolField: Algebra.Field<Bool> {
        .init(
            additive: .init(group: .init(
                identity: false,
                combining: { $0 != $1 },  // XOR
                inverting: { $0 }          // self-inverse
            )),
            multiplicative: .init(group: .init(
                identity: true,
                combining: { $0 && $1 },   // AND
                inverting: { $0 }           // self-inverse (only true is nonzero)
            ))
        )
    }

    @Test
    func `init stores additive and multiplicative structures`() {
        let field = Self.boolField
        #expect(field.additive.identity == false)
        #expect(field.multiplicative.identity == true)
    }

    @Test
    func `zero returns additive identity`() {
        let field = Self.boolField
        #expect(field.zero == false)
    }

    @Test
    func `one returns multiplicative identity`() {
        let field = Self.boolField
        #expect(field.one == true)
    }

    @Test
    func `adding delegates to additive group`() {
        let field = Self.boolField
        #expect(field.adding(true, true) == false) // XOR
        #expect(field.adding(true, false) == true)
    }

    @Test
    func `negating delegates to additive inverse`() {
        let field = Self.boolField
        #expect(field.negating(true) == true)  // self-inverse in Z₂
        #expect(field.negating(false) == false)
    }

    @Test
    func `multiplying delegates to multiplicative group`() {
        let field = Self.boolField
        #expect(field.multiplying(true, true) == true) // AND
        #expect(field.multiplying(true, false) == false)
    }

    @Test
    func `reciprocal delegates to multiplicative inverse`() {
        let field = Self.boolField
        #expect(field.reciprocal(true) == true) // self-inverse in Z₂
    }

    @Test
    func `additiveGroup projection returns additive structure`() {
        let field = Self.boolField
        let additive = field.additiveGroup
        #expect(additive.identity == false)
    }

    @Test
    func `multiplicativeGroup projection returns multiplicative structure`() {
        let field = Self.boolField
        let multiplicative = field.multiplicativeGroup
        #expect(multiplicative.identity == true)
    }

    @Test
    func `ring projection returns commutative ring`() {
        let field = Self.boolField
        let ring = field.ring
        #expect(ring.zero == false)
        #expect(ring.one == true)
    }
}

// MARK: - EdgeCase

extension AlgebraFieldTests.EdgeCase {
    @Test
    func `field distributivity holds`() {
        let field = AlgebraFieldTests.Unit.boolField
        let a = true, b = true, c = false
        // a * (b + c) == a*b + a*c
        let lhs = field.multiplying(a, field.adding(b, c))
        let rhs = field.adding(field.multiplying(a, b), field.multiplying(a, c))
        #expect(lhs == rhs)
    }

    @Test
    func `additive inverse produces zero`() {
        let field = AlgebraFieldTests.Unit.boolField
        #expect(field.adding(true, field.negating(true)) == field.zero)
    }
}
