// Algebra.Semilattice+Comparable.swift

/// Min/max semilattices over a `Comparable` element with explicit
/// identity (the lower bound for `max`, the upper bound for `min`).
///
/// `min` and `max` are both associative, commutative, and idempotent —
/// `min(a, a) == a` and `max(a, a) == a` — and form bounded semilattices
/// when paired with the bottom element of the type.
extension Algebra.Semilattice where Element: Comparable {
    /// Max semilattice whose combining operation is `Swift.max`.
    ///
    /// Identity must be a lower bound for the type's value range
    /// (e.g., `Int.min` for `Int`).
    @inlinable
    public static func maximum(bottom: Element) -> Self {
        .init(identity: bottom, combining: { Swift.max($0, $1) })
    }

    /// Min semilattice whose combining operation is `Swift.min`.
    ///
    /// Identity must be an upper bound for the type's value range
    /// (e.g., `Int.max` for `Int`). This is the *dual* of the max
    /// semilattice — bottom and top swap relative to the natural numeric order.
    @inlinable
    public static func minimum(top: Element) -> Self {
        .init(identity: top, combining: { Swift.min($0, $1) })
    }
}
