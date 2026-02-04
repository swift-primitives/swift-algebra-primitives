import Testing

@testable import Algebra_Primitives

// [TEST-004] Generic type uses parallel namespace pattern.

@Suite("Algebra.Module")
struct AlgebraModuleTests {
    @Suite struct Unit {}
}

// MARK: - Test Fixtures

extension AlgebraModuleTests {
    /// Parity field as scalars, Parity group as vectors.
    /// Scalar multiplication is Parity.multiplying.
    static var parityModule: Algebra.Module<Parity, Parity> {
        let ring = Algebra.Ring<Parity>(
            additive: .init(group: .init(
                identity: .even,
                combining: Parity.adding,
                inverting: { $0 }
            )),
            multiplicative: .init(
                identity: .odd,
                combining: Parity.multiplying
            )
        )
        return .init(
            scalars: ring,
            vectors: .init(group: .init(
                identity: .even,
                combining: Parity.adding,
                inverting: { $0 }
            )),
            scaling: Parity.multiplying
        )
    }

    static var parityVectorSpace: Algebra.VectorSpace<Parity, Parity> {
        let field = Algebra.Field<Parity>.z2
        return .init(
            scalars: field,
            vectors: .init(group: .init(
                identity: .even,
                combining: Parity.adding,
                inverting: { $0 }
            )),
            scaling: Parity.multiplying
        )
    }

    static var allParity: [Parity] { [.even, .odd] }
}

// MARK: - Unit

extension AlgebraModuleTests.Unit {
    @Test
    func `module stores components`() {
        let m = AlgebraModuleTests.parityModule
        #expect(m.zero == .even)
        #expect(m.one == .odd)
    }

    @Test
    func `module convenience methods`() {
        let m = AlgebraModuleTests.parityModule
        #expect(m.adding(.odd, .odd) == .even)
        #expect(m.negating(.odd) == .odd)
    }

    @Test
    func `vector space stores components`() {
        let vs = AlgebraModuleTests.parityVectorSpace
        #expect(vs.zero == .even)
    }

    @Test
    func `vector space convenience methods`() {
        let vs = AlgebraModuleTests.parityVectorSpace
        #expect(vs.adding(.odd, .odd) == .even)
        #expect(vs.subtracting(.odd, .odd) == .even)
        #expect(vs.negating(.odd) == .odd)
    }

    @Test
    func `vector space projects to module`() {
        let vs = AlgebraModuleTests.parityVectorSpace
        let m = vs.module
        #expect(m.zero == .even)
        #expect(m.one == .odd)
    }

    @Test
    func `scalar compatibility`() {
        let m = AlgebraModuleTests.parityModule
        let result = Algebra.Law.Compatibility.scalar(
            of: m,
            over: AlgebraModuleTests.allParity,
            AlgebraModuleTests.allParity
        )
        #expect(result == nil)
    }

    @Test
    func `identity action`() {
        let m = AlgebraModuleTests.parityModule
        let result = Algebra.Law.Action.identity(
            of: m,
            over: AlgebraModuleTests.allParity
        )
        #expect(result == nil)
    }

    @Test
    func `vector space module projection preserves laws`() {
        let vs = AlgebraModuleTests.parityVectorSpace
        let m = vs.module
        let result = Algebra.Law.Action.identity(
            of: m,
            over: AlgebraModuleTests.allParity
        )
        #expect(result == nil)
    }

    @Test
    func `module scalar distributes over vector addition`() {
        let m = AlgebraModuleTests.parityModule
        let result = Algebra.Law.Distributivity.scalar(
            of: m, over: AlgebraModuleTests.allParity, AlgebraModuleTests.allParity
        )
        #expect(result == nil)
    }

    @Test
    func `module scaling distributes over scalar addition`() {
        let m = AlgebraModuleTests.parityModule
        let result = Algebra.Law.Distributivity.addition(
            of: m, over: AlgebraModuleTests.allParity, AlgebraModuleTests.allParity
        )
        #expect(result == nil)
    }
}
