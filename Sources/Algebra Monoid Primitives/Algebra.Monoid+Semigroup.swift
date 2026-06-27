// Algebra.Monoid+Semigroup.swift

import Algebra_Semigroup_Primitives

extension Algebra.Semigroup {
    /// Creates a semigroup from a monoid by forgetting the identity element.
    @inlinable
    public init(_ monoid: Algebra.Monoid<Element>) {
        self.init(combining: monoid.combining)
    }
}

extension Algebra.Magma {
    /// Creates a magma from a monoid by forgetting identity and associativity.
    @inlinable
    public init(_ monoid: Algebra.Monoid<Element>) {
        self.init(combining: monoid.combining)
    }
}

extension Algebra.Monoid {
    /// Projects to a semigroup by forgetting the identity element.
    @inlinable
    public var semigroup: Algebra.Semigroup<Element> { .init(self) }

    /// Projects to a magma by forgetting identity and associativity.
    @inlinable
    public var magma: Algebra.Magma<Element> { .init(self) }
}
