// Algebra.Semiring+Bool.swift

/// Boolean OR/AND semiring.
///
/// Bool forms a commutative semiring under:
/// - Addition: OR (disjunction), identity: false
/// - Multiplication: AND (conjunction), identity: true
/// - Distributivity: a AND (b OR c) = (a AND b) OR (a AND c)
/// - Zero annihilation: false AND a = false
extension Algebra.Semiring where Element == Bool {
    /// The Boolean OR/AND semiring.
    @inlinable
    public static var boolean: Algebra.Semiring<Bool>.Commutative {
        .init(semiring: .init(
            additive: .init(monoid: .init(identity: false, combining: { $0 || $1 })),
            multiplicative: .init(identity: true, combining: { $0 && $1 })
        ))
    }
}
