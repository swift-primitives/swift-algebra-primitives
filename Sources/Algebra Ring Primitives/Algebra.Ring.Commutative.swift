// Algebra.Ring.Commutative.swift

import Algebra_Group_Primitives

/// Witness for a commutative ring: a ring where multiplication is commutative.
///
/// A commutative ring additionally satisfies a · b = b · a for all a, b ∈ R.
/// Commutativity of multiplication is a documented invariant.
extension Algebra.Ring {
    /// A ring whose multiplication is additionally commutative.
    @frozen
    public struct Commutative {
        /// The underlying ring.
        public var ring: Algebra.Ring<Element>

        /// Creates a commutative ring by asserting multiplicative commutativity of the given ring.
        @inlinable
        public init(ring: Algebra.Ring<Element>) {
            self.ring = ring
        }
    }
}

// MARK: - Sendable

extension Algebra.Ring.Commutative: Sendable where Element: Sendable {}
