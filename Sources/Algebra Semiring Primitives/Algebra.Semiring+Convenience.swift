// Algebra.Semiring+Convenience.swift

import Algebra_Monoid_Primitives

extension Algebra.Semiring {
    /// Additive identity (zero element).
    @inlinable
    public var zero: Element { additive.identity }

    /// Multiplicative identity (one element).
    @inlinable
    public var one: Element { multiplicative.identity }

    /// Semiring addition.
    @inlinable
    public func adding(_ lhs: Element, _ rhs: Element) -> Element {
        additive.combining(lhs, rhs)
    }

    /// Semiring multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        multiplicative.combining(lhs, rhs)
    }
}

extension Algebra.Semiring.Commutative {
    /// Additive identity (zero element).
    @inlinable
    public var zero: Element { semiring.zero }

    /// Multiplicative identity (one element).
    @inlinable
    public var one: Element { semiring.one }

    /// Semiring addition.
    @inlinable
    public func adding(_ lhs: Element, _ rhs: Element) -> Element {
        semiring.adding(lhs, rhs)
    }

    /// Commutative semiring multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        semiring.multiplying(lhs, rhs)
    }
}
