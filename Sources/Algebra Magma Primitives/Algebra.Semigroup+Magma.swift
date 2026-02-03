// Algebra.Semigroup+Magma.swift

import Algebra_Primitives_Core

extension Algebra.Semigroup {
    /// Projects to a magma by forgetting associativity.
    @inlinable
    public var magma: Algebra.Magma<Element> {
        .init(combining: combining)
    }
}
