// Algebra.Semiring.swift

import Algebra_Monoid_Primitives
public import Witness_Primitives

/// Witness for a semiring: an additive commutative monoid with a multiplicative monoid.
///
/// A semiring (S, +, ·) satisfies:
/// - (S, +) is a commutative monoid with identity 0
/// - (S, ·) is a monoid with identity 1
/// - Multiplication distributes over addition:
///   a · (b + c) = a·b + a·c and (a + b) · c = a·c + b·c
/// - Zero annihilates: 0 · a = a · 0 = 0
///
/// Distributivity and annihilation are documented invariants, not enforced
/// at compile time.
extension Algebra {
    @frozen
    public struct Semiring<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// Additive structure: must be a commutative monoid.
        public var additive: Algebra.Monoid<Element>.Commutative

        /// Multiplicative structure: must be a monoid.
        public var multiplicative: Algebra.Monoid<Element>

        @inlinable
        public init(
            additive: Algebra.Monoid<Element>.Commutative,
            multiplicative: Algebra.Monoid<Element>
        ) {
            self.additive = additive
            self.multiplicative = multiplicative
        }
    }
}
