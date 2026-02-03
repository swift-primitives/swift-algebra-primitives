// Algebra.Magma.swift

import Algebra_Primitives_Core
public import Witness_Primitives

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
    @frozen
    public struct Magma<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// The binary operation.
        public var combining: @Sendable (Element, Element) -> Element

        @inlinable
        public init(
            combining: @escaping @Sendable (Element, Element) -> Element
        ) {
            self.combining = combining
        }
    }
}
