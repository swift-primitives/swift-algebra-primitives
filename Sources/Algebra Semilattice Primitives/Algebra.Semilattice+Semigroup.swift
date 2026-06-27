// Algebra.Semilattice+Semigroup.swift

import Algebra_Semigroup_Primitives

extension Algebra.Semigroup {
    /// Creates a semigroup from a semilattice by forgetting commutativity,
    /// idempotency, and the identity element.
    @inlinable
    public init(_ semilattice: Algebra.Semilattice<Element>) {
        self.init(combining: semilattice.combining)
    }
}

extension Algebra.Semilattice {
    /// Projects to a semigroup by forgetting commutativity, idempotency,
    /// and the identity element.
    @inlinable
    public var semigroup: Algebra.Semigroup<Element> { .init(self) }
}
