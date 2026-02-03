// Algebra.Field+Ring.swift

import Algebra_Ring_Primitives

extension Algebra.Field {
    /// Projects to a commutative ring by forgetting multiplicative inverses.
    @inlinable
    public var ring: Algebra.Ring<Element>.Commutative { .init(self) }
}

extension Algebra.Ring.Commutative {
    public init(
        _ field: Algebra.Field<Element>
    ){
        self = .init(
            ring: .init(
                additive: field.additive,
                multiplicative: field.multiplicative.monoid
            )
        )
    }
}
