// Algebra.Semiring.Commutative.swift

import Algebra_Monoid_Primitives
public import Witness_Primitives

/// Witness for a commutative semiring: a semiring where multiplication is commutative.
///
/// A commutative semiring additionally satisfies a · b = b · a for all a, b ∈ S.
/// Commutativity of multiplication is a documented invariant.
extension Algebra.Semiring {
    @frozen
    public struct Commutative: Sendable, Witness.`Protocol` where Element: Sendable {
        /// The underlying semiring.
        public var semiring: Algebra.Semiring<Element>

        @inlinable
        public init(semiring: Algebra.Semiring<Element>) {
            self.semiring = semiring
        }
    }
}
