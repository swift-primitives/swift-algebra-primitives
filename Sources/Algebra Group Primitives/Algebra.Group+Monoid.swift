// Algebra.Group+Monoid.swift

import Algebra_Monoid_Primitives

extension Algebra.Monoid {
    /// Creates a monoid from a group by forgetting the inverse operation.
    @inlinable
    public init(_ group: Algebra.Group<Element>) {
        self.init(identity: group.identity, combining: group.combining)
    }
}

extension Algebra.Semigroup {
    /// Creates a semigroup from a group by forgetting identity and inverse.
    @inlinable
    public init(_ group: Algebra.Group<Element>) {
        self.init(combining: group.combining)
    }
}

extension Algebra.Magma {
    /// Creates a magma from a group by forgetting all structure.
    @inlinable
    public init(_ group: Algebra.Group<Element>) {
        self.init(combining: group.combining)
    }
}

extension Algebra.Group {
    /// Projects to a monoid by forgetting the inverse operation.
    @inlinable
    public var monoid: Algebra.Monoid<Element> { .init(self) }

    /// Projects to a semigroup.
    @inlinable
    public var semigroup: Algebra.Semigroup<Element> { .init(self) }

    /// Projects to a magma.
    @inlinable
    public var magma: Algebra.Magma<Element> { .init(self) }
}
