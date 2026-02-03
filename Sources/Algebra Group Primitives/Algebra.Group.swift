// Algebra.Group.swift

import Algebra_Monoid_Primitives
public import Witness_Primitives

/// Witness for a group: a monoid where every element has an inverse.
///
/// A group (G, ∗, e, ⁻¹) is a monoid where for every a ∈ G there exists
/// a⁻¹ ∈ G such that a ∗ a⁻¹ = a⁻¹ ∗ a = e.
///
/// ## Example
///
/// ```swift
/// let z2 = Algebra.Group<Parity>(
///     identity: .even,
///     combining: Parity.adding,
///     inverting: { $0 }  // self-inverse in Z₂
/// )
/// z2.combining(.odd, .odd) // .even
/// ```
extension Algebra {
    @frozen
    public struct Group<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// The identity element.
        public var identity: Element

        /// The associative binary operation.
        public var combining: @Sendable (Element, Element) -> Element

        /// The inverse operation: combining(a, inverting(a)) = identity.
        public var inverting: @Sendable (Element) -> Element

        @inlinable
        public init(
            identity: Element,
            combining: @escaping @Sendable (Element, Element) -> Element,
            inverting: @escaping @Sendable (Element) -> Element
        ) {
            self.identity = identity
            self.combining = combining
            self.inverting = inverting
        }
    }
}
