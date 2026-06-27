// Algebra.Monoid.swift

import Algebra_Semigroup_Primitives

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
    /// A semigroup equipped with a two-sided identity element.
    @frozen
    public struct Monoid<Element> {
        /// The identity element: combining(identity, a) = combining(a, identity) = a.
        public var identity: Element

        /// The associative binary operation.
        public var combining: (Element, Element) -> Element

        /// Creates a monoid from its identity element and associative binary operation.
        @inlinable
        public init(
            identity: Element,
            combining: @escaping (Element, Element) -> Element
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

// MARK: - Sendable

// SAFETY: Category D (SP-4, [MEM-SAFE-024]) — the stored operation closure is a
// SAFETY: plain (non-@Sendable) function under the region-isolation policy, which
// SAFETY: blocks Sendable synthesis; the witness wraps a pure operation, so sharing
// SAFETY: is safe. The conditional bound keeps the conformance non-unconditional ([MEM-SEND-001]).
extension Algebra.Monoid: @unchecked Sendable where Element: Sendable {}
