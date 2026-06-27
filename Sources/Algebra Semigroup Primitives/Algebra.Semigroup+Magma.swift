// Algebra.Semigroup+Magma.swift

import Algebra_Magma_Primitives

extension Algebra.Magma {
    /// Creates a magma from a semigroup by forgetting associativity.
    @inlinable
    public init(_ semigroup: Algebra.Semigroup<Element>) {
        self.init(combining: semigroup.combining)
    }
}

extension Algebra.Semigroup {
    /// Projects to a magma by forgetting associativity.
    @inlinable
    public var magma: Algebra.Magma<Element> { .init(self) }
}
