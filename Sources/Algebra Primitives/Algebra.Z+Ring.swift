// Algebra.Z+Ring.swift

/// Commutative ring witness for Z/nZ.
///
/// Returns nil if n <= 0 or if `(n-1)*(n-1)` overflows `UInt`. When non-nil,
/// all ring operations are total (no overflow possible).
extension Tagged where Tag: Algebra.Residual, RawValue == Ordinal {
    @inlinable
    public static var ring: Algebra.Ring<Self>.Commutative? {
        let n = Tag.capacity
        guard n > 0 else { return nil }
        let maxResidue = UInt(n - 1)
        let (_, overflow) = maxResidue.multipliedReportingOverflow(by: maxResidue)
        guard !overflow else { return nil }
        let modulus = UInt(n)
        return .init(ring: .init(
            additive: .init(group: .init(
                identity: .zero,
                combining: { $0 + $1 },
                inverting: { $0.negated }
            )),
            multiplicative: .init(
                identity: .one,
                combining: { lhs, rhs in
                    let a = lhs.rawValue.rawValue
                    let b = rhs.rawValue.rawValue
                    return Self(__unchecked: (), Ordinal((a * b) % modulus))
                }
            )
        ))
    }
}
