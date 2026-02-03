import Testing

@testable import Algebra_Magma_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Semigroup")
struct AlgebraSemigroupTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraSemigroupTests.Unit {
    @Test
    func `init stores combining operation`() {
        let semigroup = Algebra.Semigroup<Int>(combining: { $0 &+ $1 })
        #expect(semigroup.combining(3, 4) == 7)
    }

    @Test
    func `associativity holds for addition`() {
        let semigroup = Algebra.Semigroup<Int>(combining: { $0 &+ $1 })
        let a = 1, b = 2, c = 3
        let leftAssoc = semigroup.combining(semigroup.combining(a, b), c)
        let rightAssoc = semigroup.combining(a, semigroup.combining(b, c))
        #expect(leftAssoc == rightAssoc)
    }

    @Test
    func `magma projection preserves operation`() {
        let semigroup = Algebra.Semigroup<Int>(combining: { $0 &+ $1 })
        let magma = semigroup.magma
        #expect(magma.combining(3, 4) == semigroup.combining(3, 4))
    }
}

// MARK: - EdgeCase

extension AlgebraSemigroupTests.EdgeCase {
    @Test
    func `combining with string concatenation`() {
        let semigroup = Algebra.Semigroup<String>(combining: { $0 + $1 })
        let result = semigroup.combining(semigroup.combining("a", "b"), "c")
        #expect(result == "abc")
    }
}
