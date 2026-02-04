// Algebra.Semiring.Commutative+Convenience.swift

import Algebra_Monoid_Primitives

extension Algebra.Semiring.Commutative {
    /// The additive commutative monoid.
    @inlinable
    public var additive: Algebra.Monoid<Element>.Commutative { semiring.additive }

    /// The multiplicative monoid.
    @inlinable
    public var multiplicative: Algebra.Monoid<Element> { semiring.multiplicative }
}
