// Algebra.Field+Ring.swift

import Algebra_Ring_Primitives

extension Algebra.Field {
    /// Projects to a commutative ring by forgetting multiplicative inverses.
    @inlinable
    public var ring: Algebra.Ring<Element>.Commutative {
        .init(ring: .init(
            additive: additive,
            multiplicative: multiplicative.monoid
        ))
    }

    /// The additive abelian group.
    @inlinable
    public var additiveGroup: Algebra.Group<Element>.Abelian { additive }

    /// The multiplicative abelian group (on nonzero elements).
    @inlinable
    public var multiplicativeGroup: Algebra.Group<Element>.Abelian { multiplicative }
}
