// Algebra.Group.Abelian.swift

import Algebra_Monoid_Primitives

/// Witness for an abelian (commutative) group.
///
/// An abelian group is a group where the operation is commutative:
/// a ∗ b = b ∗ a for all a, b ∈ G. Commutativity is a documented
/// invariant, not enforced at compile time.
///
/// Used as the additive component of rings and fields, where
/// commutativity of addition is required by definition.
extension Algebra.Group {
    /// A group whose binary operation is additionally commutative.
    @frozen
    public struct Abelian {
        /// The underlying group.
        public var group: Algebra.Group<Element>

        /// Creates an abelian group by asserting commutativity of the given group.
        @inlinable
        public init(group: Algebra.Group<Element>) {
            self.group = group
        }
    }
}

// MARK: - Sendable

extension Algebra.Group.Abelian: Sendable where Element: Sendable {}
