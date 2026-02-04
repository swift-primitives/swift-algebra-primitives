// Algebra.Monoid.Commutative.swift

import Algebra_Magma_Primitives
public import Witness_Primitives

/// Witness for a commutative monoid: a monoid where the operation is commutative.
///
/// A commutative monoid additionally satisfies a ∗ b = b ∗ a for all a, b ∈ S.
/// Commutativity is a documented invariant, not enforced at compile time.
extension Algebra.Monoid {
    @frozen
    public struct Commutative: Sendable, Witness.`Protocol` where Element: Sendable {
        /// The underlying monoid.
        public var monoid: Algebra.Monoid<Element>

        @inlinable
        public init(monoid: Algebra.Monoid<Element>) {
            self.monoid = monoid
        }
    }
}

extension Algebra.Monoid.Commutative {
    /// The identity element.
    @inlinable
    public var identity: Element { monoid.identity }

    /// The commutative binary operation.
    @inlinable
    public var combining: @Sendable (Element, Element) -> Element { monoid.combining }

    /// Applies the commutative binary operation.
    @inlinable
    public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
        combining(lhs, rhs)
    }
}
