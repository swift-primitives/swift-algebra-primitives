import Testing

@testable import Algebra_Magma_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Magma")
struct AlgebraMagmaTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
}

// MARK: - Unit

extension AlgebraMagmaTests.Unit {
    @Test
    func `init stores combining operation`() {
        let magma = Algebra.Magma<Int>(combining: { $0 &+ $1 })
        #expect(magma.combining(3, 4) == 7)
    }

    @Test
    func `combining closure is applied correctly`() {
        let magma = Algebra.Magma<String>(combining: { $0 + $1 })
        #expect(magma.combining("hello", " world") == "hello world")
    }

    @Test
    func `combining with multiplication`() {
        let magma = Algebra.Magma<Int>(combining: { $0 &* $1 })
        #expect(magma.combining(3, 4) == 12)
    }
}

// MARK: - EdgeCase

extension AlgebraMagmaTests.EdgeCase {
    @Test
    func `combining with non-associative operation`() {
        // Subtraction is a valid magma but not a semigroup
        let magma = Algebra.Magma<Int>(combining: { $0 &- $1 })
        let leftAssoc = magma.combining(magma.combining(10, 3), 2)  // (10-3)-2 = 5
        let rightAssoc = magma.combining(10, magma.combining(3, 2))  // 10-(3-2) = 9
        #expect(leftAssoc != rightAssoc)
    }
}
