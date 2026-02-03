// Algebra.Ring.Commutative.swift

import Algebra_Group_Primitives
public import Witness_Primitives

/// Witness for a commutative ring: a ring where multiplication is commutative.
///
/// A commutative ring additionally satisfies a · b = b · a for all a, b ∈ R.
/// Commutativity of multiplication is a documented invariant.
extension Algebra.Ring {
    @frozen
    public struct Commutative: Sendable, Witness.Protocol where Element: Sendable {
        /// The underlying ring.
        public var ring: Algebra.Ring<Element>

        @inlinable
        public init(ring: Algebra.Ring<Element>) {
            self.ring = ring
        }
    }
}
