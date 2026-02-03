// Algebra.Group.Abelian+Group.swift

import Algebra_Monoid_Primitives

extension Algebra.Monoid {
    /// Creates a monoid from an abelian group by forgetting inverse and commutativity.
    @inlinable
    public init(_ abelian: Algebra.Group<Element>.Abelian) {
        self.init(identity: abelian.group.identity, combining: abelian.group.combining)
    }
}

extension Algebra.Monoid.Commutative {
    /// Creates a commutative monoid from an abelian group by forgetting inverses.
    @inlinable
    public init(_ abelian: Algebra.Group<Element>.Abelian) {
        self.init(monoid: .init(abelian))
    }
}

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
    public var monoid: Algebra.Monoid<Element> { .init(self) }

    /// Projects to a commutative monoid.
    @inlinable
    public var commutative: Algebra.Monoid<Element>.Commutative { .init(self) }
}
