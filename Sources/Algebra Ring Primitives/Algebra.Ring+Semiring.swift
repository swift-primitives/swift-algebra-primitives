// Algebra.Ring+Semiring.swift

import Algebra_Semiring_Primitives

extension Algebra.Ring {
    /// Projects to a semiring by forgetting the additive inverse.
    @inlinable
    public var semiring: Algebra.Semiring<Element> {
        .init(
            additive: additive.commutative,
            multiplicative: multiplicative
        )
    }
}

extension Algebra.Ring.Commutative {
    /// Projects to a commutative semiring by forgetting the additive inverse.
    @inlinable
    public var semiring: Algebra.Semiring<Element>.Commutative {
        .init(semiring: ring.semiring)
    }
}

extension Algebra.Semiring {
    /// Creates a semiring from a ring by forgetting additive inverses.
    @inlinable
    public init(_ ring: Algebra.Ring<Element>) {
        self = ring.semiring
    }
}

extension Algebra.Semiring.Commutative {
    /// Creates a commutative semiring from a commutative ring.
    @inlinable
    public init(_ commutativeRing: Algebra.Ring<Element>.Commutative) {
        self = commutativeRing.semiring
    }
}
