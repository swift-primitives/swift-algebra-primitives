// Algebra.Z.Modulo+Ring.swift

/// Commutative ring witness for Z/nZ.
///
/// Returns nil if `(n-1)*(n-1)` overflows `Int`. When non-nil,
/// all ring operations are total (no overflow possible).
extension Algebra.Z.Modulo {
    @inlinable
    public static var ring: Algebra.Ring<Self>.Commutative? {
        guard n > 0 else { return nil }
        let (_, overflow) = (n - 1).multipliedReportingOverflow(by: n - 1)
        guard !overflow else { return nil }
        return .init(ring: .init(
            additive: .init(group: .init(
                identity: .zero,
                combining: { $0 + $1 },
                inverting: { $0.negated }
            )),
            multiplicative: .init(
                identity: .one,
                combining: { lhs, rhs in
                    .init(__unchecked: (lhs.residue * rhs.residue) % n)
                }
            )
        ))
    }
}
