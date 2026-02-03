// Algebra.Monoid+Bool.swift

/// Boolean monoid witnesses.
///
/// Bool forms monoids under both conjunction and disjunction.
extension Algebra.Monoid where Element == Bool {
    /// AND monoid: identity is true, combining is conjunction.
    @inlinable
    public static var conjunction: Self {
        .init(identity: true, combining: { $0 && $1 })
    }

    /// OR monoid: identity is false, combining is disjunction.
    @inlinable
    public static var disjunction: Self {
        .init(identity: false, combining: { $0 || $1 })
    }
}
