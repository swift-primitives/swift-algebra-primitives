// Algebra.Lattice+Comparable.swift

import Algebra_Semilattice_Primitives

/// The min/max lattice over a `Comparable` element: join = `max`, meet = `min`.
///
/// Any totally ordered set (a *chain*) forms a bounded lattice where the join
/// of two elements is their maximum and the meet is their minimum. A chain is
/// automatically **distributive**, so this is also the lattice underlying a
/// `Comparable` Boolean algebra when the type additionally has complements.
extension Algebra.Lattice where Element: Comparable {
    /// The min/max (chain) lattice: join = `Swift.max`, meet = `Swift.min`.
    ///
    /// `bottom` must be a lower bound and `top` an upper bound for the type's
    /// value range (e.g. `Int.min` / `Int.max` for `Int`).
    @inlinable
    public static func minMax(bottom: Element, top: Element) -> Self {
        .init(
            join: .maximum(bottom: bottom),
            meet: .minimum(top: top)
        )
    }
}
