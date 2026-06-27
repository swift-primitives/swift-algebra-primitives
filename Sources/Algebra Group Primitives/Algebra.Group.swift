// Algebra.Group.swift

import Algebra_Monoid_Primitives

/// Witness for a group: a monoid where every element has an inverse.
///
/// A group (G, ∗, e, ⁻¹) is a monoid where for every a ∈ G there exists
/// a⁻¹ ∈ G such that a ∗ a⁻¹ = a⁻¹ ∗ a = e.
///
/// ## Example
///
/// ```swift
/// // The integers under addition form a group.
/// let additive = Algebra.Group<Int>(
///     identity: 0,
///     combining: (+),
///     inverting: { -$0 }
/// )
/// additive.combining(3, additive.inverting(3)) // 0
/// ```
extension Algebra {
    /// A monoid in which every element has a two-sided inverse.
    @frozen
    public struct Group<Element> {
        /// The identity element.
        public var identity: Element

        /// The associative binary operation.
        public var combining: (Element, Element) -> Element

        /// The inverse operation: combining(a, inverting(a)) = identity.
        public var inverting: (Element) -> Element

        /// Creates a group from its identity, associative binary operation, and inverse operation.
        @inlinable
        public init(
            identity: Element,
            combining: @escaping (Element, Element) -> Element,
            inverting: @escaping (Element) -> Element
        ) {
            self.identity = identity
            self.combining = combining
            self.inverting = inverting
        }

        /// Applies the associative binary operation.
        @inlinable
        public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
            combining(lhs, rhs)
        }
    }
}

// MARK: - Sendable

// SAFETY: Category D (SP-4, [MEM-SAFE-024]) — the stored operation closures are
// SAFETY: plain (non-@Sendable) functions under the region-isolation policy, which
// SAFETY: blocks Sendable synthesis; the witness wraps pure operations, so sharing
// SAFETY: is safe. The conditional bound keeps the conformance non-unconditional ([MEM-SEND-001]).
extension Algebra.Group: @unchecked Sendable where Element: Sendable {}
