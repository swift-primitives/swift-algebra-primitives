// Algebra.Field.swift

import Algebra_Ring_Primitives
public import Witness_Primitives

/// Witness for a field: additive abelian group, multiplicative commutative
/// monoid, and partial reciprocal.
///
/// A field (F, +, ·) satisfies:
/// - (F, +) is an abelian group with identity 0
/// - (F, ·) is a commutative monoid with identity 1
/// - Every nonzero element has a multiplicative inverse (reciprocal)
/// - Multiplication distributes over addition
///
/// The multiplicative structure is stored as a commutative monoid on all
/// elements. The reciprocal operation throws for non-invertible elements
/// (typically zero), making the domain restriction explicit in the type.
///
/// Distributivity is a documented invariant, not enforced at compile time.
///
/// ## Example
///
/// ```swift
/// let z2 = Algebra.Field<Parity>.z2
/// z2.adding(.odd, .odd)           // .even
/// z2.multiplying(.odd, .odd)      // .odd
/// try z2.reciprocal(.odd)         // .odd
/// try z2.reciprocal(.even)        // throws .nonInvertible
/// ```
extension Algebra {
    @frozen
    public struct Field<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// Additive structure: abelian group with identity (zero).
        public var additive: Algebra.Group<Element>.Abelian

        /// Multiplicative structure: commutative monoid on all elements.
        public var multiplicative: Algebra.Monoid<Element>.Commutative

        /// Multiplicative inverse, throwing for non-invertible elements.
        public var reciprocal: @Sendable (Element) throws(Error) -> Element

        @inlinable
        public init(
            additive: Algebra.Group<Element>.Abelian,
            multiplicative: Algebra.Monoid<Element>.Commutative,
            reciprocal: @escaping @Sendable (Element) throws(Error) -> Element
        ) {
            self.additive = additive
            self.multiplicative = multiplicative
            self.reciprocal = reciprocal
        }
    }
}

extension Algebra.Field {
    /// Errors from field operations with domain restrictions.
    public enum Error: Swift.Error, Sendable {
        /// The element has no multiplicative inverse (e.g., zero in a field).
        case nonInvertible
    }
}
