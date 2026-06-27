// Algebra.Semiring+Monoid.swift

import Algebra_Monoid_Primitives

extension Algebra.Monoid.Commutative {
    /// Creates a commutative monoid from a semiring's additive structure.
    @inlinable
    public init(_ semiring: Algebra.Semiring<Element>) {
        self = semiring.additive
    }
}
