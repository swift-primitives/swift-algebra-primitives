import Testing

@testable import Algebra_Primitives

// MARK: - Algebra Namespace

// [TEST-003] Non-generic type uses type extension pattern.

extension Algebra {
    @Suite
    struct Test {
        @Suite struct Unit {}
    }
}

extension Algebra.Test.Unit {
    @Test
    func `Algebra is namespace enum`() {
        let _: Algebra.Type = Algebra.self
    }
}

// MARK: - Bool XOR

@Suite("Bool XOR")
struct BoolXORTests {
    @Suite struct Unit {}
}

extension BoolXORTests.Unit {
    @Test(arguments: [
        (false, false, false),
        (false, true, true),
        (true, false, true),
        (true, true, false),
    ])
    func `xor operator truth table`(lhs: Bool, rhs: Bool, expected: Bool) {
        #expect((lhs ^ rhs) == expected)
    }
}

// MARK: - Algebra.Field Z₂ Parity Integration

@Suite("Algebra.Field Z₂ Parity")
struct AlgebraFieldParityTests {
    @Suite struct Unit {}
}

extension AlgebraFieldParityTests.Unit {
    @Test
    func `z2 additive identity is even`() {
        let z2 = Algebra.Field<Parity>.z2
        #expect(z2.zero == .even)
    }

    @Test
    func `z2 multiplicative identity is odd`() {
        let z2 = Algebra.Field<Parity>.z2
        #expect(z2.one == .odd)
    }

    @Test
    func `z2 addition is XOR`() {
        let z2 = Algebra.Field<Parity>.z2
        #expect(z2.adding(.odd, .odd) == .even)
        #expect(z2.adding(.even, .odd) == .odd)
        #expect(z2.adding(.odd, .even) == .odd)
        #expect(z2.adding(.even, .even) == .even)
    }

    @Test
    func `z2 multiplication is AND`() {
        let z2 = Algebra.Field<Parity>.z2
        #expect(z2.multiplying(.odd, .odd) == .odd)
        #expect(z2.multiplying(.even, .odd) == .even)
        #expect(z2.multiplying(.odd, .even) == .even)
        #expect(z2.multiplying(.even, .even) == .even)
    }

    @Test
    func `z2 every element is its own additive inverse`() {
        let z2 = Algebra.Field<Parity>.z2
        #expect(z2.negating(.even) == .even)
        #expect(z2.negating(.odd) == .odd)
    }
}

// MARK: - Algebra.Group Parity Integration

@Suite("Algebra.Group Parity")
struct AlgebraGroupParityTests {
    @Suite struct Unit {}
}

extension AlgebraGroupParityTests.Unit {
    @Test
    func `additive group identity is even`() {
        let group = Algebra.Group<Parity>.additive
        #expect(group.identity == .even)
    }

    @Test
    func `additive group combining is parity addition`() {
        let group = Algebra.Group<Parity>.additive
        #expect(group.combining(.odd, .odd) == .even)
        #expect(group.combining(.even, .odd) == .odd)
    }

    @Test
    func `additive group elements are self-inverse`() {
        let group = Algebra.Group<Parity>.additive
        #expect(group.inverting(.even) == .even)
        #expect(group.inverting(.odd) == .odd)
    }
}
