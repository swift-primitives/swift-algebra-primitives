// Algebra.Monoid+Semigroup.swift

import Algebra_Magma_Primitives

extension Algebra.Monoid {
    /// Projects to a semigroup by forgetting the identity element.
    @inlinable
    public var semigroup: Algebra.Semigroup<Element> {
        .init(combining: combining)
    }

    /// Projects to a magma by forgetting identity and associativity.
    @inlinable
    public var magma: Algebra.Magma<Element> {
        .init(combining: combining)
    }
}
