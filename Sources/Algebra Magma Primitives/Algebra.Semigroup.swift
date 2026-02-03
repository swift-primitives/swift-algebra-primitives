// Algebra.Semigroup.swift

import Algebra_Primitives_Core
public import Witness_Primitives

/// Witness for a semigroup: an associative magma.
///
/// A semigroup (S, ∗) is a magma where the operation is associative:
/// (a ∗ b) ∗ c = a ∗ (b ∗ c) for all a, b, c ∈ S.
///
/// Associativity is a documented invariant, not enforced at compile time.
///
/// ## Example
///
/// ```swift
/// let semigroup = Algebra.Semigroup<String>(combining: { $0 + $1 })
/// semigroup.combining("a", semigroup.combining("b", "c"))
/// // == semigroup.combining(semigroup.combining("a", "b"), "c")
/// ```
extension Algebra {
    @frozen
    public struct Semigroup<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// The associative binary operation.
        public var combining: @Sendable (Element, Element) -> Element

        @inlinable
        public init(
            combining: @escaping @Sendable (Element, Element) -> Element
        ) {
            self.combining = combining
        }

        /// Applies the associative binary operation.
        @inlinable
        public func callAsFunction(_ lhs: Element, _ rhs: Element) -> Element {
            combining(lhs, rhs)
        }
    }
}
