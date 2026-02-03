// Algebra.Ring.swift

import Algebra_Group_Primitives
public import Witness_Primitives

/// Witness for a ring: an additive abelian group with a multiplicative monoid.
///
/// A ring (R, +, ·) satisfies:
/// - (R, +) is an abelian group (additive structure)
/// - (R, ·) is a monoid (multiplicative structure)
/// - Multiplication distributes over addition:
///   a · (b + c) = a·b + a·c and (a + b) · c = a·c + b·c
///
/// Distributivity is a documented invariant, not enforced at compile time.
///
/// ## Example
///
/// ```swift
/// let ring = Algebra.Ring<Int>(
///     additive: .init(group: .init(
///         identity: 0, combining: { $0 &+ $1 }, inverting: { 0 &- $0 }
///     )),
///     multiplicative: .init(identity: 1, combining: { $0 &* $1 })
/// )
/// ```
extension Algebra {
    @frozen
    public struct Ring<Element: Sendable>: Sendable, Witness.`Protocol` {
        /// Additive structure: must be an abelian group.
        public var additive: Algebra.Group<Element>.Abelian

        /// Multiplicative structure: must be a monoid.
        public var multiplicative: Algebra.Monoid<Element>

        @inlinable
        public init(
            additive: Algebra.Group<Element>.Abelian,
            multiplicative: Algebra.Monoid<Element>
        ) {
            self.additive = additive
            self.multiplicative = multiplicative
        }
    }
}
