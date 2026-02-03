// Algebra.Group+Monoid.swift

import Algebra_Monoid_Primitives

extension Algebra.Group {
    /// Projects to a monoid by forgetting the inverse operation.
    @inlinable
    public var monoid: Algebra.Monoid<Element> {
        .init(identity: identity, combining: combining)
    }

    /// Projects to a semigroup.
    @inlinable
    public var semigroup: Algebra.Semigroup<Element> {
        .init(combining: combining)
    }

    /// Projects to a magma.
    @inlinable
    public var magma: Algebra.Magma<Element> {
        .init(combining: combining)
    }
}
