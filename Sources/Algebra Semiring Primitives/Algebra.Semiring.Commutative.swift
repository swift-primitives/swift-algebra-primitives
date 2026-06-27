// Algebra.Semiring.Commutative.swift

import Algebra_Monoid_Primitives

/// Witness for a commutative semiring: a semiring where multiplication is commutative.
///
/// A commutative semiring additionally satisfies a · b = b · a for all a, b ∈ S.
/// Commutativity of multiplication is a documented invariant.
extension Algebra.Semiring {
    /// A semiring whose multiplication is additionally commutative.
    @frozen
    public struct Commutative {
        /// The underlying semiring.
        public var semiring: Algebra.Semiring<Element>

        /// Creates a commutative semiring by asserting multiplicative commutativity of the given semiring.
        @inlinable
        public init(semiring: Algebra.Semiring<Element>) {
            self.semiring = semiring
        }
    }
}

// MARK: - Sendable

extension Algebra.Semiring.Commutative: Sendable where Element: Sendable {}
