// Algebra.Group.Abelian+Group.swift

import Algebra_Monoid_Primitives

extension Algebra.Group.Abelian {
    /// The identity element.
    @inlinable
    public var identity: Element { group.identity }

    /// The commutative binary operation.
    @inlinable
    public var combining: @Sendable (Element, Element) -> Element { group.combining }

    /// The inverse operation.
    @inlinable
    public var inverting: @Sendable (Element) -> Element { group.inverting }

    /// Projects to a monoid by forgetting inverse and commutativity.
    @inlinable
    public var monoid: Algebra.Monoid<Element> { group.monoid }

    /// Projects to a commutative monoid.
    @inlinable
    public var commutative: Algebra.Monoid<Element>.Commutative {
        .init(monoid: group.monoid)
    }
}
