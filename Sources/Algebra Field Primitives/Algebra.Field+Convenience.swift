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

    /// Field subtraction.
    @inlinable
    public func subtracting(_ lhs: Element, _ rhs: Element) -> Element {
        additive.combining(lhs, additive.inverting(rhs))
    }

    /// Field multiplication.
    @inlinable
    public func multiplying(_ lhs: Element, _ rhs: Element) -> Element {
        multiplicative.combining(lhs, rhs)
    }

    /// Field division.
    ///
    /// - Throws: `Error.nonInvertible` if `rhs` has no multiplicative inverse.
    @inlinable
    public func dividing(_ lhs: Element, _ rhs: Element) throws(Algebra.Field<Element>.Error) -> Element {
        multiplying(lhs, try reciprocal(rhs))
    }

    /// Constructs a unit from an element proven invertible.
    ///
    /// - Throws: `Error.nonInvertible` if the element has no multiplicative inverse.
    @inlinable
    public func unit(_ element: Element) throws(Algebra.Field<Element>.Error) -> Unit {
        let inv = try reciprocal(element)
        return Unit(element: element, inverse: inv)
    }

    /// The multiplicative group of units (invertible elements).
    ///
    /// All operations are total. Unit values carry precomputed inverses,
    /// so no calls to `reciprocal` occur inside group operations.
    @inlinable
    public var unit: Algebra.Group<Unit>.Abelian {
        let combine = multiplicative.combining
        return .init(
            group: .init(
                identity: Unit(element: multiplicative.identity, inverse: multiplicative.identity),
                combining: { lhs, rhs in
                    Unit(
                        element: combine(lhs.element, rhs.element),
                        inverse: combine(lhs.inverse, rhs.inverse)
                    )
                },
                inverting: { u in
                    Unit(element: u.inverse, inverse: u.element)
                }
            )
        )
    }
}
