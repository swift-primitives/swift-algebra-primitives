// Algebra.Field+Ring.swift

import Algebra_Ring_Primitives

extension Algebra.Field {
    /// Projects to a commutative ring by forgetting reciprocal.
    @inlinable
    public var ring: Algebra.Ring<Element>.Commutative {
        .init(
            ring: .init(
                additive: additive,
                multiplicative: multiplicative.monoid
            )
        )
    }
}

extension Algebra.Ring.Commutative {
    /// Creates the commutative ring underlying a field by forgetting its reciprocal.
    public init(
        _ field: Algebra.Field<Element>
    ) {
        self = .init(
            ring: .init(
                additive: field.additive,
                multiplicative: field.multiplicative.monoid
            )
        )
    }
}
