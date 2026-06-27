// Algebra.Magma.swift

import Algebra_Primitive

/// Witness for a magma: a set equipped with a binary operation.
///
/// A magma (S, ∗) consists of a set S and a single binary operation
/// ∗ : S × S → S. No algebraic laws are required.
///
/// ## Example
///
/// ```swift
/// let magma = Algebra.Magma<Int>(combining: { $0 &+ $1 })
/// magma.combining(3, 4) // 7
/// ```
extension Algebra {
    /// A set equipped with a single binary operation, with no required laws.
    @frozen
    public struct Magma<Element> {
        /// The binary operation.
        public var combining: (Element, Element) -> Element

        /// Creates a magma from its binary operation.
        @inlinable
        public init(
            combining: @escaping (Element, Element) -> Element
        ) {
            self.combining = combining
        }

        /// Applies the binary operation.
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
extension Algebra.Magma: @unchecked Sendable where Element: Sendable {}
