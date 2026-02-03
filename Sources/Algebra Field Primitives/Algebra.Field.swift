// Algebra.Field.swift

import Algebra_Ring_Primitives
public import Witness_Primitives

/// Witness for a field: additive and multiplicative abelian groups with distributivity.
///
/// A field (F, +, ·) satisfies:
/// - (F, +) is an abelian group with identity 0
/// - (F \ {0}, ·) is an abelian group with identity 1
/// - Multiplication distributes over addition
///
/// The multiplicative group operates on nonzero elements only.
/// Distributivity is a documented invariant, not enforced at compile time.
///
/// ## Example
///
/// ```swift
/// // Z₂ field: addition is XOR, multiplication is AND
/// let z2 = Algebra.Field<Bit>.z2
/// z2.additive.combining(.one, .one)       // .zero
/// z2.multiplicative.combining(.one, .one) // .one
/// ```
extension Algebra {
    @frozen
    public struct Field<Element: Sendable>: Sendable, Witness.Protocol {
        /// Additive structure: abelian group with identity (zero).
        public var additive: Algebra.Group<Element>.Abelian

        /// Multiplicative structure: abelian group on nonzero elements with identity (one).
        public var multiplicative: Algebra.Group<Element>.Abelian

        @inlinable
        public init(
            additive: Algebra.Group<Element>.Abelian,
            multiplicative: Algebra.Group<Element>.Abelian
        ) {
            self.additive = additive
            self.multiplicative = multiplicative
        }
    }
}
