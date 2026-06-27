// Algebra.Ring.Commutative+Convenience.swift

import Algebra_Group_Primitives

extension Algebra.Ring.Commutative {
    /// The additive abelian group.
    @inlinable
    public var additive: Algebra.Group<Element>.Abelian { ring.additive }

    /// The multiplicative monoid.
    @inlinable
    public var multiplicative: Algebra.Monoid<Element> { ring.multiplicative }
}
