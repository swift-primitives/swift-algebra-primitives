// Algebra.Monoid.swift

import Algebra_Magma_Primitives
public import Witness_Primitives

/// Witness for a monoid: a semigroup with an identity element.
///
/// A monoid (S, ∗, e) is a set S with an associative binary operation ∗
/// and an identity element e such that e ∗ a = a ∗ e = a for all a ∈ S.
///
/// ## Example
///
/// ```swift
/// let monoid = Algebra.Monoid<Int>(identity: 0, combining: { $0 &+ $1 })
/// monoid.combining(monoid.identity, 42) // 42
/// ```
extension Algebra {
    @frozen
    public struct Monoid<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// The identity element: combining(identity, a) = combining(a, identity) = a.
        public var identity: Element

        /// The associative binary operation.
        public var combining: @Sendable (Element, Element) -> Element

        @inlinable
        public init(
            identity: Element,
            combining: @escaping @Sendable (Element, Element) -> Element
        ) {
            self.identity = identity
            self.combining = combining
        }

        /// Applies the associative binary operation.
        @inlinable
        public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
            combining(lhs, rhs)
        }
    }
}
