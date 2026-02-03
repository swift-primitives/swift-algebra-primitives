// Algebra.Ring+Group.swift

import Algebra_Group_Primitives

extension Algebra.Ring {
    /// The additive abelian group.
    @inlinable
    public var additiveGroup: Algebra.Group<Element>.Abelian { additive }

    /// The multiplicative monoid.
    @inlinable
    public var multiplicativeMonoid: Algebra.Monoid<Element> { multiplicative }
}

extension Algebra.Ring.Commutative {
    /// The additive abelian group.
    @inlinable
    public var additiveGroup: Algebra.Group<Element>.Abelian { ring.additive }

    /// The multiplicative commutative monoid.
    @inlinable
    public var multiplicativeMonoid: Algebra.Monoid<Element>.Commutative {
        .init(monoid: ring.multiplicative)
    }
}
