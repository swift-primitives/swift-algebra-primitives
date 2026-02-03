// Algebra.Ring+Group.swift

import Algebra_Group_Primitives

extension Algebra.Monoid.Commutative {
    /// Creates a commutative monoid from a commutative ring's multiplicative structure.
    @inlinable
    public init(_ commutativeRing: Algebra.Ring<Element>.Commutative) {
        self.init(monoid: commutativeRing.ring.multiplicative)
    }
}

extension Algebra.Ring.Commutative {
    /// The multiplicative commutative monoid.
    @inlinable
    public var multiplicativeMonoid: Algebra.Monoid<Element>.Commutative { .init(self) }
}
