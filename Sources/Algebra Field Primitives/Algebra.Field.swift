// Algebra.Field.swift

import Algebra_Ring_Primitives

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
/// Concrete field witnesses (e.g. the Z₂ field over `Parity`) are provided by
/// integration packages such as `swift-parity-algebra-primitives`; this type is
/// the generic structure they instantiate.
extension Algebra {
    /// An additive abelian group and a multiplicative commutative monoid with a partial reciprocal that inverts every nonzero element.
    @frozen
    public struct Field<Element> {
        /// Additive structure: abelian group with identity (zero).
        public var additive: Algebra.Group<Element>.Abelian

        /// Multiplicative structure: commutative monoid on all elements.
        public var multiplicative: Algebra.Monoid<Element>.Commutative

        /// Multiplicative inverse, throwing for non-invertible elements.
        public var reciprocal: (Element) throws(Algebra.Field<Element>.Error) -> Element

        /// Creates a field from its additive abelian group, multiplicative commutative monoid, and reciprocal.
        @inlinable
        public init(
            additive: Algebra.Group<Element>.Abelian,
            multiplicative: Algebra.Monoid<Element>.Commutative,
            reciprocal: @escaping (Element) throws(Algebra.Field<Element>.Error) -> Element
        ) {
            self.additive = additive
            self.multiplicative = multiplicative
            self.reciprocal = reciprocal
        }
    }
}

// MARK: - Sendable

// SAFETY: Category D (SP-4, [MEM-SAFE-024]) — the stored `reciprocal` closure is a
// SAFETY: plain (non-@Sendable) function under the region-isolation policy, which
// SAFETY: blocks Sendable synthesis; the witness wraps a pure operation, so sharing
// SAFETY: is safe. The conditional bound keeps the conformance non-unconditional ([MEM-SEND-001]).
extension Algebra.Field: @unchecked Sendable where Element: Sendable {}

extension Algebra.Field {
    /// Errors from field operations with domain restrictions.
    public enum Error: Swift.Error, Sendable {
        /// The element has no multiplicative inverse (e.g., zero in a field).
        case nonInvertible
    }
}
