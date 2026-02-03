// Algebra.Ring+Convenience.swift

import Algebra_Group_Primitives

extension Algebra.Ring {
    /// Additive identity (zero element).
    @inlinable
    public var zero: Element { additive.identity }

    /// Multiplicative identity (one element).
    @inlinable
    public var one: Element { multiplicative.identity }

    /// Ring addition.
    @inlinable
    public func adding(_ lhs: Element, _ rhs: Element) -> Element {
        additive.combining(lhs, rhs)
    }

    /// Additive inverse (negation).
    @inlinable
    public func negating(_ element: Element) -> Element {
        additive.inverting(element)
    }

    /// Ring multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        multiplicative.combining(lhs, rhs)
    }

    /// Ring subtraction.
    @inlinable
    public func subtracting(_ lhs: Element, _ rhs: Element) -> Element {
        additive.combining(lhs, additive.inverting(rhs))
    }
}

extension Algebra.Ring.Commutative {
    /// Additive identity (zero element).
    @inlinable
    public var zero: Element { ring.zero }

    /// Multiplicative identity (one element).
    @inlinable
    public var one: Element { ring.one }

    /// Ring addition.
    @inlinable
    public func adding(_ lhs: Element, _ rhs: Element) -> Element {
        ring.adding(lhs, rhs)
    }

    /// Additive inverse (negation).
    @inlinable
    public func negating(_ element: Element) -> Element {
        ring.negating(element)
    }

    /// Commutative ring multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        ring.multiplying(lhs, rhs)
    }

    /// Ring subtraction.
    @inlinable
    public func subtracting(_ lhs: Element, _ rhs: Element) -> Element {
        ring.subtracting(lhs, rhs)
    }
}
