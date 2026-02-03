// Algebra.Field+Convenience.swift

import Algebra_Ring_Primitives

extension Algebra.Field {
    /// Additive identity (zero element).
    @inlinable
    public var zero: Element { additive.identity }

    /// Multiplicative identity (one element).
    @inlinable
    public var one: Element { multiplicative.identity }

    /// Field addition.
    @inlinable
    public func adding(_ lhs: Element, _ rhs: Element) -> Element {
        additive.combining(lhs, rhs)
    }

    /// Additive inverse (negation).
    @inlinable
    public func negating(_ element: Element) -> Element {
        additive.inverting(element)
    }

    /// Field multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        multiplicative.combining(lhs, rhs)
    }

    /// Multiplicative inverse (reciprocal, for nonzero elements).
    @inlinable
    public func reciprocal(_ element: Element) -> Element {
        multiplicative.inverting(element)
    }
}
