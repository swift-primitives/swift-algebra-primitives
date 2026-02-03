// Algebra.Group.Abelian.swift

import Algebra_Monoid_Primitives
public import Witness_Primitives

/// Witness for an abelian (commutative) group.
///
/// An abelian group is a group where the operation is commutative:
/// a ∗ b = b ∗ a for all a, b ∈ G. Commutativity is a documented
/// invariant, not enforced at compile time.
///
/// Used as the additive component of rings and fields, where
/// commutativity of addition is required by definition.
extension Algebra.Group {
    @frozen
    public struct Abelian: Sendable, Witness.`Protocol` where Element: Sendable {
        /// The underlying group.
        public var group: Algebra.Group<Element>

        @inlinable
        public init(group: Algebra.Group<Element>) {
            self.group = group
        }
    }
}
