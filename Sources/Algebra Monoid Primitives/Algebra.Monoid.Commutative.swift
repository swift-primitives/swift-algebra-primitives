// Algebra.Monoid.Commutative.swift

import Algebra_Semigroup_Primitives

/// Witness for a commutative monoid: a monoid where the operation is commutative.
///
/// A commutative monoid additionally satisfies a ∗ b = b ∗ a for all a, b ∈ S.
/// Commutativity is a documented invariant, not enforced at compile time.
extension Algebra.Monoid {
    /// A monoid whose binary operation is additionally commutative.
    @frozen
    public struct Commutative {
        /// The underlying monoid.
        public var monoid: Algebra.Monoid<Element>

        /// Creates a commutative monoid by asserting commutativity of the given monoid.
        @inlinable
        public init(monoid: Algebra.Monoid<Element>) {
            self.monoid = monoid
        }
    }
}

// MARK: - Sendable

extension Algebra.Monoid.Commutative: Sendable where Element: Sendable {}

extension Algebra.Monoid.Commutative {
    /// The identity element.
    @inlinable
    public var identity: Element { monoid.identity }

    /// The commutative binary operation.
    @inlinable
    public var combining: (Element, Element) -> Element { monoid.combining }

    /// Applies the commutative binary operation.
    @inlinable
    public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
        combining(lhs, rhs)
    }
}
