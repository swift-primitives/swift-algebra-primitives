// Algebra.Monoid.Commutative+Monoid.swift

import Algebra_Magma_Primitives

extension Algebra.Monoid.Commutative {
    /// The identity element.
    @inlinable
    public var identity: Element { monoid.identity }

    /// The commutative binary operation.
    @inlinable
    public var combining: @Sendable (Element, Element) -> Element { monoid.combining }
}
