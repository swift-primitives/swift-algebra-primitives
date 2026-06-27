// Algebra.Semigroup.swift

import Algebra_Primitive

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
    /// A magma whose binary operation is associative.
    @frozen
    public struct Semigroup<Element> {
        /// The associative binary operation.
        public var combining: (Element, Element) -> Element

        /// Creates a semigroup from its associative binary operation.
        @inlinable
        public init(
            combining: @escaping (Element, Element) -> Element
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

// MARK: - Sendable

// SAFETY: Category D (SP-4, [MEM-SAFE-024]) — the stored operation closure is a
// SAFETY: plain (non-@Sendable) function under the region-isolation policy, which
// SAFETY: blocks Sendable synthesis; the witness wraps a pure operation, so sharing
// SAFETY: is safe. The conditional bound keeps the conformance non-unconditional ([MEM-SEND-001]).
extension Algebra.Semigroup: @unchecked Sendable where Element: Sendable {}
